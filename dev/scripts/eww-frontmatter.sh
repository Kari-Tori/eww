#!/usr/bin/env bash
# Tags:
# bash
# script
# automation
# frontmatter
# yaml
# eww-frontmatter.sh - Generuje kompletny YAML frontmatter dla plików
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
EWW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly EWW_ROOT

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Generuj tagi (max 7)
generate_tags() {
    local file="$1"
    local tags=()
    
    case "$file" in
        */bin/*) tags+=("executable" "cli" "tool") ;;
        */lib/*) tags+=("library" "bash" "function") ;;
        */scripts/*) tags+=("script" "automation") ;;
        */tests/*) tags+=("test" "bats" "quality") ;;
        */docs/*) tags+=("documentation" "markdown") ;;
        */config/*) tags+=("config" "setup") ;;
        */systemd/*) tags+=("systemd" "service") ;;
        */business/*) tags+=("business" "sop") ;;
    esac
    
    case "$file" in
        *.sh) tags+=("bash" "script") ;;
        *.md) tags+=("markdown" "documentation") ;;
        *.json) tags+=("json" "config") ;;
        *.yaml|*.yml) tags+=("yaml" "config") ;;
    esac
    
    case "$(basename "$file")" in
        *init*) tags+=("initialization") ;;
        *setup*) tags+=("setup") ;;
        *test*) tags+=("test") ;;
        *fix*) tags+=("bugfix") ;;
        *clean*) tags+=("cleanup") ;;
        *version*) tags+=("versioning") ;;
        *release*) tags+=("release") ;;
        README*) tags+=("readme") ;;
        *obsidian*) tags+=("obsidian" "pkm") ;;
        *vscode*|*code*) tags+=("vscode" "ide") ;;
        *git*) tags+=("git" "vcs") ;;
    esac
    
    printf '%s\n' "${tags[@]}" | sort -u | head -7
}

# Pobierz autora z git
get_author() {
    local file="$1"
    git log -1 --format='%an' -- "$file" 2>/dev/null || echo "jakubc"
}

# Pobierz datę utworzenia
get_created_date() {
    local file="$1"
    git log --follow --format='%aI' --diff-filter=A -- "$file" 2>/dev/null | tail -1 || date -r "$file" +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d
}

# Pobierz datę ostatniej modyfikacji
get_updated_date() {
    local file="$1"
    git log -1 --format='%aI' -- "$file" 2>/dev/null | cut -d'T' -f1 || date -r "$file" +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d
}

# Generuj tytuł z nazwy pliku
generate_title() {
    local file="$1"
    local basename
    basename=$(basename "$file" | sed 's/\.[^.]*$//')
    echo "$basename" | sed 's/-/ /g' | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g'
}

# Generuj opis na podstawie pierwszej linii po shebang
generate_description() {
    local file="$1"
    
    if [[ "$file" == *.sh ]]; then
        grep -m1 "^# [^T]" "$file" 2>/dev/null | sed 's/^# //' || echo "Skrypt Bash dla projektu EWW"
    elif [[ "$file" == *.md ]]; then
        grep -m1 "^# " "$file" 2>/dev/null | sed 's/^# //' || echo "Dokumentacja projektu EWW"
    else
        echo "Plik projektu E-Waste Workshop"
    fi
}

# Znajdź powiązane pliki (backlinks)
find_related_files() {
    local file="$1"
    local basename
    basename=$(basename "$file")
    local related=()
    
    # Szukaj plików, które linkują do tego pliku
    while IFS= read -r referrer; do
        local rel_path
        rel_path=$(realpath --relative-to="$EWW_ROOT" "$referrer" 2>/dev/null || echo "$referrer")
        related+=("$rel_path")
    done < <(grep -l "$basename" "$EWW_ROOT"/*.md "$EWW_ROOT"/*/*.md 2>/dev/null | grep -v "$file" | head -3)
    
    printf '%s\n' "${related[@]}"
}

# Określ typ/kategorię pliku
get_file_type() {
    local file="$1"
    
    case "$file" in
        */bin/*) echo "executable" ;;
        */lib/*) echo "library" ;;
        */scripts/*) echo "script" ;;
        */tests/*) echo "test" ;;
        */docs/*guide*|*/docs/*tutorial*) echo "guide" ;;
        */docs/*troubleshoot*) echo "troubleshooting" ;;
        */docs/*) echo "documentation" ;;
        */config/*) echo "configuration" ;;
        */business/*) echo "business-document" ;;
        *README*) echo "readme" ;;
        *CHANGELOG*) echo "changelog" ;;
        *) echo "file" ;;
    esac
}

# Generuj słowa kluczowe
generate_keywords() {
    local file="$1"
    local -a keywords=()
    
    # Z nazwy pliku
    case "$(basename "$file")" in
        *obsidian*) keywords+=("obsidian" "vault" "pkm" "notes") ;;
        *vscode*|*code*) keywords+=("vscode" "editor" "ide") ;;
        *git*) keywords+=("git" "version-control" "repository") ;;
        *bash*|*.sh) keywords+=("bash" "shell" "scripting") ;;
        *fix*|*repair*) keywords+=("fix" "repair" "troubleshooting" "debug") ;;
        *install*|*setup*) keywords+=("installation" "setup" "configuration") ;;
        *test*) keywords+=("testing" "quality" "validation") ;;
        *clean*) keywords+=("cleanup" "maintenance" "optimization") ;;
    esac
    
    # Z zawartości (pierwsze 50 linii) - tylko dla markdown
    if [[ "$file" == *.md ]]; then
        local content_words
        mapfile -t content_words < <(head -50 "$file" 2>/dev/null | grep -oE '\*\*[A-Za-z]+\*\*' | sed 's/\*//g' | tr '[:upper:]' '[:lower:]' | head -5)
        keywords+=("${content_words[@]}")
    fi
    
    # Zwróć unikalne, max 7
    printf '%s\n' "${keywords[@]}" | sort -u | head -7
}

# Znajdź zależności dla skryptów
find_dependencies() {
    local file="$1"
    local deps=()
    
    if [[ "$file" == *.sh ]]; then
        # Sourced files
        while IFS= read -r dep; do
            deps+=("$dep")
        done < <(grep -oP '(?<=source |. )[^\s;]+' "$file" 2>/dev/null | head -3)
        
        # Required commands
        while IFS= read -r cmd; do
            deps+=("command:$cmd")
        done < <(grep -oP '(?<=command -v )[^\s;]+' "$file" 2>/dev/null | head -3)
    fi
    
    printf '%s\n' "${deps[@]}"
}

# Określ priorytet/ważność
get_priority() {
    local file="$1"
    
    case "$(basename "$file")" in
        README*|AGENTS*|*init*|*setup*) echo "high" ;;
        *fix*|*clean*|*doctor*) echo "medium" ;;
        *test*|*example*) echo "low" ;;
        *) echo "normal" ;;
    esac
}

# Generuj aliasy
generate_aliases() {
    local file="$1"
    local aliases=()
    local basename
    basename=$(basename "$file" | sed 's/\.[^.]*$//')
    
    # Wersja bez prefiksu eww-
    if [[ "$basename" == eww-* ]]; then
        aliases+=("${basename#eww-}")
    fi
    
    # Wersja z myślnikami zamienionymi na podkreślenia
    if [[ "$basename" == *-* ]]; then
        aliases+=("${basename//-/_}")
    fi
    
    printf '%s\n' "${aliases[@]}" | head -3
}

# Generuj kompletny frontmatter YAML
generate_full_frontmatter() {
    local file="$1"
    local filepath
    filepath=$(realpath --relative-to="$EWW_ROOT" "$file")
    
    local title
    title=$(generate_title "$file")
    
    local description
    description=$(generate_description "$file")
    
    local author
    author=$(get_author "$file")
    [ -z "$author" ] && author="jakubc"
    
    local created
    created=$(get_created_date "$file")
    [ -z "$created" ] && created=$(date +%Y-%m-%d)
    
    local updated
    updated=$(get_updated_date "$file")
    [ -z "$updated" ] && updated=$(date +%Y-%m-%d)
    
    local file_type
    file_type=$(get_file_type "$file")
    
    local priority
    priority=$(get_priority "$file")
    
    local tags
    mapfile -t tags < <(generate_tags "$file")
    
    local keywords
    mapfile -t keywords < <(generate_keywords "$file")
    
    local related
    mapfile -t related < <(find_related_files "$file")
    
    local dependencies
    mapfile -t dependencies < <(find_dependencies "$file")
    
    local aliases
    mapfile -t aliases < <(generate_aliases "$file")
    
    # Generuj YAML - używamy echo zamiast cat <<EOF żeby uniknąć łamania linii
    echo "---"
    echo "title: $title"
    echo "description: $description"
    echo "type: $file_type"
    echo "category: $(dirname "$filepath" | cut -d'/' -f1)"
    echo "filepath: $filepath"
    echo "author: $author"
    echo "owner: jakubc"
    echo "created: $created"
    echo "updated: $updated"
    echo "version: 1.0.0"
    echo "language: pl"
    echo "status: active"
    echo "priority: $priority"
    echo "license: MIT"
    echo "tags:"
    
    for tag in "${tags[@]}"; do
        echo "  - $tag"
    done
    
    if [ ${#keywords[@]} -gt 0 ]; then
        echo "keywords:"
        for kw in "${keywords[@]}"; do
            [ -n "$kw" ] && echo "  - $kw"
        done
    fi
    
    if [ ${#aliases[@]} -gt 0 ]; then
        echo "aliases:"
        for alias in "${aliases[@]}"; do
            [ -n "$alias" ] && echo "  - $alias"
        done
    fi
    
    if [ ${#related[@]} -gt 0 ]; then
        echo "related:"
        for rel in "${related[@]}"; do
            [ -n "$rel" ] && echo "  - $rel"
        done
    fi
    
    if [ ${#dependencies[@]} -gt 0 ]; then
        echo "dependencies:"
        for dep in "${dependencies[@]}"; do
            [ -n "$dep" ] && echo "  - $dep"
        done
    fi
    
    echo "sources:"
    echo "  - $filepath"
    echo "backlinks: []"
    echo "context: \"E-Waste Workshop - Bash toolkit for Kubuntu environment setup\""
    echo "project: eww"
    echo "repository: https://github.com/Kari-Tori/eww-1"
    echo "---"
}

# Sprawdź czy plik ma frontmatter
has_frontmatter() {
    local file="$1"
    head -1 "$file" 2>/dev/null | grep -q "^---$"
}

# Aktualizuj frontmatter w pliku markdown
update_markdown_frontmatter() {
    local file="$1"
    local dry_run="${2:-false}"
    
    if [ "$dry_run" = "true" ]; then
        echo -e "${BLUE}[DRY-RUN]${NC} $file"
        generate_full_frontmatter "$file"
        echo ""
        return 0
    fi
    
    # Backup
    cp "$file" "$file.bak"
    
    if has_frontmatter "$file"; then
        # Usuń stary frontmatter i dodaj nowy
        local content_start
        content_start=$(awk '/^---$/{c++; if(c==2){print NR+1; exit}}' "$file")
        
        if [ -n "$content_start" ]; then
            {
                generate_full_frontmatter "$file"
                echo ""
                tail -n +${content_start} "$file"
            } > "$file.tmp"
            mv "$file.tmp" "$file"
            rm "$file.bak"
            echo -e "${GREEN}✅ $file - zaktualizowano frontmatter${NC}"
        else
            rm "$file.bak"
            echo -e "${YELLOW}⚠️  $file - błąd parsowania frontmatter${NC}"
        fi
    else
        # Dodaj nowy frontmatter
        {
            generate_full_frontmatter "$file"
            echo ""
            cat "$file"
        } > "$file.tmp"
        mv "$file.tmp" "$file"
        rm "$file.bak"
        echo -e "${GREEN}✅ $file - dodano frontmatter${NC}"
    fi
}

# Aktualizuj komentarze w pliku bash
update_bash_metadata() {
    local file="$1"
    local dry_run="${2:-false}"
    
    local filepath
    filepath=$(realpath --relative-to="$EWW_ROOT" "$file")
    
    local author
    author=$(get_author "$file")
    [ -z "$author" ] && author="jakubc"
    
    local created
    created=$(get_created_date "$file")
    [ -z "$created" ] && created=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1)
    
    local updated
    updated=$(get_updated_date "$file")
    [ -z "$updated" ] && updated=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1)
    
    local description
    description=$(generate_description "$file")
    
    if [ "$dry_run" = "true" ]; then
        echo -e "${BLUE}[DRY-RUN]${NC} $file"
        cat <<EOF
# File: $filepath
# Author: $author
# Created: $created
# Updated: $updated
# Description: $description
EOF
        echo ""
        return 0
    fi
    
    # Sprawdź czy ma już metadata (# File:, # Tags:, etc.)
    if grep -qE "^# (File|Tags|Author):" "$file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  $file - ma już metadata (pomijam)${NC}"
        return 0
    fi
    
    # Backup
    cp "$file" "$file.bak"
    
    local shebang
    shebang=$(head -1 "$file")
    
    if [[ "$shebang" =~ ^#! ]]; then
        {
            echo "$shebang"
            echo "# File: $filepath"
            echo "# Author: $author"
            echo "# Created: $created"
            echo "# Updated: $updated"
            echo "# Description: $description"
            tail -n +2 "$file"
        } > "$file.tmp"
    else
        {
            echo "# File: $filepath"
            echo "# Author: $author"
            echo "# Created: $created"
            echo "# Updated: $updated"
            echo "# Description: $description"
            cat "$file"
        } > "$file.tmp"
    fi
    
    mv "$file.tmp" "$file"
    rm "$file.bak"
    echo -e "${GREEN}✅ $file - dodano metadata${NC}"
}

# Przetwórz katalog
process_directory() {
    local dir="$1"
    local dry_run="${2:-false}"
    
    echo -e "${BLUE}=== Generowanie frontmatter w $dir ===${NC}"
    echo ""
    
    # Pliki markdown
    while IFS= read -r -d '' file; do
        update_markdown_frontmatter "$file" "$dry_run"
    done < <(find "$dir" -type f -name "*.md" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        ! -path "*/usr/*" \
        -print0 2>/dev/null)
    
    # Pliki bash
    while IFS= read -r -d '' file; do
        update_bash_metadata "$file" "$dry_run"
    done < <(find "$dir" -type f -name "*.sh" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        ! -path "*/usr/*" \
        -print0 2>/dev/null)
}

usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJE] [KATALOG]

Generuje kompletny YAML frontmatter dla wszystkich plików.

Frontmatter zawiera:
  - title, description, filepath
  - author, owner
  - created, updated dates
  - tags (max 7)
  - related files (backlinks)
  - sources

OPCJE:
    -d, --dry-run   Pokaż co zostanie wygenerowane
    -h, --help      Wyświetl tę pomoc

PRZYKŁADY:
    $(basename "$0") --dry-run docs/
    $(basename "$0") scripts/
    $(basename "$0") .

EOF
}

main() {
    local dry_run=false
    local target_dir="$EWW_ROOT"
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                dry_run=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                target_dir="$1"
                shift
                ;;
        esac
    done
    
    if [ ! -d "$target_dir" ]; then
        echo -e "${RED}❌ Katalog nie istnieje: $target_dir${NC}"
        exit 1
    fi
    
    process_directory "$target_dir" "$dry_run"
    
    echo ""
    echo -e "${GREEN}✅ Generowanie frontmatter zakończone${NC}"
}

main "$@"
