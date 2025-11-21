#!/usr/bin/env bash
# Prosty AI Tagger - bez Ollama, używa reguł kontekstowych
set -euo pipefail

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly PROGRESS_FILE="$REPO_ROOT/var/ai-progress.txt"
readonly TAGS_LIST="$REPO_ROOT/var/all-generated-tags.txt"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

TOTAL=0
CURRENT=0

# Generuj tagi na podstawie kontekstu
generate_contextual_tags() {
    local file="$1"
    local tags=()
    
    # Podstawowy kontekst
    local filename=$(basename "$file" .md)
    local dirpath=$(dirname "$file")
    local content=$(head -100 "$file" | tr '[:upper:]' '[:lower:]')
    
    # === GRUPA 1: Użytkownik ===
    if [[ "$dirpath" == *"/usr/jakubc"* ]]; then
        tags+=("#jakubc")
    elif [[ "$dirpath" == *"/usr/karinam"* ]]; then
        tags+=("#karinam")
    elif [[ "$dirpath" == *"/usr/"* ]]; then
        tags+=("#user")
    fi
    
    # === GRUPA 2: Główna kategoria ===
    if [[ "$dirpath" == *"/core"* ]]; then
        tags+=("#core")
    elif [[ "$dirpath" == *"/business"* ]]; then
        tags+=("#business")
    elif [[ "$dirpath" == *"/config"* ]]; then
        tags+=("#config")
    elif [[ "$dirpath" == *"/docs"* ]]; then
        tags+=("#docs")
    elif [[ "$dirpath" == *"/infra"* ]]; then
        tags+=("#infra")
    elif [[ "$dirpath" == *"/tools"* ]]; then
        tags+=("#tools")
    elif [[ "$dirpath" == *"/scripts"* ]]; then
        tags+=("#scripts")
    elif [[ "$dirpath" == *"/dev"* ]]; then
        tags+=("#dev")
    fi
    
    # === GRUPA 3: Projekt specjalny ===
    if echo "$content" | grep -qi "star.wars\|gwiezdne\|anakin\|vader"; then
        tags+=("#star-wars")
    elif echo "$content" | grep -qi "recycl\|recykling\|odzysk"; then
        tags+=("#recycling")
    elif echo "$content" | grep -qi "lego\|klocki"; then
        tags+=("#lego")
    elif echo "$content" | grep -qi "avocado\|awokado"; then
        tags+=("#avocado")
    fi
    
    # === GRUPA 4: Typ zawartości ===
    if echo "$content" | grep -qi "setup\|install\|konfiguracja"; then
        tags+=("#setup")
    elif echo "$content" | grep -qi "script\|bash\|#!/"; then
        tags+=("#script")
    elif echo "$content" | grep -qi "guide\|tutorial\|how.to\|instrukcja"; then
        tags+=("#guide")
    elif echo "$content" | grep -qi "reference\|api\|dokumentacja"; then
        tags+=("#reference")
    elif [[ "$filename" == "index" || "$filename" == "INDEX" ]]; then
        tags+=("#index")
    fi
    
    # === GRUPA 5: Technologia ===
    if echo "$content" | grep -qi "docker\|container"; then
        tags+=("#docker")
    elif echo "$content" | grep -qi "kubernetes\|k8s"; then
        tags+=("#k8s")
    elif echo "$content" | grep -qi "python\|\.py"; then
        tags+=("#python")
    elif echo "$content" | grep -qi "bash\|shell\|\.sh"; then
        tags+=("#bash")
    elif echo "$content" | grep -qi "javascript\|node\|npm"; then
        tags+=("#javascript")
    elif echo "$content" | grep -qi "git\|github\|commit"; then
        tags+=("#git")
    elif echo "$content" | grep -qi "obsidian\|vault\|graph"; then
        tags+=("#obsidian")
    fi
    
    # === GRUPA 6: Status ===
    if echo "$content" | grep -qi "wip\|todo\|in.progress"; then
        tags+=("#wip")
    elif echo "$content" | grep -qi "ready\|done\|complete"; then
        tags+=("#ready")
    elif echo "$content" | grep -qi "archive\|old\|deprecated"; then
        tags+=("#archived")
    fi
    
    # === GRUPA 7: Dodatkowy kontekst ===
    if echo "$content" | grep -qi "note\|notatka"; then
        tags+=("#note")
    elif echo "$content" | grep -qi "plan\|strategy\|strategia"; then
        tags+=("#plan")
    elif echo "$content" | grep -qi "fix\|bug\|problem"; then
        tags+=("#fix")
    elif echo "$content" | grep -qi "optimization\|performance\|optymalizacja"; then
        tags+=("#optimization")
    fi
    
    # Zawsze dodaj eww jako bazowy tag
    if [[ "${#tags[@]}" -lt 7 ]]; then
        tags+=("#eww")
    fi
    
    # Wypełnij do 7 tagów
    while [[ "${#tags[@]}" -lt 7 ]]; do
        tags+=("#general")
    done
    
    # Ogranicz do 7
    echo "${tags[@]:0:7}"
}

# Usuń stare tagi z frontmatter
strip_old_tags() {
    local file="$1"
    local tmp="${file}.tmp"
    
    awk '
        BEGIN { in_fm=0; in_tags=0; skip_line=0 }
        /^---$/ {
            if (NR==1) { in_fm=1; print; next }
            if (in_fm) { in_fm=0; in_tags=0; print; next }
        }
        in_fm && /^tags:/ { in_tags=1; next }
        in_fm && in_tags && /^  -/ { next }
        in_fm && in_tags && /^[a-z]/ { in_tags=0 }
        { print }
    ' "$file" > "$tmp" && mv "$tmp" "$file"
}

# Dodaj nowe tagi
add_new_tags() {
    local file="$1"
    shift
    local tags=("$@")
    local tmp="${file}.tmp"
    
    # Sprawdź czy ma frontmatter
    if ! head -1 "$file" | grep -q "^---$"; then
        # Stwórz nowy
        {
            echo "---"
            echo "tags:"
            printf '  - %s\n' "${tags[@]}"
            echo "---"
            echo ""
            cat "$file"
        } > "$tmp" && mv "$tmp" "$file"
    else
        # Wstaw tagi po pierwszym ---
        {
            head -1 "$file"  # pierwsze ---
            echo "tags:"
            printf '  - %s\n' "${tags[@]}"
            tail -n +2 "$file"  # reszta pliku od linii 2
        } > "$tmp" && mv "$tmp" "$file"
    fi
}

# Progress bar
progress_bar() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local bars=$((percent / 2))
    
    printf "\r${BLUE}[%3d%%]${NC} [" "$percent"
    printf "%${bars}s" | tr ' ' '█'
    printf "%$((50-bars))s" | tr ' ' '░'
    printf "] ${YELLOW}%d/%d${NC}" "$current" "$total"
}

# Proces pojedynczy plik
process_file() {
    local file="$1"
    local rel="${file#$REPO_ROOT/}"
    
    # 1. Usuń stare tagi
    strip_old_tags "$file"
    
    # 2. Generuj nowe
    local new_tags
    new_tags=($(generate_contextual_tags "$file"))
    
    # 3. Dodaj do pliku
    add_new_tags "$file" "${new_tags[@]}"
    
    # 4. Zapisz do listy
    printf '%s\n' "${new_tags[@]}" >> "$TAGS_LIST"
    
    # 5. Progress
    ((CURRENT++))
    
    # Pokaż co 5 plików
    if [[ $((CURRENT % 5)) -eq 0 ]]; then
        progress_bar "$CURRENT" "$TOTAL"
    fi
    
    # Debug co 50
    if [[ $((CURRENT % 50)) -eq 0 ]]; then
        echo ""
        echo -e "  ${GREEN}✓${NC} $rel → ${new_tags[*]}"
    fi
}

# Main
main() {
    echo -e "${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   AI AUTO-TAGGER (kontekstowy, bez Ollama)    ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    
    mkdir -p "$REPO_ROOT/var"
    > "$TAGS_LIST"
    > "$PROGRESS_FILE"
    
    # Znajdź pliki
    local files=()
    while IFS= read -r f; do
        files+=("$f")
    done < <(find "$REPO_ROOT" -name "*.md" -type f \
        ! -path "*/.git/*" \
        ! -path "*/archive/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/node_modules/*" | sort)
    
    TOTAL=${#files[@]}
    
    echo -e "${BLUE}Znaleziono:${NC} ${YELLOW}${TOTAL}${NC} plików"
    echo -e "${BLUE}Rozpoczynam...${NC}"
    echo ""
    
    # Proces
    for file in "${files[@]}"; do
        process_file "$file"
    done
    
    echo ""
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                  GOTOWE! ✓                    ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Statystyki
    local unique_tags=$(sort "$TAGS_LIST" | uniq | wc -l)
    echo -e "${BLUE}Statystyki:${NC}"
    echo -e "  Plików przetworzonych: ${YELLOW}${CURRENT}${NC}"
    echo -e "  Unikalnych tagów: ${YELLOW}${unique_tags}${NC}"
    echo ""
    
    # Top 20 tagów
    echo -e "${BLUE}Top 20 najpopularniejszych tagów:${NC}"
    sort "$TAGS_LIST" | uniq -c | sort -rn | head -20 | \
        awk '{printf "  %2d. %-20s (%d użyć)\n", NR, $2, $1}'
    
    echo ""
    echo "Lista wszystkich tagów: $TAGS_LIST"
}

# Uruchom tylko jeśli skrypt jest wykonywany bezpośrednio
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
