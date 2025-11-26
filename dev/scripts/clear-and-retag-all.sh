#!/usr/bin/env bash
# clear-and-retag-all.sh - Wyczyść wszystkie tagi i wygeneruj nowe AI-based tags
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly TEMP_DIR="/tmp/eww-retag-$$"
readonly TAGS_LOG="$ROOT_DIR/ALL-TAGS-LIST.md"

mkdir -p "$TEMP_DIR"
trap 'rm -rf "$TEMP_DIR"' EXIT

# Kolory
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Zbierz wszystkie pliki MD (bez .obsidian)
mapfile -t MD_FILES < <(find "$ROOT_DIR" -name "*.md" -type f ! -path "*/.obsidian/*" | sort)
TOTAL="${#MD_FILES[@]}"

echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${CYAN}  CLEAR & RETAG: ${TOTAL} plików${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}\n"

# Funkcja: Wyczyść wszystkie tagi z pliku
clear_tags() {
    local file="$1"
    
    # Usuń linię tags: z frontmatter
    sed -i '/^tags:/d' "$file"
    
    # Usuń też linie z tagami w frontmatter (jeśli były w tablicy)
    sed -i '/^  - #/d' "$file"
}

# Funkcja: Generuj tagi na podstawie kontekstu
generate_contextual_tags() {
    local file="$1"
    local relative_path="${file#$ROOT_DIR/}"
    local basename="$(basename "$file" .md)"
    local dirname="$(dirname "$relative_path")"
    
    # Przeczytaj zawartość pliku (pierwsze 50 linii dla kontekstu)
    local content="$(head -n 50 "$file" 2>/dev/null || echo "")"
    
    # Analiza kontekstu i generowanie tagów
    local tags=()
    
    # 1. TAG Z GŁÓWNEGO FOLDERU
    if [[ "$dirname" == "usr/jakubc"* ]]; then
        tags+=("#jakubc")
    elif [[ "$dirname" == "usr/karinam"* ]]; then
        tags+=("#karinam")
    elif [[ "$dirname" == "business"* ]]; then
        tags+=("#business")
    elif [[ "$dirname" == "core"* ]]; then
        tags+=("#core")
    elif [[ "$dirname" == "config"* ]]; then
        tags+=("#config")
    elif [[ "$dirname" == "docs"* ]]; then
        tags+=("#documentation")
    elif [[ "$dirname" == "scripts"* ]]; then
        tags+=("#automation")
    elif [[ "$dirname" == "infra"* ]]; then
        tags+=("#infrastructure")
    elif [[ "$dirname" == "var"* ]]; then
        tags+=("#variable")
    elif [[ "$dirname" == "dev"* ]]; then
        tags+=("#development")
    else
        tags+=("#eww")
    fi
    
    # 2. TAG Z PODFOLDERU / KATEGORII
    if [[ "$dirname" =~ health ]]; then
        tags+=("#health")
    elif [[ "$dirname" =~ project ]]; then
        tags+=("#project")
    elif [[ "$dirname" =~ Inbox ]]; then
        tags+=("#inbox")
    elif [[ "$dirname" =~ m18 ]]; then
        tags+=("#m18")
    elif [[ "$dirname" =~ "obsidian-plugins" ]]; then
        tags+=("#obsidian-plugin")
    elif [[ "$dirname" =~ "star-wars" ]]; then
        tags+=("#star-wars")
    elif [[ "$dirname" =~ recycling ]]; then
        tags+=("#recycling")
    elif [[ "$dirname" =~ lego ]]; then
        tags+=("#lego")
    elif [[ "$dirname" =~ avocado ]]; then
        tags+=("#avocado")
    fi
    
    # 3. TAG Z NAZWY PLIKU
    if [[ "$basename" =~ INDEX|index ]]; then
        tags+=("#index")
    elif [[ "$basename" =~ GRAPH|graph ]]; then
        tags+=("#graph")
    elif [[ "$basename" =~ README|readme ]]; then
        tags+=("#readme")
    elif [[ "$basename" =~ setup|SETUP ]]; then
        tags+=("#setup")
    elif [[ "$basename" =~ config|CONFIG ]]; then
        tags+=("#configuration")
    fi
    
    # 4. TAGI Z TREŚCI (analiza słów kluczowych)
    if echo "$content" | grep -qi "obsidian"; then
        tags+=("#obsidian")
    fi
    
    if echo "$content" | grep -qi "vault"; then
        tags+=("#vault")
    fi
    
    if echo "$content" | grep -qi -E "git|commit|repository"; then
        tags+=("#git")
    fi
    
    if echo "$content" | grep -qi -E "script|bash|automation"; then
        tags+=("#automation")
    fi
    
    if echo "$content" | grep -qi -E "docker|kubernetes|k8s|waypoint"; then
        tags+=("#infrastructure")
    fi
    
    if echo "$content" | grep -qi -E "note|notes"; then
        tags+=("#notes")
    fi
    
    if echo "$content" | grep -qi -E "knowledge|learning"; then
        tags+=("#knowledge")
    fi
    
    if echo "$content" | grep -qi -E "personal|private"; then
        tags+=("#personal")
    fi
    
    if echo "$content" | grep -qi -E "api|backend|frontend|code"; then
        tags+=("#development")
    fi
    
    if echo "$content" | grep -qi -E "data|database|analytics"; then
        tags+=("#data")
    fi
    
    if echo "$content" | grep -qi -E "graph|visualization|diagram"; then
        tags+=("#visualization")
    fi
    
    if echo "$content" | grep -qi -E "tool|utility|helper"; then
        tags+=("#tools")
    fi
    
    if echo "$content" | grep -qi -E "plugin|extension|addon"; then
        tags+=("#plugin")
    fi
    
    if echo "$content" | grep -qi -E "template|scaffold|boilerplate"; then
        tags+=("#template")
    fi
    
    # 5. Usuń duplikaty i ogranicz do 7
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -n 7))
    
    # 6. Jeśli mniej niż 7, dodaj generyczne
    while [[ ${#unique_tags[@]} -lt 7 ]]; do
        if [[ ! " ${unique_tags[*]} " =~ " #notes " ]]; then
            unique_tags+=("#notes")
        elif [[ ! " ${unique_tags[*]} " =~ " #vault " ]]; then
            unique_tags+=("#vault")
        elif [[ ! " ${unique_tags[*]} " =~ " #knowledge " ]]; then
            unique_tags+=("#knowledge")
        elif [[ ! " ${unique_tags[*]} " =~ " #obsidian " ]]; then
            unique_tags+=("#obsidian")
        elif [[ ! " ${unique_tags[*]} " =~ " #documentation " ]]; then
            unique_tags+=("#documentation")
        elif [[ ! " ${unique_tags[*]} " =~ " #eww " ]]; then
            unique_tags+=("#eww")
        else
            unique_tags+=("#misc")
        fi
    done
    
    # Ogranicz do 7
    unique_tags=("${unique_tags[@]:0:7}")
    
    echo "${unique_tags[@]}"
}

# Funkcja: Dodaj tagi do frontmatter
add_tags_to_file() {
    local file="$1"
    shift
    local tags=("$@")
    
    # Sprawdź czy jest frontmatter
    if head -n 1 "$file" | grep -q "^---$"; then
        # Jest frontmatter, dodaj tags przed zamykającym ---
        local temp_file="$TEMP_DIR/$(basename "$file")"
        local in_frontmatter=0
        local tags_added=0
        
        while IFS= read -r line; do
            if [[ "$line" == "---" ]]; then
                if [[ $in_frontmatter -eq 0 ]]; then
                    echo "$line"
                    in_frontmatter=1
                else
                    # Dodaj tagi przed zamknięciem frontmatter
                    if [[ $tags_added -eq 0 ]]; then
                        echo "tags: [${tags[*]}]"
                        tags_added=1
                    fi
                    echo "$line"
                    in_frontmatter=0
                fi
            else
                echo "$line"
            fi
        done < "$file" > "$temp_file"
        
        mv "$temp_file" "$file"
    else
        # Brak frontmatter, dodaj nowy
        {
            echo "---"
            echo "tags: [${tags[*]}]"
            echo "---"
            echo ""
            cat "$file"
        } > "$TEMP_DIR/$(basename "$file")"
        mv "$TEMP_DIR/$(basename "$file")" "$file"
    fi
}

# Główna pętla
declare -A ALL_TAGS
PROCESSED=0

for file in "${MD_FILES[@]}"; do
    PROCESSED=$((PROCESSED + 1))
    relative_path="${file#$ROOT_DIR/}"
    
    # Wyczyść stare tagi
    clear_tags "$file"
    
    # Generuj nowe tagi
    tags_array=($(generate_contextual_tags "$file"))
    
    # Dodaj do pliku
    add_tags_to_file "$file" "${tags_array[@]}"
    
    # Zapisz do globalnej listy
    for tag in "${tags_array[@]}"; do
        ALL_TAGS["$tag"]=1
    done
    
    # Progress bar
    printf "${GREEN}[%4d/%4d]${NC} ${BLUE}%-60s${NC} ${YELLOW}%s${NC}\n" \
        "$PROCESSED" "$TOTAL" "$relative_path" "${tags_array[*]}"
done

# Zapisz listę wszystkich tagów
echo -e "\n${CYAN}════════════════════════════════════════${NC}"
echo -e "${CYAN}  Zapisuję listę wszystkich tagów...${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}\n"

{
    echo "---"
    echo "title: Wszystkie Tagi w Repozytorium"
    echo "date: $(date +%Y-%m-%d)"
    echo "tags: [#eww, #documentation, #index, #tags, #metadata, #vault, #obsidian]"
    echo "---"
    echo ""
    echo "# 🏷️ Wszystkie Tagi w Repozytorium EWW"
    echo ""
    echo "**Wygenerowano:** $(date '+%Y-%m-%d %H:%M:%S')"
    echo "**Liczba plików:** $TOTAL"
    echo "**Liczba unikalnych tagów:** ${#ALL_TAGS[@]}"
    echo ""
    echo "## 📋 Lista Tagów"
    echo ""
    
    for tag in $(printf '%s\n' "${!ALL_TAGS[@]}" | sort); do
        # Policz ile razy wystąpił
        count=$(grep -r "^tags:.*$tag" --include="*.md" "$ROOT_DIR" 2>/dev/null | wc -l)
        echo "- **$tag** - wystąpień: $count"
    done
    
} > "$TAGS_LOG"

echo -e "${GREEN}✅ GOTOWE!${NC}"
echo -e "${GREEN}   Przetworzone pliki: ${TOTAL}${NC}"
echo -e "${GREEN}   Unikalne tagi: ${#ALL_TAGS[@]}${NC}"
echo -e "${GREEN}   Lista tagów: ${TAGS_LOG}${NC}\n"
