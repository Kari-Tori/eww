#!/usr/bin/env bash
# fix-frontmatter-simple.sh - Dodaj brakujące pola frontmatter (uproszczona wersja)
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly RED='\033[0;31m'
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
    git log --format=%aI -1 "$file" 2>/dev/null || date -r "$file" -Iseconds 2>/dev/null || date -Iseconds
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

    # Ma frontmatter - sprawdź brakujące pola
    needs_fix=false

    if ! grep -q "^owner:" "$file"; then
        needs_fix=true
    fi

    if ! grep -q "^author:" "$file"; then
        needs_fix=true
    fi

    if ! grep -q "^created:" "$file"; then
        needs_fix=true
    fi

    if ! grep -q "^modified:" "$file"; then
        needs_fix=true
    fi

    if [[ "$needs_fix" == false ]]; then
        continue
    fi

    echo -e "${GREEN}[EWW] ✅ Fixuję: $file${NC}"

    # Użyj Python do bezpiecznej edycji YAML frontmatter
    python3 <<PYTHON
import sys

file_path = "$file"
owner = "$owner"
author = "$author"
created = "$created"
modified = "$modified"

with open(file_path, 'r') as f:
    lines = f.readlines()

if lines[0].strip() != '---':
    sys.exit(0)

# Znajdź koniec frontmatter
end_idx = -1
for i in range(1, len(lines)):
    if lines[i].strip() == '---':
        end_idx = i
        break

if end_idx == -1:
    sys.exit(0)

# Sprawdź co jest w frontmatter
frontmatter = ''.join(lines[1:end_idx])

new_lines = lines[:1]  # Start with ---

# Dodaj istniejące linie frontmatter (bez owner, author, created, modified)
for line in lines[1:end_idx]:
    key = line.split(':')[0].strip() if ':' in line else ''
    if key not in ['owner', 'author', 'created', 'modified']:
        new_lines.append(line)

# Dodaj/zaktualizuj pola
if 'created:' not in frontmatter:
    new_lines.append(f'created: {created}\n')
if 'modified:' not in frontmatter:
    new_lines.append(f'modified: {modified}\n')
if 'author:' not in frontmatter:
    new_lines.append(f'author: {author}\n')
if 'owner:' not in frontmatter:
    new_lines.append(f'owner: {owner}\n')

# Dodaj resztę pliku
new_lines.extend(lines[end_idx:])

with open(file_path, 'w') as f:
    f.writelines(new_lines)
PYTHON

    ((fixed++))

    # Progress
    if (( fixed % 50 == 0 )); then
        echo -e "${BLUE}[EWW] 📊 Progress: $fixed/$total...${NC}"
    fi
done

echo ""
echo -e "${GREEN}[EWW] 🎉 UKOŃCZONO!${NC}"
echo -e "${BLUE}📊 PODSUMOWANIE:${NC}"
echo "  Total plików: $total"
echo "  Poprawionych: $fixed"
