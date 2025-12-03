#!/usr/bin/env bash
# Pre-commit hook do automatycznego wersjonowania plików Markdown
#
# Instalacja:
#   cp dev/scripts/pre-commit-version.sh .git/hooks/pre-commit
#   chmod +x .git/hooks/pre-commit
#
# Lub użyj: make install-hooks

set -euo pipefail

# Kolory
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Sprawdź czy semver jest zainstalowane
if ! command -v semver &>/dev/null; then
    echo -e "${YELLOW}⚠️  Ostrzeżenie: semver nie jest zainstalowane${NC}" >&2
    echo -e "${YELLOW}   Zainstaluj: npm install -g semver${NC}" >&2
fi

# Funkcja do podbijania wersji w frontmatter
bump_file_version() {
    local file="$1"
    local temp_file="${file}.tmp"

    # Sprawdź czy plik ma frontmatter
    if ! head -n1 "$file" | grep -q "^---$"; then
        return 0
    fi

    # Wyciągnij obecną wersję
    local current_version
    current_version=$(awk '/^---$/,/^---$/ {if ($1 == "version:") print $2; if (NR>1 && $0 == "---") exit}' "$file")

    if [[ -z "$current_version" ]]; then
        return 0
    fi

    # Podbij patch version
    local new_version
    if command -v semver &>/dev/null; then
        new_version=$(semver -i patch "$current_version" 2>/dev/null || echo "$current_version")
    else
        # Fallback - ręczne podbicie patch
        if [[ "$current_version" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
            local major="${BASH_REMATCH[1]}"
            local minor="${BASH_REMATCH[2]}"
            local patch="${BASH_REMATCH[3]}"
            new_version="${major}.${minor}.$((patch + 1))"
        else
            return 0
        fi
    fi

    # Aktualizuj wersję i datę modyfikacji
    local today
    today=$(date -I)

    awk -v new_ver="$new_version" -v today="$today" '
        BEGIN { in_fm=0; fm_end=0 }
        /^---$/ {
            if (!in_fm) { in_fm=1; print; next }
            else { fm_end=1; print; next }
        }
        in_fm && !fm_end {
            if ($1 == "version:") { print "version: " new_ver; next }
            if ($1 == "modified:") { print "modified: " today; next }
        }
        { print }
    ' "$file" > "$temp_file"

    mv "$temp_file" "$file"
    echo -e "${GREEN}  ✅ Podbito wersję: $file ($current_version → $new_version)${NC}"
}

# Pobierz listę zmodyfikowanych plików .md
modified_md_files=$(git diff --cached --name-only --diff-filter=M | grep '\.md$' || true)

if [[ -z "$modified_md_files" ]]; then
    exit 0
fi

echo -e "${YELLOW}🔄 Automatyczne wersjonowanie zmodyfikowanych plików Markdown...${NC}"

# Podbij wersję dla każdego zmodyfikowanego pliku
while IFS= read -r file; do
    if [[ -f "$file" ]]; then
        bump_file_version "$file"
        git add "$file"
    fi
done <<< "$modified_md_files"

echo -e "${GREEN}✅ Wersjonowanie zakończone${NC}"

exit 0
