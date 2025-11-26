#!/usr/bin/env bash
set -euo pipefail

# eww-connect-graph.sh - Automatyczne łączenie grafu projektu
# Znajduje izolowane pliki i tworzy inteligentne połączenia

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly EWW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Znajdź powiązane pliki na podstawie:
# - Wspólnych tagów
# - Wspólnych słów kluczowych
# - Wspólnej kategorii
# - Podobnych tytułów
find_related_files() {
    local file="$1"
    local -a related=()

    # Pobierz metadane pliku
    local tags category keywords title
    tags=$(grep -A 20 "^tags:" "$file" 2>/dev/null | grep "  - " | sed 's/.*- //' | tr '\n' '|' | sed 's/|$//')
    category=$(grep "^category:" "$file" 2>/dev/null | cut -d':' -f2 | xargs)
    keywords=$(grep -A 10 "^keywords:" "$file" 2>/dev/null | grep "  - " | sed 's/.*- //' | tr '\n' '|' | sed 's/|$//')
    title=$(grep "^title:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)

    # Szukaj plików o podobnych tagach
    if [ -n "$tags" ]; then
        while IFS= read -r other; do
            [ "$other" = "$file" ] && continue
            if grep -q "$tags" "$other" 2>/dev/null; then
                local rel_path
                rel_path=$(realpath --relative-to="$EWW_ROOT" "$other")
                related+=("$rel_path")
            fi
        done < <(find "$EWW_ROOT/docs" -name "*.md" -type f ! -path "*/archive/*" 2>/dev/null | head -100)
    fi

    # Szukaj w tej samej kategorii
    if [ -n "$category" ] && [ "$category" != "docs" ]; then
        while IFS= read -r other; do
            [ "$other" = "$file" ] && continue
            if grep -q "^category: $category$" "$other" 2>/dev/null; then
                local rel_path
                rel_path=$(realpath --relative-to="$EWW_ROOT" "$other")
                related+=("$rel_path")
            fi
        done < <(find "$EWW_ROOT" -name "*.md" -type f ! -path "*/archive/*" ! -path "*/.git/*" 2>/dev/null | head -50)
    fi

    # Zwróć unikalne, max 5
    printf '%s\n' "${related[@]}" | sort -u | head -5
}

# Aktualizuj related w pliku
update_related() {
    local file="$1"
    shift
    local -a new_related=("$@")

    [ ${#new_related[@]} -eq 0 ] && return 0

    # Backup
    cp "$file" "$file.bak"

    # Znajdź linię 'related:'
    local related_line
    related_line=$(grep -n "^related:" "$file" | cut -d':' -f1)

    if [ -n "$related_line" ]; then
        # Usuń stare related (do następnej sekcji)
        local next_section
        next_section=$(tail -n +"$((related_line + 1))" "$file" | grep -n "^[a-z]" | head -1 | cut -d':' -f1)

        if [ -n "$next_section" ]; then
            # Mamy następną sekcję
            {
                head -n "$related_line" "$file"
                for rel in "${new_related[@]}"; do
                    echo "  - $rel"
                done
                tail -n +"$((related_line + next_section))" "$file"
            } > "$file.tmp"
        else
            # related jest ostatnim polem
            {
                head -n "$related_line" "$file"
                for rel in "${new_related[@]}"; do
                    echo "  - $rel"
                done
            } > "$file.tmp"
        fi

        mv "$file.tmp" "$file"
        rm "$file.bak"
        return 0
    fi

    rm "$file.bak"
    return 1
}

# Główna funkcja łącząca graf
connect_graph() {
    local dry_run="${1:-false}"
    local target_dir="${2:-docs}"

    echo -e "${BLUE}=== Łączenie grafu projektu ===${NC}"
    echo ""

    local total=0
    local connected=0
    local failed=0

    while IFS= read -r file; do
        ((total++))

        # Sprawdź czy izolowany
        if ! grep -q "^backlinks: \[\]$" "$file" 2>/dev/null; then
            continue
        fi

        if ! grep -q "^related:$\|^related:\s*$" "$file" 2>/dev/null; then
            continue
        fi

        echo -e "${YELLOW}🔴 Izolowany:${NC} $file"

        # Znajdź powiązania
        local -a related
        mapfile -t related < <(find_related_files "$file")

        if [ ${#related[@]} -eq 0 ]; then
            echo -e "  ${RED}❌ Brak kandydatów do połączenia${NC}"
            ((failed++))
            continue
        fi

        echo -e "  ${GREEN}✅ Znaleziono ${#related[@]} powiązań:${NC}"
        for rel in "${related[@]}"; do
            echo -e "    → $rel"
        done

        if [ "$dry_run" = "false" ]; then
            if update_related "$file" "${related[@]}"; then
                ((connected++))
                echo -e "  ${GREEN}✅ Zaktualizowano${NC}"
            else
                ((failed++))
                echo -e "  ${RED}❌ Błąd aktualizacji${NC}"
            fi
        fi

        echo ""
    done < <(find "$EWW_ROOT/$target_dir" -name "*.md" -type f ! -path "*/archive/*" 2>/dev/null)

    echo -e "${BLUE}=== Podsumowanie ===${NC}"
    echo "Całkowita liczba plików: $total"
    echo "Połączone: $connected"
    echo "Błędy: $failed"
    echo "Pozostałe izolowane: $((total - connected - failed))"
}

# Generuj raport grafu
generate_graph_report() {
    echo "=== RAPORT GRAFU PROJEKTU ==="
    echo ""
    echo "Data: $(date +%Y-%m-%d)"
    echo ""

    local total
    total=$(find "$EWW_ROOT/docs" -name "*.md" -type f ! -path "*/archive/*" 2>/dev/null | wc -l)

    echo "📊 Statystyka:"
    echo "  Pliki .md: $total"
    echo ""

    echo "🔴 Izolowane pliki (próbka 20):"
    find "$EWW_ROOT/docs" -name "*.md" -type f ! -path "*/archive/*" 2>/dev/null | head -50 | while read f; do
        if grep -q "^backlinks: \[\]$" "$f" 2>/dev/null; then
            if grep -q "^related:$" "$f" 2>/dev/null || ! grep -q "^related:" "$f" 2>/dev/null; then
                echo "  - $(realpath --relative-to="$EWW_ROOT" "$f")"
            fi
        fi
    done | head -20
}

usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJE]

Automatycznie łączy izolowane pliki w grafie projektu.

OPCJE:
    -d, --dry-run      Podgląd bez zmian
    -r, --report       Generuj raport grafu
    -t, --target DIR   Katalog docelowy (domyślnie: docs)
    -h, --help         Wyświetl pomoc

PRZYKŁADY:
    $(basename "$0") --dry-run           # Podgląd
    $(basename "$0")                     # Połącz wszystkie
    $(basename "$0") --report            # Raport
    $(basename "$0") --target business   # Tylko business/

EOF
}

main() {
    local dry_run=false
    local show_report=false
    local target_dir="docs"

    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                dry_run=true
                shift
                ;;
            -r|--report)
                show_report=true
                shift
                ;;
            -t|--target)
                target_dir="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Nieznana opcja: $1"
                usage
                exit 1
                ;;
        esac
    done

    if [ "$show_report" = "true" ]; then
        generate_graph_report
        exit 0
    fi

    connect_graph "$dry_run" "$target_dir"
}

main "$@"
