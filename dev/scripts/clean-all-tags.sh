#!/usr/bin/env bash
set -euo pipefail

# Wyczyść wszystkie tagi ze wszystkich plików MD

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

echo -e "${YELLOW}🧹 Czyszczenie wszystkich tagów...${NC}"

cd "$REPO_ROOT"
mapfile -t files < <(find . -name "*.md" -type f)
total=${#files[@]}
current=0

for file in "${files[@]}"; do
    current=$((current + 1))
    printf "[%3d/%d] Czyszczę: %-60s\r" "$current" "$total" "$file"
    
    # Usuń frontmatter YAML jeśli istnieje
    if grep -q "^---$" "$file" 2>/dev/null; then
        # Usuń od pierwszego --- do drugiego ---
        sed -i '1{/^---$/!b};:a;/^---$/!{N;ba};d' "$file"
        # Usuń puste linie na początku
        sed -i '/./,$!d' "$file"
    fi
done

echo ""
echo -e "${GREEN}✅ Wyczyszczono $total plików${NC}"
