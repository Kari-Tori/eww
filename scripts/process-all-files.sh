#!/usr/bin/env bash
# process-all-files.sh - Masowe przetwarzanie wszystkich plików MD z AI tagowaniem
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Kolory dla progress
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Liczniki
TOTAL_FILES=0
PROCESSED=0
ERRORS=0
UPDATED=0

# Progress bar z tagami
progress_bar() {
    local current=$1
    local total=$2
    local tags_str="$3"
    local width=40
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    
    printf "\r${BLUE}[${GREEN}"
    printf "%${completed}s" | tr ' ' '█'
    printf "${BLUE}"
    printf "%$((width - completed))s" | tr ' ' '░'
    printf "${BLUE}]${NC} %3d%% ${YELLOW}%d/%d${NC} ${CYAN}| %s${NC}" \
        "$percentage" "$current" "$total" "$tags_str"
}

# Generuj tagi AI na podstawie kontekstu pliku
generate_ai_tags() {
    local file="$1"
    local tags=()
    
    # Czytaj pierwsze 100 linii dla kontekstu
    local content=$(head -100 "$file" 2>/dev/null | tr '[:upper:]' '[:lower:]')
    
    # Tagi na podstawie ścieżki (priorytet!)
    if [[ "$file" == *"/usr/jakubc/"* ]]; then
        tags+=("#jakubc")
    fi
    if [[ "$file" == *"/usr/karinam/"* ]]; then
        tags+=("#karinam")
    fi
    if [[ "$file" == *"/business/"* ]]; then
        tags+=("#business")
    fi
    if [[ "$file" == *"/core/"* ]]; then
        tags+=("#core")
    fi
    if [[ "$file" == *"/config/"* ]]; then
        tags+=("#config")
    fi
    if [[ "$file" == *"/docs/"* ]]; then
        tags+=("#documentation")
    fi
    if [[ "$file" == *"/infra/"* ]]; then
        tags+=("#infrastructure")
    fi
    if [[ "$file" == *"/tools/"* ]]; then
        tags+=("#tools")
    fi
    if [[ "$file" == *"/scripts/"* ]]; then
        tags+=("#automation")
    fi
    if [[ "$file" == *"/dev/"* ]]; then
        tags+=("#development")
    fi
    if [[ "$file" == *"/var/"* ]]; then
        tags+=("#data")
    fi
    
    # Tagi na podstawie zawartości
    if echo "$content" | grep -qE "star.wars|yoda|vader|jedi|sith|skywalker"; then
        tags+=("#star-wars")
    fi
    if echo "$content" | grep -qE "recykl|e-waste|elektro|odpad"; then
        tags+=("#recycling")
    fi
    if echo "$content" | grep -qE "lego|klocki"; then
        tags+=("#lego")
    fi
    if echo "$content" | grep -qE "avocado|awokado"; then
        tags+=("#avocado")
    fi
    if echo "$content" | grep -qE "setup|install|config|konfigur"; then
        tags+=("#setup")
    fi
    if echo "$content" | grep -qE "obsidian|vault|plugin|waypoint"; then
        tags+=("#obsidian")
    fi
    if echo "$content" | grep -qE "git|commit|version|repo"; then
        tags+=("#git")
    fi
    if echo "$content" | grep -qE "graph|visual|map|diagram"; then
        tags+=("#graph")
    fi
    if echo "$content" | grep -qE "bash|shell|script|#!/"; then
        tags+=("#bash")
    fi
    if echo "$content" | grep -qE "test|bats|spec"; then
        tags+=("#testing")
    fi
    
    # Zawsze dodaj #eww
    tags+=("#eww")
    
    # Usuń duplikaty i ogranicz do 7
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    
    # Jeśli mniej niż 7, uzupełnij generycznymi
    while [ ${#unique_tags[@]} -lt 7 ]; do
        if [[ ! " ${unique_tags[@]} " =~ " #index " ]]; then
            unique_tags+=("#index")
        elif [[ ! " ${unique_tags[@]} " =~ " #note " ]]; then
            unique_tags+=("#note")
        else
            unique_tags+=("#misc")
        fi
    done
    
    # Zwróć dokładnie 7 tagów
    printf '%s\n' "${unique_tags[@]:0:7}"
}

# Funkcja dodająca/aktualizująca YAML frontmatter
add_yaml_frontmatter() {
    local file="$1"
    shift
    local tags=("$@")
    
    # Pobierz daty
    local created_date=$(git log --follow --format=%aI --reverse "$file" 2>/dev/null | head -1 | cut -dT -f1)
    [ -z "$created_date" ] && created_date=$(stat -c %y "$file" | cut -d' ' -f1)
    local modified_date=$(date -I)
    local author=$(git log --follow --format=%an --reverse "$file" 2>/dev/null | head -1)
    [ -z "$author" ] && author="jakubc"
    
    # Wykryj istniejący frontmatter
    if head -n1 "$file" | grep -q "^---$"; then
        return 1  # Ma już frontmatter, pomijamy
    fi
    
    # Generuj nowy frontmatter
    local temp_file=$(mktemp)
    {
        echo "---"
        echo "created: $created_date"
        echo "modified: $modified_date"
        echo "author: $author"
        echo "tags:"
        for tag in "${tags[@]}"; do
            echo "  - $tag"
        done
        echo "---"
        echo ""
        cat "$file"
    } > "$temp_file"
    
    mv "$temp_file" "$file"
    return 0
}

# Główna pętla przetwarzania
main() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  ${YELLOW}AI-POWERED MASOWE PRZETWARZANIE PLIKÓW MD${NC}          ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Zlicz wszystkie pliki
    TOTAL_FILES=$(find "$REPO_ROOT" -type f -name "*.md" ! -path "*/.git/*" ! -path "*/.obsidian/*" | wc -l)
    echo -e "${YELLOW}📁 Znaleziono: ${BLUE}$TOTAL_FILES${NC} plików MD"
    echo -e "${YELLOW}🤖 Generowanie tagów AI na podstawie kontekstu...${NC}"
    echo ""
    
    # Przetwarzaj każdy plik
    while IFS= read -r file; do
        ((PROCESSED++)) || true
        
        # Generuj tagi AI
        local tags_array=($(generate_ai_tags "$file"))
        
        # Format tagów do wyświetlenia
        local tags_display="${tags_array[*]}"
        tags_display="${tags_display// /, }"
        
        # Przetwórz plik
        if add_yaml_frontmatter "$file" "${tags_array[@]}"; then
            ((UPDATED++)) || true
            progress_bar "$PROCESSED" "$TOTAL_FILES" "$tags_display"
        else
            # Plik ma już frontmatter
            progress_bar "$PROCESSED" "$TOTAL_FILES" "skipped"
        fi
        
        # Co 50 plików pokaż podsumowanie
        if ((PROCESSED % 50 == 0)); then
            echo ""
            echo -e "  ${GREEN}✓${NC} Checkpoint: ${YELLOW}$UPDATED${NC} zaktualizowanych, ${BLUE}$((PROCESSED - UPDATED))${NC} pominiętych"
        fi
        
    done < <(find "$REPO_ROOT" -type f -name "*.md" ! -path "*/.git/*" ! -path "*/.obsidian/*" | sort)
    
    echo ""
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${YELLOW}✅ PRZETWARZANIE ZAKOŃCZONE!${NC}                          ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  📊 ${BLUE}Przetworzono:${NC}      ${YELLOW}$PROCESSED${NC}/$TOTAL_FILES plików"
    echo -e "  ✨ ${BLUE}Zaktualizowano:${NC}    ${GREEN}$UPDATED${NC} plików"
    echo -e "  ⏭️  ${BLUE}Pominięto:${NC}        ${CYAN}$((PROCESSED - UPDATED))${NC} plików (już mają frontmatter)"
    echo -e "  ❌ ${BLUE}Błędów:${NC}           ${RED}$ERRORS${NC}"
    echo ""
}

main "$@"
