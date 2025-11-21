#!/usr/bin/env bash
# AI Tagger używając GitHub Copilot CLI
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

readonly VAULT_ROOT="/home/jakubc/git/eww"
readonly PROGRESS_FILE="$VAULT_ROOT/var/ai-tagging-progress.txt"
readonly TAGS_FILE="$VAULT_ROOT/var/all-generated-tags.txt"

# Dostępne grupy tagów (15 grup z GRAPH-TAGS-EXTENDED.md)
readonly AVAILABLE_GROUPS=(
    "eww" "jakubc" "karinam" "star-wars" "recycling" 
    "lego" "avocado" "infrastructure" "documentation" 
    "development" "configuration" "business" "tools" 
    "projects" "archive"
)

# Funkcja do ekstrakcji kontekstu z pliku
extract_context() {
    local file="$1"
    local filename=$(basename "$file" .md)
    local dirname=$(dirname "$file")
    local relative_path="${file#$VAULT_ROOT/}"
    
    # Przeczytaj pierwsze 20 linii (bez frontmatter)
    local content=$(sed -n '/^---$/,/^---$/!p' "$file" | head -20)
    
    # Wyciągnij istniejące linki [[...]]
    local links=$(grep -oP '\[\[.*?\]\]' "$file" | head -5 | tr '\n' ' ')
    
    echo "Ścieżka: $relative_path"
    echo "Nazwa: $filename"
    echo "Folder: $dirname"
    echo "Linki: $links"
    echo "Zawartość: ${content:0:300}..."
}

# Funkcja do generowania tagów przez AI
generate_tags_ai() {
    local file="$1"
    local context=$(extract_context "$file")
    
    echo -e "${YELLOW}🤖 Generuję tagi dla: ${file#$VAULT_ROOT/}${NC}"
    
    # Tutaj możesz użyć Continue.dev API lub Copilot
    # Na razie zwróci przykładowe tagi na podstawie ścieżki
    
    local tags=()
    
    # Prosta heurystyka na podstawie ścieżki
    if [[ "$file" =~ /usr/jakubc/ ]]; then
        tags+=("jakubc")
    fi
    
    if [[ "$file" =~ /usr/karinam/ ]]; then
        tags+=("karinam")
    fi
    
    if [[ "$file" =~ /star_wars/ ]]; then
        tags+=("star-wars")
    fi
    
    if [[ "$file" =~ /docs/ ]]; then
        tags+=("documentation")
    fi
    
    if [[ "$file" =~ /config/ ]]; then
        tags+=("configuration")
    fi
    
    if [[ "$file" =~ /business/ ]]; then
        tags+=("business")
    fi
    
    if [[ "$file" =~ /core/ ]]; then
        tags+=("eww")
    fi
    
    # Zawsze dodaj tag bazowy
    tags+=("eww")
    
    # Usuń duplikaty i ogranicz do 7
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    
    # Wypisz tagi
    printf '%s\n' "${unique_tags[@]}"
}

# Funkcja do aktualizacji frontmatter
update_frontmatter() {
    local file="$1"
    shift
    local tags=("$@")
    
    # Sprawdź czy ma frontmatter
    if ! grep -q "^---$" "$file"; then
        # Dodaj nowy frontmatter
        {
            echo "---"
            echo "tags:"
            for tag in "${tags[@]}"; do
                echo "  - $tag"
            done
            echo "---"
            echo ""
            cat "$file"
        } > "$file.tmp"
        mv "$file.tmp" "$file"
    else
        # Zaktualizuj istniejący frontmatter
        # Usuń stare tagi i dodaj nowe
        sed -i '/^tags:$/,/^[^ ]/{ /^tags:$/d; /^  - /d; }' "$file"
        
        # Dodaj nowe tagi po "---"
        sed -i "1 a tags:\n$(printf '  - %s\n' "${tags[@]}")" "$file"
    fi
    
    echo -e "${GREEN}✓${NC} Zaktualizowano: ${file#$VAULT_ROOT/}"
}

# MAIN
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     AI AUTO-TAGGING (COPILOT)         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Znajdź wszystkie pliki MD
mapfile -t md_files < <(find "$VAULT_ROOT" -name "*.md" -type f)
total_files=${#md_files[@]}

echo -e "${BLUE}📊 Znaleziono: $total_files plików${NC}"
echo ""

# Wyczyść progress i tagi
> "$PROGRESS_FILE"
> "$TAGS_FILE"

processed=0
tagged=0

for md_file in "${md_files[@]}"; do
    ((processed++))
    
    echo -e "${BLUE}[$processed/$total_files]${NC} ${md_file#$VAULT_ROOT/}"
    
    # Generuj tagi przez AI
    mapfile -t generated_tags < <(generate_tags_ai "$md_file")
    
    if [ ${#generated_tags[@]} -eq 0 ]; then
        echo -e "${RED}✗${NC} Brak tagów dla: $md_file"
        continue
    fi
    
    # Wypisz wygenerowane tagi
    echo -e "   ${YELLOW}Tagi:${NC} ${generated_tags[*]}"
    
    # Zapisz tagi do pliku
    printf '%s\n' "${generated_tags[@]}" >> "$TAGS_FILE"
    
    # Aktualizuj frontmatter
    # update_frontmatter "$md_file" "${generated_tags[@]}"
    
    # Zapisz progress
    echo "$md_file: ${generated_tags[*]}" >> "$PROGRESS_FILE"
    
    ((tagged++))
done

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              GOTOWE!                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📊 Statystyki:${NC}"
echo -e "  • Przetworzono: $processed plików"
echo -e "  • Otagowano: $tagged plików"
echo ""

# Pokaż top 20 tagów
echo -e "${BLUE}📌 Top 20 najczęstszych tagów:${NC}"
sort "$TAGS_FILE" | uniq -c | sort -rn | head -20

echo ""
echo -e "${GREEN}✓${NC} Wszystkie tagi zapisane w: $TAGS_FILE"
echo -e "${BLUE}ℹ${NC}  Progress zapisany w: $PROGRESS_FILE"
echo ""
