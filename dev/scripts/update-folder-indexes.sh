#!/usr/bin/env bash
# update-folder-indexes.sh - Dodaje indeksy zawartości do folder notes
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

# Generuj indeks plików markdown w katalogu
generate_files_index() {
    local dir="$1"
    local output=""

    # Znajdź wszystkie pliki .md (poza folder note)
    local basename
    basename=$(basename "$dir")

    while IFS= read -r -d '' file; do
        local filename
        filename=$(basename "$file")
        local name="${filename%.md}"
        output+="- [$name]($filename)\n"
    done < <(find "$dir" -maxdepth 1 -type f -name "*.md" ! -name "$basename.md" -print0 | sort -z)

    if [[ -z "$output" ]]; then
        echo "*Brak plików markdown.*"
    else
        echo -e "$output"
    fi
}

# Generuj indeks podfolderów
generate_subfolders_index() {
    local dir="$1"
    local output=""

    while IFS= read -r -d '' subdir; do
        local subdirname
        subdirname=$(basename "$subdir")

        # Sprawdź czy ma folder note
        if [[ -f "$subdir/$subdirname.md" ]]; then
            output+="- [$subdirname/]($subdirname/$subdirname.md)\n"
        else
            output+="- \`$subdirname/\` (brak folder note)\n"
        fi
    done < <(find "$dir" -maxdepth 1 -type d ! -path "$dir" ! -name ".*" -print0 | sort -z)

    if [[ -z "$output" ]]; then
        echo "*Brak podfolderów.*"
    else
        echo -e "$output"
    fi
}

# Aktualizuj folder note z indeksem
update_folder_note() {
    local dir="$1"
    local basename
    basename=$(basename "$dir")
    local folder_note="$dir/$basename.md"

    if [[ ! -f "$folder_note" ]]; then
        log_warn "Brak folder note: $folder_note"
        return 1
    fi

    log_info "Aktualizuję: $folder_note"

    # Backup
    cp "$folder_note" "$folder_note.bak.$(date +%s)"

    # Wygeneruj indeksy
    local files_index
    local subfolders_index
    files_index=$(generate_files_index "$dir")
    subfolders_index=$(generate_subfolders_index "$dir")

    # Sprawdź czy już ma sekcje INDEX
    if grep -q "## 📑 Index plików" "$folder_note" 2>/dev/null; then
        log_info "  Aktualizuję istniejący indeks (zastępuję sekcje)"

        # Użyj prostszego podejścia - wytnij stare sekcje i dodaj nowe
        local temp_file
        temp_file=$(mktemp)

        # Skopiuj wszystko przed sekcją INDEX
        awk '/^## 📑 Index plików/ {exit} {print}' "$folder_note" > "$temp_file"

        # Dodaj nowe indeksy
        {
            echo "## 📑 Index plików"
            echo ""
            echo "$files_index"
            echo ""
            echo "## 📁 Podfoldery"
            echo ""
            echo "$subfolders_index"
        } >> "$temp_file"

        # Dodaj sekcje które były po indeksach (jeśli są)
        awk '/^## 📁 Podfoldery/,/^## / {if (/^## / && !/^## 📁 Podfoldery/) found=1} found {print}' "$folder_note" >> "$temp_file"

        mv "$temp_file" "$folder_note"

    else
        log_info "  Dodaję nowy indeks na końcu"

        # Dodaj na końcu pliku
        {
            cat "$folder_note"
            echo ""
            echo "## 📑 Index plików"
            echo ""
            echo "$files_index"
            echo ""
            echo "## 📁 Podfoldery"
            echo ""
            echo "$subfolders_index"
        } > "$folder_note.tmp"

        mv "$folder_note.tmp" "$folder_note"
    fi

    log_success "  Zaktualizowano: $basename/$basename.md"
}

# Aktualizuj wszystkie folder notes
update_all() {
    local depth="${1:-1}"
    local count=0

    log_info "Aktualizuję folder notes (głębokość: $depth)..."
    echo ""

    if [[ $depth -eq 1 ]]; then
        # Tylko katalogi główne
        while IFS= read -r -d '' dir; do
            update_folder_note "$dir" && count=$((count + 1))
            echo ""
        done < <(find "$PROJECT_ROOT" -maxdepth 1 -type d ! -path "$PROJECT_ROOT" ! -name ".*" -print0 | sort -z)
    else
        # Wszystkie katalogi do głębokości N
        while IFS= read -r -d '' dir; do
            update_folder_note "$dir" && count=$((count + 1))
            echo ""
        done < <(find "$PROJECT_ROOT" -maxdepth "$depth" -type d ! -path "$PROJECT_ROOT" ! -path "*/.git/*" ! -path "*/.obsidian/*" ! -path "*/.vscode/*" ! -path "*/node_modules/*" -print0 | sort -z)
    fi

    log_success "Zaktualizowano $count folder notes"
}

# Aktualizuj jeden folder
update_one() {
    local target="$1"

    if [[ ! -d "$target" ]]; then
        log_warn "Katalog nie istnieje: $target"
        return 1
    fi

    update_folder_note "$target"
}

# Pokaż pomoc
usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJE] [KATALOG]

Dodaje/aktualizuje indeksy zawartości w folder notes.

OPCJE:
    -a, --all       Aktualizuj wszystkie folder notes (domyślnie poziom 1)
    -d, --depth N   Głębokość katalogów (1-5, domyślnie 1)
    -h, --help      Pokaż tę pomoc

ARGUMENTY:
    KATALOG         Ścieżka do konkretnego katalogu do aktualizacji

PRZYKŁADY:
    $(basename "$0")              # Aktualizuj główne (poziom 1)
    $(basename "$0") -a           # Aktualizuj główne (poziom 1)
    $(basename "$0") -a -d 2      # Aktualizuj do poziomu 2
    $(basename "$0") -a -d 3      # Aktualizuj do poziomu 3 (wszystkie!)
    $(basename "$0") docs         # Aktualizuj tylko docs/
    $(basename "$0") dev/bin      # Aktualizuj tylko dev/bin/
EOF
}

# Główna funkcja
main() {
    local mode="all"
    local target=""
    local depth=1

    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--all)
                mode="all"
                shift
                ;;
            -d|--depth)
                depth="$2"
                if [[ ! "$depth" =~ ^[1-5]$ ]]; then
                    log_warn "Głębokość musi być 1-5, użyto: $depth"
                    exit 1
                fi
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            -*)
                log_warn "Nieznana opcja: $1"
                usage
                exit 1
                ;;
            *)
                target="$1"
                mode="one"
                shift
                ;;
        esac
    done

    cd "$PROJECT_ROOT" || {
        log_warn "Nie można przejść do: $PROJECT_ROOT"
        exit 1
    }

    if [[ "$mode" == "all" ]]; then
        update_all "$depth"
    else
        update_one "$target"
    fi

    log_success "Gotowe!"
}

main "$@"
