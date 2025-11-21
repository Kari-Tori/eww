#!/usr/bin/env bash
# File: scripts/eww-auto-tag.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# eww-auto-tag.sh - Automatyczne tagowanie plików w repo
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

# Generuj tagi na podstawie nazwy pliku i lokalizacji
generate_tags() {
    local file="$1"
    local tags=()
    
    # Kategoria na podstawie ścieżki
    case "$file" in
        */bin/*) tags+=("executable" "cli" "tool") ;;
        */lib/*) tags+=("library" "bash" "function") ;;
        */scripts/*) tags+=("script" "automation") ;;
        */tests/*) tags+=("test" "bats" "quality") ;;
        */docs/*) tags+=("documentation" "markdown") ;;
        */config/*) tags+=("config" "setup") ;;
        */systemd/*) tags+=("systemd" "service" "automation") ;;
        */bussiness/*) tags+=("business" "documentation" "sop") ;;
        */core/*) tags+=("core" "installer" "policy") ;;
        */dev/*) tags+=("development" "playbook" "idea") ;;
    esac
    
    # Typ na podstawie rozszerzenia
    case "$file" in
        *.sh) tags+=("bash" "script") ;;
        *.md) tags+=("markdown" "documentation") ;;
        *.json) tags+=("json" "config") ;;
        *.yaml|*.yml) tags+=("yaml" "config") ;;
        *.bats) tags+=("test" "bats") ;;
        Makefile) tags+=("makefile" "build" "automation") ;;
    esac
    
    # Funkcja na podstawie nazwy
    case "$(basename "$file")" in
        *init*) tags+=("initialization") ;;
        *setup*) tags+=("setup") ;;
        *install*) tags+=("installer") ;;
        *test*) tags+=("test") ;;
        *fix*) tags+=("bugfix" "repair") ;;
        *clean*) tags+=("cleanup" "maintenance") ;;
        *banner*) tags+=("ui" "display") ;;
        *version*) tags+=("versioning" "semver") ;;
        *changelog*) tags+=("changelog" "documentation") ;;
        *release*) tags+=("release" "deployment") ;;
        *commit*) tags+=("git" "vcs") ;;
        *status*) tags+=("monitoring" "status") ;;
        *doctor*) tags+=("diagnostic" "health-check") ;;
        README*) tags+=("readme" "introduction") ;;
        AGENTS*) tags+=("ai" "context" "architecture") ;;
        *obsidian*) tags+=("obsidian" "vault" "pkm") ;;
        *vscode*|*code*) tags+=("vscode" "ide") ;;
        *git*) tags+=("git" "vcs") ;;
        *gpg*) tags+=("gpg" "security" "cryptography") ;;
    esac
    
    # Usuń duplikaty i ogranicz do 7
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    
    # Formatuj jako YAML array
    if [ ${#unique_tags[@]} -gt 0 ]; then
        echo "tags:"
        for tag in "${unique_tags[@]}"; do
            echo "  - $tag"
        done
    fi
}

# Sprawdź czy plik ma już frontmatter
has_frontmatter() {
    local file="$1"
    head -1 "$file" 2>/dev/null | grep -q "^---$"
}

# Dodaj tagi do pliku markdown
add_tags_to_md() {
    local file="$1"
    
    if has_frontmatter "$file"; then
        echo -e "${YELLOW}⚠️  $file - ma już frontmatter${NC}"
        return 0
    fi
    
    local tags
    tags=$(generate_tags "$file")
    
    if [ -z "$tags" ]; then
        echo -e "${YELLOW}⚠️  $file - brak tagów${NC}"
        return 0
    fi
    
    # Utwórz backup
    cp "$file" "$file.bak"
    
    # Dodaj frontmatter z tagami
    {
        echo "---"
        echo "$tags"
        echo "---"
        echo ""
        cat "$file"
    } > "$file.tmp"
    
    mv "$file.tmp" "$file"
    rm "$file.bak"
    
    echo -e "${GREEN}✅ $file - dodano tagi${NC}"
}

# Dodaj komentarz z tagami do pliku bash
add_tags_to_bash() {
    local file="$1"
    
    # Sprawdź czy już ma tagi w komentarzu
    if grep -q "^# Tags:" "$file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  $file - ma już tagi${NC}"
        return 0
    fi
    
    local tags
    tags=$(generate_tags "$file" | sed 's/^tags:/# Tags:/' | sed 's/^  - /# /')
    
    if [ -z "$tags" ]; then
        echo -e "${YELLOW}⚠️  $file - brak tagów${NC}"
        return 0
    fi
    
    # Znajdź linię po shebang
    local shebang_line
    shebang_line=$(head -1 "$file")
    
    # Utwórz backup
    cp "$file" "$file.bak"
    
    if [[ "$shebang_line" =~ ^#! ]]; then
        # Wstaw tagi po shebang
        {
            echo "$shebang_line"
            echo "$tags"
            tail -n +2 "$file"
        } > "$file.tmp"
    else
        # Wstaw tagi na początku
        {
            echo "$tags"
            cat "$file"
        } > "$file.tmp"
    fi
    
    mv "$file.tmp" "$file"
    rm "$file.bak"
    
    echo -e "${GREEN}✅ $file - dodano tagi${NC}"
}

# Przetwórz katalog
process_directory() {
    local dir="$1"
    local dry_run="${2:-false}"
    
    echo -e "${BLUE}=== Tagowanie plików w $dir ===${NC}"
    echo ""
    
    # Markdown files
    while IFS= read -r -d '' file; do
        if [ "$dry_run" = "true" ]; then
            echo -e "${BLUE}[DRY-RUN]${NC} $file"
            generate_tags "$file"
            echo ""
        else
            add_tags_to_md "$file"
        fi
    done < <(find "$dir" -type f -name "*.md" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        ! -path "*/usr/*" \
        -print0 2>/dev/null)
    
    # Bash scripts
    while IFS= read -r -d '' file; do
        if [ "$dry_run" = "true" ]; then
            echo -e "${BLUE}[DRY-RUN]${NC} $file"
            generate_tags "$file"
            echo ""
        else
            add_tags_to_bash "$file"
        fi
    done < <(find "$dir" -type f -name "*.sh" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        ! -path "*/usr/*" \
        -print0 2>/dev/null)
}

# Usage
usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJE] [KATALOG]

Automatyczne tagowanie plików w repo.

OPCJE:
    -d, --dry-run   Pokaż co zostanie zrobione bez zmian
    -h, --help      Wyświetl tę pomoc

PRZYKŁADY:
    $(basename "$0") --dry-run           # Test na całym repo
    $(basename "$0") scripts/            # Otaguj tylko scripts/
    $(basename "$0") docs/               # Otaguj tylko docs/

EOF
}

# Main
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
    echo -e "${GREEN}✅ Tagowanie zakończone${NC}"
}

main "$@"
