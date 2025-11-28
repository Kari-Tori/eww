#!/usr/bin/env bash
# git-to-obsidian-timeline-fix.sh - POPRAWIONA wersja (merge z istniejącym frontmatter)
set -euo pipefail

readonly REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

echo "🕐 Aktualizuję Git Timeline w frontmatter..."

find . -name "*.md" \
  ! -path "./.git/*" \
  ! -path "./archive/*" \
  ! -path "./Tags/*" \
  ! -path "./.obsidian/*" | while read -r file; do
    
    # Pobierz daty Git
    CREATED=$(git log --diff-filter=A --follow --format=%aI -- "$file" | tail -1)
    MODIFIED=$(git log -1 --format=%aI -- "$file")
    AUTHOR=$(git log --diff-filter=A --follow --format=%an -- "$file" | tail -1)
    
    # Pomiń jeśli plik nie ma historii Git
    [[ -z "$CREATED" ]] && continue
    
    # Sprawdź czy ma frontmatter
    if grep -q "^---$" "$file"; then
        # Ma frontmatter - zaktualizuj tylko Git-related fields
        
        # Usuń stare created/modified/author jeśli istnieją
        sed -i '/^created: 20[0-9][0-9]-/d; /^modified: 20[0-9][0-9]-/d; /^author: [a-z]/d' "$file"
        
        # Znajdź linię z pierwszym --- i dodaj po nim
        awk -v created="created: $CREATED" -v modified="modified: $MODIFIED" -v author="author: $AUTHOR" '
        BEGIN { first_dash = 0 }
        /^---$/ { 
            if (first_dash == 0) {
                print $0
                print created
                print modified
                print author
                first_dash = 1
                next
            }
        }
        { print }
        ' "$file" > "$file.tmp"
        mv "$file.tmp" "$file"
    else
        # Brak frontmatter - dodaj nowy
        {
            echo "---"
            echo "created: $CREATED"
            echo "modified: $MODIFIED"
            echo "author: $AUTHOR"
            echo "---"
            echo ""
            cat "$file"
        } > "$file.tmp"
        mv "$file.tmp" "$file"
    fi
    
    echo "✓ $file"
done

echo ""
echo "✅ Timeline zaktualizowany!"
