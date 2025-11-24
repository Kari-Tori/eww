#!/usr/bin/env bash
# check-folder-notes.sh - Sprawdza kompletność folder notes
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Funkcje pomocnicze
log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Sprawdź folder notes w katalogu głównym
check_root_folders() {
    local missing=0
    local total=0

    log_info "Sprawdzam folder notes w katalogu głównym..."

    while IFS= read -r -d '' dir; do
        local basename
        basename=$(basename "$dir")
        total=$((total + 1))

        if [[ -f "$dir/$basename.md" ]]; then
            echo -e "${GREEN}✓${NC} $basename/$basename.md"
        else
            echo -e "${RED}✗${NC} BRAK: $basename/$basename.md"
            missing=$((missing + 1))
        fi
    done < <(find "$PROJECT_ROOT" -maxdepth 1 -type d ! -name ".*" ! -path "$PROJECT_ROOT" -print0 | sort -z)

    echo ""
    log_info "Znaleziono: $total katalogów"
    if [[ $missing -eq 0 ]]; then
        log_success "Wszystkie katalogi mają folder notes!"
    else
        log_warn "Brakuje folder notes: $missing"
    fi

    return $missing
}

# Sprawdź folder notes w podkatalogach
check_subdirectories() {
    local depth="${1:-2}"
    local missing=0
    local total=0

    log_info "Sprawdzam folder notes w podkatalogach (głębokość: $depth)..."

    while IFS= read -r -d '' dir; do
        local basename
        local relpath
        basename=$(basename "$dir")
        relpath="${dir#$PROJECT_ROOT/}"
        total=$((total + 1))

        if [[ -f "$dir/$basename.md" ]]; then
            echo -e "${GREEN}✓${NC} $relpath/$basename.md"
        else
            echo -e "${YELLOW}⚠${NC} BRAK: $relpath/$basename.md"
            missing=$((missing + 1))
        fi
    done < <(find "$PROJECT_ROOT" -mindepth 2 -maxdepth "$depth" -type d ! -path "*/\.*" -print0 | sort -z)

    echo ""
    log_info "Znaleziono: $total podkatalogów"
    if [[ $missing -eq 0 ]]; then
        log_success "Wszystkie podkatalogi mają folder notes!"
    else
        log_warn "Podkatalogów bez folder notes: $missing"
    fi

    return 0
}

# Generuj szablon folder note
generate_template() {
    local dir="$1"
    local basename
    local date_now

    basename=$(basename "$dir")
    date_now=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    cat <<EOF
---
tags:
  - #automation
  - #development
  - #eww
  - #folder_note
  - #knowledge
created: $date_now
modified: $date_now
author: jakubc
title: "📂 $basename"
---

# 📂 $basename

> Opis katalogu $basename

## 📋 Zawartość

TODO: Opisz zawartość katalogu

## 🔗 Powiązania

- [INDEX](../INDEX.md) — powrót do głównego indeksu

## 📊 Statystyki

\`\`\`
Pliki: $(find "$dir" -maxdepth 1 -type f | wc -l)
Podkatalogi: $(find "$dir" -maxdepth 1 -type d ! -path "$dir" | wc -l)
\`\`\`
EOF
}

# Utwórz brakujące folder notes
create_missing_notes() {
    log_info "Tworzę brakujące folder notes..."

    while IFS= read -r -d '' dir; do
        local basename
        basename=$(basename "$dir")

        if [[ ! -f "$dir/$basename.md" ]]; then
            log_info "Tworzę: $dir/$basename.md"
            generate_template "$dir" > "$dir/$basename.md"
            log_success "Utworzono: $basename/$basename.md"
        fi
    done < <(find "$PROJECT_ROOT" -maxdepth 1 -type d ! -name ".*" ! -path "$PROJECT_ROOT" -print0)
}

# Pokaż użycie
usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJE]

Sprawdza kompletność folder notes w repozytorium.

OPCJE:
    -c, --create    Utwórz brakujące folder notes
    -d, --depth N   Sprawdź podkatalogi do głębokości N (domyślnie: 2)
    -h, --help      Pokaż tę pomoc

PRZYKŁADY:
    $(basename "$0")              # Sprawdź tylko katalog główny
    $(basename "$0") -d 3         # Sprawdź do 3 poziomów
    $(basename "$0") -c           # Utwórz brakujące w głównym katalogu
EOF
}

# Główna funkcja
main() {
    local create_mode=false
    local depth=2

    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--create)
                create_mode=true
                shift
                ;;
            -d|--depth)
                depth="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                log_error "Nieznana opcja: $1"
                usage
                exit 1
                ;;
        esac
    done

    cd "$PROJECT_ROOT" || {
        log_error "Nie można przejść do katalogu projektu: $PROJECT_ROOT"
        exit 1
    }

    echo ""
    log_info "=== Sprawdzanie folder notes w E-Waste Workshop ==="
    echo ""

    if [[ "$create_mode" = true ]]; then
        create_missing_notes
        echo ""
    fi

    check_root_folders
    echo ""

    if [[ $depth -gt 1 ]]; then
        check_subdirectories "$depth"
        echo ""
    fi

    log_success "Sprawdzanie zakończone!"
}

main "$@"
