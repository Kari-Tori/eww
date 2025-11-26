#!/usr/bin/env bash
set -euo pipefail

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

TOTAL_FILES=0
PROCESSED=0
ALL_TAGS_FILE="ALL-TAGS-LIST.md"

# Wyczyść poprzednie tagi
clear_all_tags() {
    echo -e "${YELLOW}[1/3] Czyszczenie wszystkich tagów z YAML frontmatter...${NC}"
    
    find . -name "*.md" -type f | while read -r file; do
        # Usuń tags: [...] z YAML
        sed -i '/^tags:/d' "$file"
        sed -i '/^  - #/d' "$file"
    done
    
    echo -e "${GREEN}✓ Tagi wyczyszczone${NC}"
}

# Generuj tagi przez AI (Continue + Ollama)
generate_tags_ai() {
    echo -e "${YELLOW}[2/3] Generowanie tagów AI (Continue + Ollama)...${NC}"
    
    TOTAL_FILES=$(find . -name "*.md" -type f | wc -l)
    PROCESSED=0
    
    > "$ALL_TAGS_FILE"
    echo "# Lista wszystkich wygenerowanych tagów" >> "$ALL_TAGS_FILE"
    echo "" >> "$ALL_TAGS_FILE"
    
    find . -name "*.md" -type f | while read -r file; do
        PROCESSED=$((PROCESSED + 1))
        
        # Progress bar
        printf "\r${BLUE}[%d/%d]${NC} Przetwarzam: %-60s" "$PROCESSED" "$TOTAL_FILES" "${file:0:60}"
        
        # TODO: Tutaj integracja z Continue API / Ollama
        # Na razie placeholder - będzie zamienione na prawdziwe wywołanie AI
        
        # Przykładowe tagi (do zastąpienia przez AI)
        TAGS=$(generate_contextual_tags "$file")
        
        # Dodaj tagi do pliku
        add_tags_to_file "$file" "$TAGS"
        
        # Zapisz do ALL-TAGS-LIST
        echo "$file: $TAGS" >> "$ALL_TAGS_FILE"
    done
    
    echo -e "\n${GREEN}✓ Tagi wygenerowane${NC}"
}

# Funkcja pomocnicza - generowanie tagów (placeholder)
generate_contextual_tags() {
    local file="$1"
    # TODO: Wywołanie Continue/Ollama API
    # Zwróć 7 tagów bazując na kontekście pliku
    echo "#tag1 #tag2 #tag3 #tag4 #tag5 #tag6 #tag7"
}

# Dodaj tagi do YAML frontmatter
add_tags_to_file() {
    local file="$1"
    local tags="$2"
    
    # Sprawdź czy ma frontmatter
    if ! head -n1 "$file" | grep -q "^---$"; then
        # Dodaj nowy frontmatter
        {
            echo "---"
            echo "tags:"
            for tag in $tags; do
                echo "  - $tag"
            done
            echo "---"
            echo ""
            cat "$file"
        } > "$file.tmp"
        mv "$file.tmp" "$file"
    else
        # Wstaw tagi do istniejącego frontmatter
        sed -i "/^---$/a tags:\n$(echo "$tags" | tr ' ' '\n' | sed 's/^/  - /')" "$file"
    fi
}

# Zbierz unikalne tagi i statystyki
collect_unique_tags() {
    echo -e "${YELLOW}[3/3] Zbieranie unikalnych tagów...${NC}"
    
    grep -h "^  - #" $(find . -name "*.md" -type f) 2>/dev/null | \
        sort | uniq -c | sort -rn > tags-statistics.txt
    
    local unique_count=$(wc -l < tags-statistics.txt)
    
    echo -e "${GREEN}✓ Znaleziono ${unique_count} unikalnych tagów${NC}"
    echo -e "${BLUE}Top 20 tagów:${NC}"
    head -n20 tags-statistics.txt
}

# Main
main() {
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  AI TAGGING MASTER - Continue+Ollama  ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    clear_all_tags
    generate_tags_ai
    collect_unique_tags
    
    echo -e "\n${GREEN}✅ GOTOWE!${NC}"
    echo -e "${BLUE}Pliki: ${TOTAL_FILES}${NC}"
    echo -e "${BLUE}Lista tagów: ${ALL_TAGS_FILE}${NC}"
}

main "$@"
