#!/usr/bin/env bash
# install-obsidian-waypoint.sh - Instalator pluginu Waypoint dla Obsidian (bez gh-cli)
set -euo pipefail

# Kolory dla output
readonly GREEN='\033[0;32m'
readonly BLUE='\033[1;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Domyślna lokalizacja vaulta
readonly DEFAULT_VAULT="${EWW_ROOT:-.}"
readonly PLUGIN_NAME="waypoint"
readonly REPO="IdreesInc/Waypoint"

# Funkcja wyświetlająca użycie
usage() {
    cat <<EOF
${BLUE}[EWW]${NC} Instalator pluginu Waypoint dla Obsidian

${GREEN}Użycie:${NC}
    $0 [VAULT_PATH]

${GREEN}Argumenty:${NC}
    VAULT_PATH    Ścieżka do vaulta Obsidian (domyślnie: ${DEFAULT_VAULT})

${GREEN}Przykład:${NC}
    $0                           # Instaluje w bieżącym katalogu
    $0 ~/Obsidian/vault          # Instaluje w określonym vaulcie

${GREEN}Wymagania:${NC}
    - curl, unzip

EOF
}

# Logowanie
log_info() {
    echo -e "${BLUE}[EWW]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW]${NC} ✅ $*"
}

log_warn() {
    echo -e "${YELLOW}[EWW]${NC} ⚠️  $*" >&2
}

log_error() {
    echo -e "${RED}[EWW]${NC} ❌ $*" >&2
}

# Sprawdź wymagane narzędzia
check_requirements() {
    local missing=()
    
    if ! command -v curl &>/dev/null; then
        missing+=("curl")
    fi
    
    if ! command -v unzip &>/dev/null; then
        missing+=("unzip")
    fi
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Brakujące narzędzia: ${missing[*]}"
        log_info "Zainstaluj: sudo apt install curl unzip"
        return 1
    fi
    return 0
}

# Pobierz URL zipa z GitHub API
get_latest_asset_url() {
    curl -s "https://api.github.com/repos/${REPO}/releases/latest" | \
        awk -F'"' '/browser_download_url/ && /\.zip/ {print $4; exit}'
}

# Pobierz i zainstaluj plugin
install_waypoint() {
    local vault_path="$1"
    local plugin_dir="${vault_path}/.obsidian/plugins/${PLUGIN_NAME}"
    local tmp_dir
    
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT
    
    log_info "📥 Pobieram najnowszą wersję Waypoint z GitHub..."
    
    local asset_url
    asset_url=$(get_latest_asset_url)
    
    if [[ -z "$asset_url" ]]; then
        log_error "Nie można odnaleźć archiwum .zip w najnowszym release"
        return 1
    fi
    
    log_info "⬇️  Pobieranie archiwum: ${asset_url##*/}"
    if ! curl -L "$asset_url" -o "$tmp_dir/waypoint.zip"; then
        log_error "Nie udało się pobrać ${asset_url}"
        return 1
    fi
    
    # Rozpakuj
    log_info "📦 Rozpakowywanie..."
    local zip_file="$tmp_dir/waypoint.zip"
    
    if [[ ! -f "$zip_file" ]]; then
        log_error "Nie znaleziono pobranego archiwum"
        return 1
    fi
    
    unzip -qo "$zip_file" -d "$tmp_dir/waypoint"
    
    # Skopiuj pliki
    log_info "📋 Kopiowanie plików do ${plugin_dir}..."
    mkdir -p "$plugin_dir"
    
    # Szukaj plików pluginu (main.js, manifest.json)
    local source_dir
    if [[ -f "$tmp_dir/waypoint/main.js" ]]; then
        source_dir="$tmp_dir/waypoint"
    elif [[ -f "$tmp_dir/waypoint/waypoint/main.js" ]]; then
        source_dir="$tmp_dir/waypoint/waypoint"
    else
        # Szukaj rekurencyjnie
        source_dir=$(find "$tmp_dir/waypoint" -name "main.js" -type f -exec dirname {} \; | head -1)
    fi
    
    if [[ -z "$source_dir" ]] || [[ ! -f "$source_dir/main.js" ]]; then
        log_error "Nie znaleziono plików pluginu (main.js)"
        return 1
    fi
    
    cp -r "$source_dir"/* "$plugin_dir/"
    
    log_success "Plugin Waypoint zainstalowany!"
    log_info ""
    log_info "📝 Następne kroki:"
    log_info "   1. Uruchom ponownie Obsidian"
    log_info "   2. Settings → Community plugins → Włącz 'Waypoint'"
    log_info ""
    log_info "📂 Lokalizacja: ${plugin_dir}"
}

# Funkcja główna
main() {
    if [[ $# -gt 0 ]] && [[ "$1" == "-h" || "$1" == "--help" ]]; then
        usage
        exit 0
    fi
    
    local vault_path="${1:-$DEFAULT_VAULT}"
    
    # Rozwiń ścieżkę
    vault_path=$(realpath "$vault_path")
    
    log_info "🚀 Instalator pluginu Waypoint dla Obsidian"
    log_info "Vault: ${vault_path}"
    log_info ""
    
    # Sprawdź czy katalog istnieje
    if [[ ! -d "$vault_path" ]]; then
        log_error "Katalog nie istnieje: ${vault_path}"
        exit 1
    fi
    
    # Sprawdź czy to vault Obsidian
    if [[ ! -d "${vault_path}/.obsidian" ]]; then
        log_warn "Katalog ${vault_path} nie wygląda na vault Obsidian (brak .obsidian/)"
        read -p "Kontynuować? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Anulowano"
            exit 0
        fi
    fi
    
    # Sprawdź wymagania
    if ! check_requirements; then
        exit 1
    fi
    
    # Instaluj
    if install_waypoint "$vault_path"; then
        log_success "Instalacja zakończona pomyślnie! 🎉"
        exit 0
    else
        log_error "Instalacja nie powiodła się"
        exit 1
    fi
}

main "$@"
