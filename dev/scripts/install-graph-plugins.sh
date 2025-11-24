#!/usr/bin/env bash
# tools/install-graph-plugins.sh - Instalator pluginów do grafu Obsidian
set -euo pipefail

readonly VAULT="/home/jakubc/git/eww"
readonly PLUGIN_DIR="$VAULT/.obsidian/plugins"
readonly TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
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

install_plugin() {
    local repo="$1"
    local name="$2"
    
    log_info "Instaluję: $name z $repo..."
    
    # Czyść tmp przed każdym pluginem
    rm -rf "$TMP_DIR"/*.zip
    
    # Pobierz latest release
    if gh release download -R "$repo" -p '*.zip' -D "$TMP_DIR" 2>/dev/null; then
        local zip_file
        zip_file=$(find "$TMP_DIR" -name "*.zip" -type f | head -1)
        
        if [[ -f "$zip_file" ]]; then
            mkdir -p "$PLUGIN_DIR/$name"
            unzip -qo "$zip_file" -d "$PLUGIN_DIR/$name/"
            log_success "$name zainstalowany"
            return 0
        fi
    fi
    
    log_warn "Nie udało się zainstalować $name (brak release ZIP)"
    return 1
}

main() {
    log_info "🚀 Instalacja pluginów do grafu Obsidian"
    log_info "Vault: $VAULT"
    
    # Sprawdź gh CLI
    if ! command -v gh &>/dev/null; then
        echo "❌ GitHub CLI (gh) nie jest zainstalowane!"
        echo "Zainstaluj: sudo apt install gh"
        exit 1
    fi
    
    # Sprawdź autoryzację
    if ! gh auth status &>/dev/null; then
        echo "❌ GitHub CLI nie jest autoryzowane!"
        echo "Uruchom: gh auth login"
        exit 1
    fi
    
    echo ""
    log_info "📦 Instaluję TOP 5 pluginów grafowych..."
    
    install_plugin "zsviczian/obsidian-excalidraw-plugin" "excalidraw-obsidian"
    install_plugin "SkepticMystic/breadcrumbs" "breadcrumbs"
    install_plugin "akaalias/obsidian-journey-plugin" "obsidian-journey-plugin"
    install_plugin "TfTHacker/obsidian42-strange-new-worlds" "obsidian42-strange-new-worlds"
    install_plugin "brianpetro/obsidian-smart-connections" "smart-connections"
    
    echo ""
    log_info "🎨 Instaluję pluginy wizualizacji..."
    
    install_plugin "rien7/obsidian-colorful-tag" "obsidian-colorful-tag"
    install_plugin "FlorianWoelki/obsidian-icon-folder" "obsidian-icon-folder"
    
    echo ""
    log_success "🎉 Instalacja zakończona!"
    echo ""
    echo "📋 Następne kroki:"
    echo "  1. Przeładuj Obsidiana (Ctrl+R)"
    echo "  2. Settings → Community plugins → Włącz nowe pluginy"
    echo "  3. Skonfiguruj kolory tagów (patrz: tools/obsidian-graph-plugins.md)"
}

main "$@"
