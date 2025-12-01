#!/usr/bin/env bash
# File: scripts/eww-vscode-fix.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# bugfix
# repair
# script
# eww-vscode-fix.sh - Naprawa typowych problemów VS Code
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

readonly VSCODE_CONFIG="$HOME/.config/Code"

usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJA]

Naprawa typowych problemów VS Code.

OPCJE:
    -c, --cache         Wyczyść cache i Service Workers
    -e, --extensions    Sprawdź problematyczne rozszerzenia
    -a, --all           Wykonaj pełne czyszczenie
    -h, --help          Wyświetl tę pomoc

PROBLEMY I ROZWIĄZANIA:
    Service Worker Error    → --cache
    Wolne działanie        → --cache
    Błędy rozszerzeń       → --extensions

PRZYKŁADY:
    $(basename "$0") --cache
    $(basename "$0") --all

EOF
}

# Wyczyść cache
clear_cache() {
    echo -e "${BLUE}=== Czyszczenie cache VS Code ===${NC}"
    echo ""

    if [[ ! -d "$VSCODE_CONFIG" ]]; then
        echo -e "${RED}❌ Katalog VS Code nie istnieje: $VSCODE_CONFIG${NC}"
        return 1
    fi

    # Pokaż rozmiar przed
    echo "Rozmiar przed czyszczeniem:"
    du -sh "$VSCODE_CONFIG/Cache" 2>/dev/null || echo "  Brak cache"
    du -sh "$VSCODE_CONFIG/CachedData" 2>/dev/null || echo "  Brak CachedData"
    du -sh "$VSCODE_CONFIG/Service Worker" 2>/dev/null || echo "  Brak Service Worker"
    echo ""

    # Usuń cache
    local removed=0

    if rm -rf "$VSCODE_CONFIG/Cache"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono Cache${NC}"
        ((removed++))
    fi

    if rm -rf "$VSCODE_CONFIG/CachedData"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono CachedData${NC}"
        ((removed++))
    fi

    if rm -rf "$VSCODE_CONFIG/CachedExtensions"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono CachedExtensions${NC}"
        ((removed++))
    fi

    if rm -rf "$VSCODE_CONFIG/Service Worker"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono Service Worker${NC}"
        ((removed++))
    fi

    if rm -rf "$VSCODE_CONFIG/GPUCache"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono GPUCache${NC}"
        ((removed++))
    fi

    echo ""
    echo -e "${YELLOW}⚠️  Musisz zrestartować VS Code (Ctrl+Q, potem uruchom ponownie)${NC}"
    echo ""
    echo "Wyczyszczono katalogów: $removed"
}

# Sprawdź rozszerzenia
check_extensions() {
    echo -e "${BLUE}=== Sprawdzanie rozszerzeń VS Code ===${NC}"
    echo ""

    if ! command -v code &> /dev/null; then
        echo -e "${RED}❌ Komenda 'code' nie jest dostępna${NC}"
        return 1
    fi

    echo "Zainstalowane rozszerzenia:"
    local ext_count
    ext_count=$(code --list-extensions 2>/dev/null | wc -l)
    echo "  Liczba: $ext_count"
    echo ""

    echo "Potencjalnie problematyczne rozszerzenia:"
    code --list-extensions 2>/dev/null | while read -r ext; do
        # Lista znanych problematycznych rozszerzeń
        case "$ext" in
            *deprecated*|*old*|*legacy*)
                echo -e "  ${YELLOW}⚠️  $ext${NC}"
                ;;
        esac
    done

    echo ""
    echo "💡 Aby wyłączyć rozszerzenie:"
    echo "   code --disable-extension ID_ROZSZERZENIA"
}

# Pełne czyszczenie
full_cleanup() {
    echo -e "${BLUE}=== Pełne czyszczenie VS Code ===${NC}"
    echo ""

    clear_cache

    echo ""
    echo -e "${BLUE}=== Dodatkowe czyszczenie ===${NC}"

    # Logi
    if rm -rf "$VSCODE_CONFIG/logs"/* 2>/dev/null; then
        echo -e "${GREEN}✅ Wyczyszczono logi${NC}"
    fi

    # Workspace storage
    if [[ -d "$VSCODE_CONFIG/User/workspaceStorage" ]]; then
        local ws_size
        ws_size=$(du -sh "$VSCODE_CONFIG/User/workspaceStorage" 2>/dev/null | cut -f1)
        echo -e "${YELLOW}⚠️  workspaceStorage: $ws_size (NIE usunięto - zawiera ustawienia workspace)${NC}"
    fi

    echo ""
    echo -e "${GREEN}✅ Pełne czyszczenie zakończone${NC}"
}

# Main
main() {
    local action="cache"

    if [[ $# -eq 0 ]]; then
        usage
        exit 0
    fi

    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--cache)
                action="cache"
                shift
                ;;
            -e|--extensions)
                action="extensions"
                shift
                ;;
            -a|--all)
                action="all"
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo -e "${RED}Nieznana opcja: $1${NC}"
                usage
                exit 1
                ;;
        esac
    done

    case $action in
        cache)
            clear_cache
            ;;
        extensions)
            check_extensions
            ;;
        all)
            full_cleanup
            ;;
    esac
}

main "$@"
