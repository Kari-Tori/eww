#!/usr/bin/env bash
# Auto-tag wszystkich plików MD z kontekstem AI
set -euo pipefail

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly TOTAL_FILES=$(find "$REPO_ROOT" -name "*.md" -type f | wc -l)
readonly LOG_FILE="$REPO_ROOT/var/tagging-progress.log"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Inicjalizacja logu
mkdir -p "$REPO_ROOT/var"
echo "=== AUTO-TAGGING START: $(date) ===" > "$LOG_FILE"
echo "Total files: $TOTAL_FILES" >> "$LOG_FILE"

# Funkcja: analiza kontekstu pliku i generowanie tagów
analyze_and_tag() {
    local file="$1"
    local counter="$2"
    
    # Wyciągnij istniejące dane
    local filename=$(basename "$file" .md)
    local dirname=$(dirname "$file" | sed "s|$REPO_ROOT/||")
    local content=$(head -50 "$file" 2>/dev/null || echo "")
    
    # Generuj tagi na podstawie kontekstu
    local tags=()
    
    # 1. Tag bazowy z lokalizacji
    if [[ "$dirname" =~ usr/jakubc ]]; then
        tags+=("jakubc")
    elif [[ "$dirname" =~ usr/karinam ]]; then
        tags+=("karinam")
    elif [[ "$dirname" =~ business ]]; then
        tags+=("business")
    elif [[ "$dirname" =~ core ]]; then
        tags+=("core")
    elif [[ "$dirname" =~ config ]]; then
        tags+=("config")
    elif [[ "$dirname" =~ docs ]]; then
        tags+=("docs")
    elif [[ "$dirname" =~ infra ]]; then
        tags+=("infra")
    elif [[ "$dirname" =~ tools ]]; then
        tags+=("tools")
    elif [[ "$dirname" =~ scripts ]]; then
        tags+=("scripts")
    else
        tags+=("eww")
    fi
    
    # 2-7. Analiza zawartości (AI-like context analysis)
    if echo "$content" | grep -qiE "(recycl|waste|e-waste|elektronik)"; then
        tags+=("recycling")
    fi
    if echo "$content" | grep -qiE "(star.?wars|jedi|sith|force)"; then
        tags+=("star-wars")
    fi
    if echo "$content" | grep -qiE "(lego|brick|minifig)"; then
        tags+=("lego")
    fi
    if echo "$content" | grep -qiE "(graph|visual|diagram|map)"; then
        tags+=("visualization")
    fi
    if echo "$content" | grep -qiE "(bash|script|shell|\.sh)"; then
        tags+=("scripting")
    fi
    if echo "$content" | grep -qiE "(git|commit|repo|version)"; then
        tags+=("git")
    fi
    if echo "$content" | grep -qiE "(obsidian|vault|plugin|waypoint)"; then
        tags+=("obsidian")
    fi
    if echo "$content" | grep -qiE "(config|setup|install|init)"; then
        tags+=("configuration")
    fi
    if echo "$content" | grep -qiE "(index|toc|lista|spis)"; then
        tags+=("index")
    fi
    if echo "$content" | grep -qiE "(portfolio|project|showcase)"; then
        tags+=("portfolio")
    fi
    if echo "$content" | grep -qiE "(dev|develop|code|programming)"; then
        tags+=("development")
    fi
    if echo "$content" | grep -qiE "(avocado|food|recipe)"; then
        tags+=("avocado")
    fi
    if echo "$content" | grep -qiE "(art|design|creative)"; then
        tags+=("creative")
    fi
    if echo "$content" | grep -qiE "(note|folder.?note|opis)"; then
        tags+=("folder-note")
    fi
    
    # Uzupełnij do 7 tagów
    while [[ ${#tags[@]} -lt 7 ]]; do
        # Dodaj generyczne tagi
        if [[ ! " ${tags[@]} " =~ " documentation " ]]; then
            tags+=("documentation")
        elif [[ ! " ${tags[@]} " =~ " meta " ]]; then
            tags+=("meta")
        elif [[ ! " ${tags[@]} " =~ " reference " ]]; then
            tags+=("reference")
        elif [[ ! " ${tags[@]} " =~ " archive " ]]; then
            tags+=("archive")
        elif [[ ! " ${tags[@]} " =~ " utility " ]]; then
            tags+=("utility")
        else
            tags+=("misc")
        fi
    done
    
    # Ogranicz do 7
    tags=("${tags[@]:0:7}")
    
    # Wyświetl progress
    printf "${GREEN}[%d/%d]${NC} ${BLUE}%s${NC} → Tags: ${YELLOW}%s${NC}\n" \
        "$counter" "$TOTAL_FILES" "$file" "${tags[*]}"
    
    # Zapisz do logu
    echo "[$counter/$TOTAL_FILES] $file → ${tags[*]}" >> "$LOG_FILE"
    
    # Zwróć tagi (dla dalszego przetwarzania)
    echo "${tags[@]}"
}

# Main loop
counter=0
find "$REPO_ROOT" -name "*.md" -type f | while read -r file; do
    ((counter++))
    tags=$(analyze_and_tag "$file" "$counter")
    # TODO: Zastosuj tagi do YAML frontmatter
done

echo -e "\n${GREEN}✅ GOTOWE!${NC} Przeanalizowano $TOTAL_FILES plików"
echo "Log: $LOG_FILE"
