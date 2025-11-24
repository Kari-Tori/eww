#!/usr/bin/env bash
# Fast AI Tagger - prosta i szybka wersja
set -euo pipefail

REPO="/home/jakubc/git/eww"
GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'

mkdir -p "$REPO/var"
TAGS_FILE="$REPO/var/all-tags-generated.txt"
> "$TAGS_FILE"

# Generuj tagi z kontekstu
gen_tags() {
    local file="$1"
    local tags=()
    local dir=$(dirname "$file")
    local content=$(head -50 "$file" 2>/dev/null | tr 'A-Z' 'a-z')
    
    # User
    [[ "$dir" == *"jakubc"* ]] && tags+=("#jakubc")
    [[ "$dir" == *"karinam"* ]] && tags+=("#karinam")
    
    # Kategoria
    [[ "$dir" == *"/core"* ]] && tags+=("#core")
    [[ "$dir" == *"/business"* ]] && tags+=("#business")
    [[ "$dir" == *"/config"* ]] && tags+=("#config")
    [[ "$dir" == *"/docs"* ]] && tags+=("#docs")
    [[ "$dir" == *"/infra"* ]] && tags+=("#infra")
    [[ "$dir" == *"/scripts"* ]] && tags+=("#scripts")
    [[ "$dir" == *"/tools"* ]] && tags+=("#tools")
    
    # Projekt
    grep -qi "star.wars\|anakin" <<< "$content" && tags+=("#star-wars")
    grep -qi "recycl\|recykling" <<< "$content" && tags+=("#recycling")
    grep -qi "lego" <<< "$content" && tags+=("#lego")
    grep -qi "avocado" <<< "$content" && tags+=("#avocado")
    
    # Typ
    grep -qi "setup\|install" <<< "$content" && tags+=("#setup")
    grep -qi "guide\|tutorial" <<< "$content" && tags+=("#guide")
    grep -qi "script\|bash" <<< "$content" && tags+=("#script")
    
    # Tech
    grep -qi "docker" <<< "$content" && tags+=("#docker")
    grep -qi "git\|github" <<< "$content" && tags+=("#git")
    grep -qi "obsidian" <<< "$content" && tags+=("#obsidian")
    grep -qi "python" <<< "$content" && tags+=("#python")
    
    # Default
    [[ ${#tags[@]} -eq 0 ]] && tags+=("#eww")
    
    # Wypełnij do 7
    while [[ ${#tags[@]} -lt 7 ]]; do
        tags+=("#general")
    done
    
    echo "${tags[@]:0:7}"
}

# Proces plik
process() {
    local f="$1"
    local tmp="$f.tmp"
    
    # Generuj tagi
    local new_tags=($(gen_tags "$f"))
    
    # Zapisz do bazy
    printf '%s\n' "${new_tags[@]}" >> "$TAGS_FILE"
    
    # Usuń stare tagi + dodaj nowe
    if head -1 "$f" | grep -q "^---$"; then
        # Ma frontmatter - zastąp tagi
        {
            echo "---"
            echo "tags:"
            printf '  - %s\n' "${new_tags[@]}"
            # Reszta frontmatter (pomijając stare tagi)
            awk '/^---$/{if(NR>1){p=1}} p && !/^tags:/ && !/^  -/' "$f"
            # Treść po frontmatter
            awk '/^---$/{if(c++)next} c>=2' "$f"
        } > "$tmp" 2>/dev/null && mv "$tmp" "$f" 2>/dev/null || rm -f "$tmp"
    else
        # Brak frontmatter - dodaj
        {
            echo "---"
            echo "tags:"
            printf '  - %s\n' "${new_tags[@]}"
            echo "---"
            echo ""
            cat "$f"
        } > "$tmp" && mv "$tmp" "$f"
    fi
}

# Main
echo -e "${GREEN}╔══════════════════════════════════╗${NC}"
echo -e "${GREEN}║     FAST AI TAGGER v2.0          ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════╝${NC}"

# Znajdź pliki
files=($(find "$REPO" -name "*.md" -type f \
    ! -path "*/.git/*" \
    ! -path "*/archive/*" \
    ! -path "*/.obsidian/*" | sort))

total=${#files[@]}
echo -e "${BLUE}Plików:${NC} ${YELLOW}$total${NC}"
echo ""

# Proces wszystkie
count=0
for f in "${files[@]}"; do
    process "$f" &
    ((count++))
    
    # Progress co 10
    if [[ $((count % 10)) -eq 0 ]]; then
        printf "\r${BLUE}[%3d%%]${NC} %d/%d" "$((count*100/total))" "$count" "$total"
    fi
    
    # Max 20 równoległych
    if [[ $((count % 20)) -eq 0 ]]; then
        wait
    fi
done
wait

echo ""
echo ""
echo -e "${GREEN}✓ GOTOWE!${NC}"
echo ""

# Stats
unique=$(sort "$TAGS_FILE" | uniq | wc -l)
echo -e "${BLUE}Statystyki:${NC}"
echo -e "  Plików: ${YELLOW}$count${NC}"
echo -e "  Unikalnych tagów: ${YELLOW}$unique${NC}"
echo ""

# Top 15
echo -e "${BLUE}Top 15 tagów:${NC}"
sort "$TAGS_FILE" | uniq -c | sort -rn | head -15 | nl
