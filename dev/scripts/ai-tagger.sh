#!/usr/bin/env bash
# AI Auto-Tagger - Automatyczne tagowanie plików MD przez Ollama
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly LOG_FILE="$REPO_ROOT/var/ai-tagger.log"
readonly PROGRESS_FILE="$REPO_ROOT/var/ai-tagger-progress.txt"
readonly TAGS_DB="$REPO_ROOT/var/all-tags.json"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Statystyki
TOTAL_FILES=0
PROCESSED_FILES=0
CURRENT_TAGS=0

# Inicjalizacja
init() {
    mkdir -p "$REPO_ROOT/var"
    echo "0" > "$PROGRESS_FILE"
    echo "[]" > "$TAGS_DB"
    
    # Zlicz wszystkie pliki MD
    TOTAL_FILES=$(find "$REPO_ROOT" -name "*.md" -type f \
        ! -path "*/.git/*" \
        ! -path "*/archive/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/node_modules/*" | wc -l)
    
    echo -e "${BLUE}[AI-TAGGER]${NC} Znaleziono ${YELLOW}${TOTAL_FILES}${NC} plików MD"
}

# Usunięcie wszystkich tagów z pliku
strip_tags() {
    local file="$1"
    
    # Tymczasowy plik
    local tmp_file="${file}.tmp"
    
    # Usuń sekcję tags z frontmatter
    awk '
        BEGIN { in_frontmatter=0; in_tags=0 }
        /^---$/ { 
            if (NR==1) { in_frontmatter=1; print; next }
            if (in_frontmatter) { in_frontmatter=0; in_tags=0; print; next }
        }
        in_frontmatter && /^tags:/ { in_tags=1; next }
        in_frontmatter && in_tags && /^  -/ { next }
        in_frontmatter && in_tags && /^[a-zA-Z]/ { in_tags=0 }
        { print }
    ' "$file" > "$tmp_file"
    
    mv "$tmp_file" "$file"
}

# Generowanie tagów przez Ollama
generate_tags() {
    local file="$1"
    local content
    local context
    local tags_json
    
    # Przeczytaj zawartość pliku
    content=$(cat "$file")
    
    # Przygotuj kontekst dla AI
    local filename=$(basename "$file" .md)
    local dirname=$(dirname "$file" | sed "s|$REPO_ROOT/||")
    
    # Wywołanie Ollama API
    local prompt="Przeanalizuj plik Markdown i wygeneruj dokładnie 7 tagów opisujących jego zawartość.

Plik: $filename
Lokalizacja: $dirname
Zawartość:
---
${content:0:2000}
---

ZASADY TAGOWANIA:
- Generuj DOKŁADNIE 7 tagów
- Tagi w formacie: #tag-name (małe litery, myślniki)
- Tagi opisują: cel, technologię, kategorię, status
- Priorytetowe grupy: #eww, #jakubc, #karinam, #recycling, #star-wars, #lego, #avocado
- Dodatkowe tagi z kontekstu: #setup, #config, #docs, #script, #core, #infra, #business, #tools

Zwróć TYLKO listę 7 tagów, jeden na linię, bez numeracji:"

    # Wywołaj Ollama
    tags_json=$(curl -s http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"llama3.2:3b\",
            \"prompt\": $(echo "$prompt" | jq -Rs .),
            \"stream\": false,
            \"temperature\": 0.3
        }" | jq -r '.response' || echo "")
    
    # Parsuj odpowiedź
    local tags=()
    while IFS= read -r line; do
        # Wyciągnij tag (usuń numerację, białe znaki, etc)
        tag=$(echo "$line" | grep -oE '#[a-z0-9-]+' | head -1)
        if [[ -n "$tag" ]]; then
            tags+=("$tag")
        fi
    done <<< "$tags_json"
    
    # Upewnij się że mamy dokładnie 7 tagów
    while [[ ${#tags[@]} -lt 7 ]]; do
        tags+=("#general")
    done
    
    # Ogranicz do 7
    tags=("${tags[@]:0:7}")
    
    echo "${tags[@]}"
}

# Dodanie tagów do pliku
add_tags_to_file() {
    local file="$1"
    shift
    local tags=("$@")
    
    # Sprawdź czy plik ma frontmatter
    if ! head -1 "$file" | grep -q "^---$"; then
        # Dodaj frontmatter
        {
            echo "---"
            echo "tags:"
            for tag in "${tags[@]}"; do
                echo "  - $tag"
            done
            echo "---"
            echo ""
            cat "$file"
        } > "${file}.tmp"
        mv "${file}.tmp" "$file"
    else
        # Wstaw tagi do istniejącego frontmatter
        awk -v tags="${tags[*]}" '
            BEGIN { 
                split(tags, tag_arr, " ")
                in_frontmatter=0
                tags_inserted=0
            }
            /^---$/ { 
                if (NR==1) { in_frontmatter=1; print; next }
                if (in_frontmatter && !tags_inserted) {
                    print "tags:"
                    for (i in tag_arr) {
                        print "  - " tag_arr[i]
                    }
                    tags_inserted=1
                }
                in_frontmatter=0
                print
                next
            }
            { print }
        ' "$file" > "${file}.tmp"
        mv "${file}.tmp" "$file"
    fi
}

# Zapisz tagi do bazy
save_tags_to_db() {
    local tags=("$@")
    local current_db
    
    current_db=$(cat "$TAGS_DB")
    
    for tag in "${tags[@]}"; do
        # Dodaj tag jeśli nie istnieje
        if ! echo "$current_db" | jq -e ". | index(\"$tag\")" > /dev/null 2>&1; then
            current_db=$(echo "$current_db" | jq ". + [\"$tag\"]")
        fi
    done
    
    echo "$current_db" | jq 'sort | unique' > "$TAGS_DB"
}

# Przetwarzanie pojedynczego pliku
process_file() {
    local file="$1"
    local relative_path="${file#$REPO_ROOT/}"
    
    echo -e "${BLUE}[${PROCESSED_FILES}/${TOTAL_FILES}]${NC} Przetwarzam: ${relative_path}"
    
    # 1. Usuń stare tagi
    strip_tags "$file"
    
    # 2. Wygeneruj nowe tagi przez AI
    local tags
    tags=($(generate_tags "$file"))
    
    # 3. Dodaj tagi do pliku
    add_tags_to_file "$file" "${tags[@]}"
    
    # 4. Zapisz do bazy
    save_tags_to_db "${tags[@]}"
    
    # 5. Pokaż wygenerowane tagi
    echo -e "   ${GREEN}✓${NC} Tagi: ${YELLOW}${tags[*]}${NC}"
    
    # 6. Aktualizuj progress
    ((PROCESSED_FILES++)) || true
    echo "$PROCESSED_FILES" > "$PROGRESS_FILE"
    
    # Log
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $relative_path | ${tags[*]}" >> "$LOG_FILE"
}

# Progress bar
show_progress() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))
    
    printf "\r${BLUE}Progress:${NC} ["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] ${YELLOW}%3d%%${NC} (${current}/${total})" "$percent"
}

# Main
main() {
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║    AI AUTO-TAGGER (Ollama + LLaMA)     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    # Sprawdź Ollama
    if ! curl -s http://localhost:11434/api/tags > /dev/null; then
        echo -e "${RED}✗ Ollama nie działa!${NC}"
        echo "Uruchom: ollama serve"
        exit 1
    fi
    
    echo -e "${GREEN}✓${NC} Ollama działa"
    
    # Inicjalizacja
    init
    
    # Znajdź wszystkie pliki
    local files=()
    while IFS= read -r file; do
        files+=("$file")
    done < <(find "$REPO_ROOT" -name "*.md" -type f \
        ! -path "*/.git/*" \
        ! -path "*/archive/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/node_modules/*" | sort)
    
    echo -e "${BLUE}Rozpoczynam przetwarzanie...${NC}"
    echo ""
    
    # Przetwarzaj każdy plik
    for file in "${files[@]}"; do
        process_file "$file"
        
        # Progress bar co 10 plików
        if [[ $((PROCESSED_FILES % 10)) -eq 0 ]]; then
            show_progress "$PROCESSED_FILES" "$TOTAL_FILES"
        fi
        
        # Krótka pauza żeby nie zabić API
        sleep 0.2
    done
    
    echo ""
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║            GOTOWE! ✓                   ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Statystyki:${NC}"
    echo -e "  Plików przetworzonych: ${YELLOW}${PROCESSED_FILES}${NC}"
    echo -e "  Unikalnych tagów: ${YELLOW}$(jq 'length' "$TAGS_DB")${NC}"
    echo ""
    echo -e "  Baza tagów: ${TAGS_DB}"
    echo -e "  Log: ${LOG_FILE}"
    echo ""
    
    # Pokaż top 20 tagów
    echo -e "${BLUE}Top 20 tagów:${NC}"
    jq -r '.[]' "$TAGS_DB" | head -20 | nl
}

main "$@"
