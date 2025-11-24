#!/usr/bin/env bash
# fix-frontmatter-v2.sh - Dodaj brakujące pola frontmatter (wersja sed)
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

cd "$(git rev-parse --show-toplevel)"

fixed=0
total=0

# Funkcja do określenia owner
get_owner() {
    local file="$1"
    [[ "$file" == ./usr/karinam/* ]] && echo "karinam" && return
    [[ "$file" == ./usr/jakubc/* ]] && echo "jakubc" && return
    echo "jakubc"
}

# Funkcja do pobrania dat z git
get_created() {
    local file="$1"
    git log --follow --format=%aI --reverse "$file" 2>/dev/null | head -1 || date -Iseconds
}

get_modified() {
    local file="$1"
    git log --format=%aI -1 "$file" 2>/dev/null || date -Iseconds
}

echo -e "${BLUE}[EWW] 🔧 Fixing frontmatter...${NC}"

# Znajdź pliki
mapfile -t files < <(find . -name "*.md" -type f -not -path "*/.git/*" -not -path "*/node_modules/*")
total=${#files[@]}

echo -e "${BLUE}[EWW] 📊 Znaleziono $total plików markdown${NC}"

for file in "${files[@]}"; do
    owner=$(get_owner "$file")
    author="$owner"  # author = owner
    created=$(get_created "$file")
    modified=$(get_modified "$file")

    # Sprawdź czy ma frontmatter
    if ! head -1 "$file" | grep -q "^---$"; then
        echo -e "${YELLOW}[EWW] ➕ Dodaję frontmatter: $file${NC}"

        temp=$(mktemp)
        cat > "$temp" <<EOF
---
created: $created
modified: $modified
author: $author
owner: $owner
tags: []
---

EOF
        cat "$file" >> "$temp"
        mv "$temp" "$file"
        ((fixed++))
        continue
    fi

    # Ma frontmatter - dodaj brakujące pola
    changed=false

    if ! grep -q "^owner:" "$file"; then
        # Dodaj owner przed zamykającym ---
        sed -i "/^---$/,/^---$/ {
            /^---$/ {
                /^---$/n
                /^---$/ i\\
owner: $owner
            }
        }" "$file"
        changed=true
    fi

    if ! grep -q "^author:" "$file"; then
        sed -i "/^---$/,/^---$/ {
            /^---$/ {
                /^---$/n
                /^---$/ i\\
author: $author
            }
        }" "$file"
        changed=true
    fi

    if ! grep -q "^modified:" "$file"; then
        sed -i "/^---$/,/^---$/ {
            /^---$/ {
                /^---$/n
                /^---$/ i\\
modified: $modified
            }
        }" "$file"
        changed=true
    fi

    if ! grep -q "^created:" "$file"; then
        sed -i "/^---$/,/^---$/ {
            /^---$/ {
                /^---$/n
                /^---$/ i\\
created: $created
            }
        }" "$file"
        changed=true
    fi

    if [[ "$changed" == true ]]; then
        echo -e "${GREEN}[EWW] ✅ Fixed: $file${NC}"
        ((fixed++))
    fi

    # Progress
    if (( (fixed % 50) == 0 )) && (( fixed > 0 )); then
        echo -e "${BLUE}[EWW] 📊 Progress: $fixed poprawionych...${NC}"
    fi
done

echo ""
echo -e "${GREEN}[EWW] 🎉 UKOŃCZONO!${NC}"
echo -e "${BLUE}📊 PODSUMOWANIE:${NC}"
echo "  Total plików: $total"
echo "  Poprawionych: $fixed"
