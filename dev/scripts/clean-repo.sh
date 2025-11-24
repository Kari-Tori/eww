#!/usr/bin/env bash
# clean-repo.sh - Utrzymanie czystości repozytorium
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

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Sprawdź czystość struktury
check_structure() {
    local issues=0
    
    log_info "Sprawdzam strukturę repozytorium..."
    echo ""
    
    # 1. Pliki .bak.*
    local bak_count
    bak_count=$(find "$PROJECT_ROOT" -name "*.bak.*" -type f 2>/dev/null | wc -l)
    if [[ $bak_count -gt 0 ]]; then
        log_warn "Znaleziono $bak_count plików .bak.*"
        issues=$((issues + 1))
    else
        log_success "Brak plików .bak.*"
    fi
    
    # 2. Skrypty .sh w root (oprócz setup)
    local root_scripts
    root_scripts=$(find "$PROJECT_ROOT" -maxdepth 1 -name "*.sh" -type f ! -name "init-eww.sh" ! -name "install-waypoint.sh" ! -name "setup-git-remote.sh" 2>/dev/null | wc -l)
    if [[ $root_scripts -gt 0 ]]; then
        log_warn "Skrypty .sh w root (powinny być w scripts/): $root_scripts"
        find "$PROJECT_ROOT" -maxdepth 1 -name "*.sh" -type f ! -name "init-eww.sh" ! -name "install-waypoint.sh" ! -name "setup-git-remote.sh" | sed 's|.*/|  - |'
        issues=$((issues + 1))
    else
        log_success "Tylko skrypty setup w root"
    fi
    
    # 3. Pliki .md w root (oprócz dozwolonych)
    local allowed_md="README.md CHANGELOG.md INDEX.md EWW-MAP.md STATUS-REPO.md"
    local extra_md=0
    while IFS= read -r -d '' file; do
        local basename
        basename=$(basename "$file")
        if ! echo "$allowed_md" | grep -q "$basename"; then
            if [[ $extra_md -eq 0 ]]; then
                log_warn "Dodatkowe pliki .md w root:"
            fi
            echo "  - $basename"
            extra_md=$((extra_md + 1))
            issues=$((issues + 1))
        fi
    done < <(find "$PROJECT_ROOT" -maxdepth 1 -name "*.md" -type f -print0)
    
    if [[ $extra_md -eq 0 ]]; then
        log_success "Tylko dozwolone pliki .md w root"
    fi
    
    # 4. Folder notes w odpowiednich miejscach
    local missing_fn=0
    for dir in docs infra scripts usr var tools dev business core config; do
        if [[ -d "$PROJECT_ROOT/$dir" && ! -f "$PROJECT_ROOT/$dir/$dir.md" ]]; then
            if [[ $missing_fn -eq 0 ]]; then
                log_warn "Katalogi bez folder notes:"
            fi
            echo "  - $dir/$dir.md"
            missing_fn=$((missing_fn + 1))
            issues=$((issues + 1))
        fi
    done
    
    if [[ $missing_fn -eq 0 ]]; then
        log_success "Wszystkie główne katalogi mają folder notes"
    fi
    
    echo ""
    if [[ $issues -eq 0 ]]; then
        log_success "Struktura repozytorium czysta! ✨"
        return 0
    else
        log_warn "Znaleziono $issues problemów"
        return 1
    fi
}

# Wyczyść pliki .bak.*
clean_backups() {
    log_info "Czyszczę pliki .bak.*..."
    
    local count
    count=$(find "$PROJECT_ROOT" -name "*.bak.*" -type f 2>/dev/null | wc -l)
    
    if [[ $count -eq 0 ]]; then
        log_info "Brak plików do usunięcia"
        return 0
    fi
    
    find "$PROJECT_ROOT" -name "*.bak.*" -type f -delete 2>/dev/null
    log_success "Usunięto $count plików .bak.*"
}

# Raport statystyk
show_stats() {
    log_info "Statystyki repozytorium"
    echo ""
    
    echo "📊 Struktura:"
    echo "  Pliki .md:      $(find "$PROJECT_ROOT" -name "*.md" -type f 2>/dev/null | wc -l)"
    echo "  Pliki .sh:      $(find "$PROJECT_ROOT" -name "*.sh" -type f 2>/dev/null | wc -l)"
    echo "  Katalogi:       $(find "$PROJECT_ROOT" -maxdepth 1 -type d ! -name ".*" ! -path "$PROJECT_ROOT" | wc -l)"
    echo ""
    
    echo "📁 Root:"
    echo "  .md w root:     $(find "$PROJECT_ROOT" -maxdepth 1 -name "*.md" -type f | wc -l)"
    echo "  .sh w root:     $(find "$PROJECT_ROOT" -maxdepth 1 -name "*.sh" -type f | wc -l)"
    echo ""
    
    echo "🗑️ Tymczasowe:"
    echo "  Pliki .bak.*:   $(find "$PROJECT_ROOT" -name "*.bak.*" -type f 2>/dev/null | wc -l)"
    echo "  Pliki .tmp:     $(find "$PROJECT_ROOT" -name "*.tmp" -type f 2>/dev/null | wc -l)"
}

# Pomoc
usage() {
    cat << EOF
Użycie: $(basename "$0") [KOMENDA]

Utrzymanie czystości struktury repozytorium.

KOMENDY:
    check       Sprawdź czystość struktury (domyślnie)
    clean       Wyczyść pliki .bak.*
    stats       Pokaż statystyki
    help        Pokaż tę pomoc

PRZYKŁADY:
    $(basename "$0")              # Sprawdź strukturę
    $(basename "$0") check        # Sprawdź strukturę
    $(basename "$0") clean        # Wyczyść backupy
    $(basename "$0") stats        # Pokaż statystyki
EOF
}

# Główna funkcja
main() {
    local command="${1:-check}"
    
    cd "$PROJECT_ROOT" || {
        log_error "Nie można przejść do: $PROJECT_ROOT"
        exit 1
    }
    
    case "$command" in
        check)
            check_structure
            ;;
        clean)
            clean_backups
            ;;
        stats)
            show_stats
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            log_error "Nieznana komenda: $command"
            usage
            exit 1
            ;;
    esac
}

main "$@"
