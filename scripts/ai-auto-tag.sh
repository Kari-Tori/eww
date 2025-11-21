#!/usr/bin/env bash
set -euo pipefail

# AI Auto-Tag System dla Continue.dev + Ollama
# Przetwarza wszystkie pliki MD i generuje kontekstowe tagi

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly PROGRESS_FILE="/tmp/ai-tag-progress.txt"
readonly LOG_FILE="/tmp/ai-tag-log.txt"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Inicjalizacja
echo "0" > "$PROGRESS_FILE"
echo "=== AI Auto-Tag Start $(date) ===" > "$LOG_FILE"

# Funkcja: Wygeneruj tagi przez Continue API
generate_tags_via_continue() {
    local file="$1"
    local content
    content=$(cat "$file")
    
    # Prompt dla Continue.dev
    local prompt="Przeanalizuj ten plik Markdown i wygeneruj 7 kontekstowych tagów.
    
Plik: $file

Zawartość:
\`\`\`markdown
$content
\`\`\`

Zasady:
- Dokładnie 7 tagów
- Tagi opisują treść, technologie, obszar tematyczny
- Format: #tag-name (lowercase, kebab-case)
- Zwróć TYLKO listę tagów, każdy w nowej linii, bez numeracji

Przykład:
#kubernetes
#devops
#deployment
#cloud-native
#automation
#infrastructure
#monitoring"

    # Wywołaj Continue API (lokalnie przez Ollama)
    # Continue.dev używa lokalnego Ollamy - nie wysyła danych na zewnątrz
    curl -s -X POST http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"codellama:13b\",
            \"prompt\": $(jq -n --arg p "$prompt" '$p'),
            \"stream\": false
        }" | jq -r '.response' | grep '^#' | head -7
}

# Funkcja: Aktualizuj frontmatter
update_frontmatter() {
    local file="$1"
    shift
    local tags=("$@")
    
    # Usuń stary frontmatter jeśli istnieje
    if grep -q "^---$" "$file" 2>/dev/null; then
        sed -i '/^---$/,/^---$/d' "$file"
    fi
    
    # Stwórz nowy frontmatter
    local yaml="---\ntags:\n"
    for tag in "${tags[@]}"; do
        yaml+="  - $tag\n"
    done
    yaml+="created: $(stat -c %y "$file" | cut -d' ' -f1)\n"
    yaml+="modified: $(date +%Y-%m-%d)\n"
    yaml+="---\n\n"
    
    # Dodaj na początek pliku
    echo -e "$yaml$(cat "$file")" > "$file"
}

# Main processing loop
main() {
    cd "$REPO_ROOT"
    
    # Znajdź wszystkie pliki MD
    mapfile -t files < <(find . -name "*.md" -type f | sort)
    local total=${#files[@]}
    local current=0
    
    echo -e "${BLUE}🤖 AI Auto-Tag System${NC}"
    echo -e "${YELLOW}📊 Znaleziono: $total plików MD${NC}"
    echo -e "${YELLOW}⏱️  Szacowany czas: ~$((total * 5 / 60)) minut (5s/plik)${NC}"
    echo ""
    
    for file in "${files[@]}"; do
        current=$((current + 1))
        echo "$current" > "$PROGRESS_FILE"
        
        printf "${GREEN}[%3d/%d]${NC} Processing: %-60s " "$current" "$total" "$file"
        
        # Generuj tagi przez AI
        mapfile -t tags < <(generate_tags_via_continue "$file")
        
        # Waliduj - musi być 7 tagów
        if [ ${#tags[@]} -eq 7 ]; then
            update_frontmatter "$file" "${tags[@]}"
            echo -e "${GREEN}✓${NC} ${tags[*]}"
            echo "✓ $file: ${tags[*]}" >> "$LOG_FILE"
        else
            echo -e "${RED}✗ Błąd (${#tags[@]} tagów)${NC}"
            echo "✗ $file: ERROR - got ${#tags[@]} tags" >> "$LOG_FILE"
        fi
        
        # Progress bar
        local percent=$((current * 100 / total))
        printf "\r${BLUE}Progress: [%-50s] %d%%${NC}\n" \
            "$(printf '%*s' $((percent / 2)) | tr ' ' '=')" \
            "$percent"
    done
    
    echo ""
    echo -e "${GREEN}✅ Gotowe! Przetworzono: $total plików${NC}"
    echo -e "${BLUE}📝 Log: $LOG_FILE${NC}"
}

main "$@"
