#!/usr/bin/env bash
# git-to-obsidian-timeline.sh - Generuj timeline Obsidian Graph z Git history
set -euo pipefail

readonly REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

echo "🕐 Generuję Git Timeline dla Obsidian Graph..."

# Dla każdego pliku .md pobierz daty Git i zaktualizuj frontmatter
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
        # Ma frontmatter - zaktualizuj daty
        
        # Usuń stare created/modified jeśli istnieją
        sed -i '/^created:/d; /^modified:/d; /^author:/d' "$file"
        
        # Dodaj nowe na końcu frontmatter (przed zamykającym ---)
        sed -i "/^---$/i created: $CREATED\nmodified: $MODIFIED\nauthor: $AUTHOR" "$file"
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
    
    echo "✓ $file (utworzony: $CREATED przez $AUTHOR)"
done

echo ""
echo "✅ Timeline wygenerowany! Obsidian Graph będzie teraz pokazywał nodes zgodnie z chronologią Git."
echo ""
echo "📊 Statystyki:"
echo "  • Najstarszy plik: $(git log --reverse --format=%aI | head -1)"
echo "  • Najnowszy commit: $(git log -1 --format=%aI)"
echo "  • Autorzy: $(git log --format=%an | sort -u | tr '\n' ', ')"
