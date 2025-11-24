#!/usr/bin/env bash
# fix-frontmatter.sh - Dodaj brakujące pola frontmatter do plików .md
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Przejdź do root repo
cd "$(git rev-parse --show-toplevel)"

fixed_created=0
fixed_modified=0
fixed_author=0
fixed_owner=0
added_frontmatter=0
total=0

# Funkcja do określenia owner na podstawie ścieżki
get_owner() {
    local file="$1"

    # usr/karinam/ → karinam
    if [[ "$file" == ./usr/karinam/* ]]; then
        echo "karinam"
        return
    fi

    # usr/jakubc/ → jakubc
    if [[ "$file" == ./usr/jakubc/* ]]; then
        echo "jakubc"
        return
    fi

    # Wszystko inne → jakubc (default owner projektu)
    echo "jakubc"
}

# Funkcja do określenia author (zazwyczaj = owner)
get_author() {
    local file="$1"
    local owner="$2"

    # Author = owner (plik tworzony na urządzeniu właściciela)
    # Wyjątki można dodać tutaj jeśli potrzebne
    echo "$owner"
}

# Funkcja do pobrania dat z git
get_created_date() {
    local file="$1"

    # Data pierwszego commitu
    if git log --follow --format=%aI --reverse "$file" 2>/dev/null | head -1 | grep -q .; then
        git log --follow --format=%aI --reverse "$file" 2>/dev/null | head -1
    else
        date -Iseconds
    fi
}

get_modified_date() {
    local file="$1"

    # Data ostatniego commitu lub data modyfikacji pliku
    if git log --format=%aI -1 "$file" 2>/dev/null | grep -q .; then
        git log --format=%aI -1 "$file" 2>/dev/null
    else
        date -r "$file" -Iseconds 2>/dev/null || date -Iseconds
    fi
}

echo -e "${BLUE}[EWW] 🔧 Fixing frontmatter in .md files...${NC}"

while IFS= read -r file; do
    ((total++))

    # Sprawdź czy ma frontmatter
    if ! head -1 "$file" | grep -q "^---$"; then
        echo -e "${YELLOW}[EWW] ➕ Dodaję frontmatter: $file${NC}"

        owner=$(get_owner "$file")
        author=$(get_author "$file" "$owner")
        created=$(get_created_date "$file")
        modified=$(get_modified_date "$file")

        # Dodaj frontmatter na początku pliku
        temp_file=$(mktemp)
        cat > "$temp_file" <<EOF
---
created: $created
modified: $modified
author: $author
owner: $owner
tags: []
---

EOF
        cat "$file" >> "$temp_file"
        mv "$temp_file" "$file"

        ((added_frontmatter++))
        continue
    fi

    # Wyciągnij frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | head -n -1 | tail -n +2)
    needs_update=false

    # Przygotuj nowe wartości
    owner=$(get_owner "$file")
    author=$(get_author "$file" "$owner")
    created=$(get_created_date "$file")
    modified=$(get_modified_date "$file")

    # Sprawdź i dodaj brakujące pola
    temp_file=$(mktemp)
    in_frontmatter=false
    frontmatter_done=false

    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == false ]]; then
                in_frontmatter=true
                echo "$line" >> "$temp_file"
                continue
            else
                # Koniec frontmatter - dodaj brakujące pola przed zamknięciem
                if [[ ! "$frontmatter" =~ created: ]]; then
                    echo "created: $created" >> "$temp_file"
                    ((fixed_created++))
                    needs_update=true
                fi

                if [[ ! "$frontmatter" =~ modified: ]]; then
                    echo "modified: $modified" >> "$temp_file"
                    ((fixed_modified++))
                    needs_update=true
                fi

                if [[ ! "$frontmatter" =~ author: ]]; then
                    echo "author: $author" >> "$temp_file"
                    ((fixed_author++))
                    needs_update=true
                fi

                if [[ ! "$frontmatter" =~ owner: ]]; then
                    echo "owner: $owner" >> "$temp_file"
                    ((fixed_owner++))
                    needs_update=true
                fi

                in_frontmatter=false
                frontmatter_done=true
                echo "$line" >> "$temp_file"
                continue
            fi
        fi

        echo "$line" >> "$temp_file"
    done < "$file"

    # Jeśli były zmiany, zastąp plik
    if [[ "$needs_update" == true ]]; then
        mv "$temp_file" "$file"
        echo -e "${GREEN}[EWW] ✅ Fixed: $file${NC}"
    else
        rm "$temp_file"
    fi

    # Progress co 100 plików
    if (( total % 100 == 0 )); then
        echo -e "${BLUE}[EWW] 📊 Progress: $total plików sprawdzonych...${NC}"
    fi

done < <(find . -name "*.md" -type f -not -path "*/.git/*" -not -path "*/node_modules/*")

echo ""
echo -e "${GREEN}[EWW] 🎉 UKOŃCZONO!${NC}"
echo -e "${BLUE}📊 PODSUMOWANIE:${NC}"
echo "  Total plików: $total"
echo "  Dodano frontmatter: $added_frontmatter"
echo "  Dodano created: $fixed_created"
echo "  Dodano modified: $fixed_modified"
echo "  Dodano author: $fixed_author"
echo "  Dodano owner: $fixed_owner"
