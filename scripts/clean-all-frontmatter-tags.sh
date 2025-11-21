#!/usr/bin/env bash
# Wyczyść wszystkie tagi z frontmatter we wszystkich plikach MD
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

readonly VAULT_ROOT="/home/jakubc/git/eww"
readonly PROGRESS_FILE="$VAULT_ROOT/var/clean-progress.txt"

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  CZYSZCZENIE TAGÓW Z FRONTMATTER       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Znajdź wszystkie pliki MD
mapfile -t md_files < <(find "$VAULT_ROOT" -name "*.md" -type f)
total_files=${#md_files[@]}

echo -e "${BLUE}📊 Znaleziono: $total_files plików MD${NC}"
echo ""

cleaned=0
skipped=0
errors=0

# Wyczyść progress
> "$PROGRESS_FILE"

for md_file in "${md_files[@]}"; do
    ((cleaned++))
    
    # Progress co 10 plików
    if (( cleaned % 10 == 0 )); then
        echo -e "${YELLOW}[$cleaned/$total_files]${NC} ${md_file#$VAULT_ROOT/}"
    fi
    
    # Sprawdź czy ma frontmatter
    if ! grep -q "^---$" "$md_file"; then
        ((skipped++))
        continue
    fi
    
    # Usuń linię "tags:" i wszystkie linie z tagami (zaczynające się od "  - ")
    if ! sed -i '/^tags:$/,/^[^ ]/{ /^tags:$/d; /^  - /d; }' "$md_file"; then
        echo -e "${RED}✗${NC} Błąd: $md_file" >&2
        ((errors++))
        continue
    fi
    
    # Zapisz progress
    echo "$md_file" >> "$PROGRESS_FILE"
done

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              GOTOWE!                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📊 Statystyki:${NC}"
echo -e "  • Przetworzono: $cleaned plików"
echo -e "  • Pominięto (brak frontmatter): $skipped plików"
echo -e "  • Błędy: $errors plików"
echo ""
echo -e "${GREEN}✓${NC} Tagi wyczyszczone!"
echo -e "${BLUE}ℹ${NC}  Progress zapisany w: $PROGRESS_FILE"
echo ""
