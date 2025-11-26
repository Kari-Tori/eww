#!/usr/bin/env bash
# AI Auto-tagger - usuwa stare tagi i generuje nowe z AI
set -euo pipefail

readonly VAULT="/home/jakubc/git/eww"
readonly LOG_FILE="/tmp/ai-tag-progress.log"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Liczniki
total_files=0
processed=0

# Funkcja: usuń wszystkie tagi z pliku
remove_all_tags() {
    local file="$1"
    
    # Usuń linię tags: z frontmatter
    sed -i '/^tags:/d' "$file"
    sed -i '/^  - #/d' "$file"
}

# Funkcja: wygeneruj tagi AI (placeholder - będzie przez Continue/Ollama)
generate_ai_tags() {
    local file="$1"
    local context
    
    # Pobierz kontekst (pierwsze 500 znaków)
    context=$(head -c 500 "$file" | tr '\n' ' ')
    
    # TODO: Tutaj będzie wywołanie Continue/Ollama
    # Na razie placeholder
    echo "  - #placeholder-ai-tag-1"
    echo "  - #placeholder-ai-tag-2"
}

# Główna logika
main() {
    echo -e "${BLUE}=== AI AUTO-TAGGER - Czyszczenie i regeneracja ===${NC}"
    
    # Policz wszystkie pliki
    total_files=$(find "$VAULT" -type f -name "*.md" | wc -l)
    echo -e "${YELLOW}Znaleziono: $total_files plików MD${NC}"
    
    # Przetwarzaj każdy plik
    while IFS= read -r file; do
        ((processed++))
        
        # Progress bar
        local percent=$((processed * 100 / total_files))
        printf "\r${GREEN}[$processed/$total_files]${NC} ${YELLOW}%3d%%${NC} %s" \
            "$percent" "$(basename "$file")"
        
        # 1. Usuń stare tagi
        remove_all_tags "$file"
        
        # 2. Wygeneruj nowe (placeholder)
        # generate_ai_tags "$file"
        
        # Log
        echo "[$processed/$total_files] $(basename "$file")" >> "$LOG_FILE"
        
    done < <(find "$VAULT" -type f -name "*.md")
    
    echo -e "\n${GREEN}✅ Gotowe! Wyczyszczono tagi z $processed plików${NC}"
    echo -e "${YELLOW}Log: $LOG_FILE${NC}"
}

main "$@"
