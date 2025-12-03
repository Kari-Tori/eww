#!/usr/bin/env bash
# sync-versions.sh - Synchronizacja wersji między VERSION, tagami Git i frontmatterami
set -euo pipefail

# Kolory dla outputu
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Ścieżki
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly VERSION_FILE="$REPO_ROOT/VERSION"

# Sprawdź czy semver jest zainstalowane
check_semver() {
    if ! command -v semver &> /dev/null; then
        echo -e "${RED}[EWW] Błąd: semver nie jest zainstalowane${NC}" >&2
        echo -e "${YELLOW}[EWW] Zainstaluj: npm install -g semver${NC}" >&2
        exit 1
    fi
}

# Pobierz aktualną wersję z pliku VERSION
get_current_version() {
    if [[ ! -f "$VERSION_FILE" ]]; then
        echo -e "${RED}[EWW] Błąd: Brak pliku VERSION${NC}" >&2
        exit 1
    fi
    cat "$VERSION_FILE"
}

# Waliduj format wersji przez semver
validate_version() {
    local version="$1"
    if ! semver "$version" > /dev/null 2>&1; then
        echo -e "${RED}[EWW] Błąd: Nieprawidłowy format wersji: $version${NC}" >&2
        exit 1
    fi
}

# Podbij wersję (major, minor, patch)
bump_version() {
    local bump_type="$1"
    local current_version
    current_version=$(get_current_version)

    validate_version "$current_version"

    local new_version
    new_version=$(semver -i "$bump_type" "$current_version")

    echo -e "${BLUE}[EWW] Podbijam wersję: $current_version → $new_version ($bump_type)${NC}" >&2
    echo "$new_version" > "$VERSION_FILE"
    echo "$new_version"
}

# Synchronizuj wersję w frontmatterach plików .md
sync_frontmatter_versions() {
    local target_version="$1"
    local updated_count=0

    echo -e "${BLUE}[EWW] Synchronizuję wersje w frontmatterach do: $target_version${NC}" >&2

    # Użyj Pythona do aktualizacji frontmatterów
    python3 - <<PY
import pathlib
import re
import sys

target_version = "$target_version"
root = pathlib.Path("$REPO_ROOT")
skip_dirs = {".git", ".obsidian", ".space", "node_modules", "vendor", ".vale", ".trash"}

def should_skip(p):
    return any(part in skip_dirs for part in p.parts)

md_files = [p for p in root.rglob("*.md") if not should_skip(p)]
updated_count = 0

for p in md_files:
    try:
        text = p.read_text(encoding="utf-8", errors="ignore")
        lines = text.splitlines()

        if not lines or lines[0].strip() != "---":
            continue

        try:
            end_idx = lines[1:].index("---") + 1
        except ValueError:
            continue

        # Znajdź i zaktualizuj pole version w frontmatterze
        fm_block = lines[1:end_idx]
        version_updated = False

        for i, line in enumerate(fm_block):
            if line.lstrip().startswith("version:"):
                old_version = line.split(":", 1)[1].strip()
                fm_block[i] = f"version: {target_version}"
                version_updated = True
                updated_count += 1
                print(f"Zaktualizowano: {p} ({old_version} → {target_version})")
                break

        if version_updated:
            new_lines = ["---"] + fm_block + ["---"] + lines[end_idx+1:]
            p.write_text("\n".join(new_lines) + "\n", encoding="utf-8")

    except Exception as e:
        print(f"Błąd przetwarzania {p}: {e}", file=sys.stderr)

print(f"\nZaktualizowano {updated_count} plików", file=sys.stderr)
PY

    echo -e "${GREEN}[EWW] Synchronizacja frontmatterów zakończona${NC}" >&2
}

# Utwórz tag Git
create_git_tag() {
    local version="$1"
    local tag_name="v$version"

    if git rev-parse "$tag_name" >/dev/null 2>&1; then
        echo -e "${YELLOW}[EWW] Tag $tag_name już istnieje${NC}" >&2
        return 1
    fi

    git tag -a "$tag_name" -m "Release $version"
    echo -e "${GREEN}[EWW] Utworzono tag: $tag_name${NC}"
}

# Główna funkcja
main() {
    local action="${1:-help}"

    check_semver

    case "$action" in
        bump)
            local bump_type="${2:-patch}"
            if [[ ! "$bump_type" =~ ^(major|minor|patch)$ ]]; then
                echo -e "${RED}[EWW] Błąd: Nieprawidłowy typ bumpu. Użyj: major, minor lub patch${NC}" >&2
                exit 1
            fi

            local new_version
            new_version=$(bump_version "$bump_type")

            # Synchronizuj frontmattery
            sync_frontmatter_versions "$new_version"

            # Opcjonalnie: utwórz tag Git
            read -p "Utworzyć tag Git v$new_version? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                create_git_tag "$new_version"
            fi
            ;;

        sync)
            local version
            version=$(get_current_version)
            validate_version "$version"
            sync_frontmatter_versions "$version"
            ;;

        validate)
            local version
            version=$(get_current_version)
            validate_version "$version"
            echo -e "${GREEN}[EWW] Wersja $version jest poprawna${NC}"
            ;;

        help|*)
            cat <<EOF
Użycie: $0 <akcja> [argumenty]

Akcje:
  bump [major|minor|patch]  Podbij wersję (domyślnie: patch)
  sync                      Synchronizuj frontmattery z VERSION
  validate                  Waliduj format wersji w VERSION
  help                      Pokaż tę pomoc

Przykłady:
  $0 bump patch             Podbij patch (0.0.1 → 0.0.2)
  $0 bump minor             Podbij minor (0.0.1 → 0.1.0)
  $0 bump major             Podbij major (0.0.1 → 1.0.0)
  $0 sync                   Zsynchronizuj wersje w frontmatterach
  $0 validate               Sprawdź poprawność wersji

Wymaga: semver (npm install -g semver)
EOF
            ;;
    esac
}

main "$@"
