#!/usr/bin/env bash
# File: scripts/eww-obsidian-fix.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# bugfix
# repair
# script
# eww-obsidian-fix.sh - Naprawa konfiguracji Obsidian dla repo eww
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
EWW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly EWW_ROOT
readonly OBSIDIAN_CONFIG="$HOME/.config/obsidian/obsidian.json"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Wyświetl użycie
usage() {
    cat <<EOF
Użycie: $(basename "$0") [OPCJA]

Naprawa konfiguracji Obsidian dla repo eww.

OPCJE:
    -c, --check     Sprawdź konfigurację bez zmian
    -f, --fix       Napraw ścieżki w konfiguracji
    -h, --help      Wyświetl tę pomoc

PRZYKŁADY:
    $(basename "$0") --check
    $(basename "$0") --fix

EOF
}

# Sprawdź konfigurację
check_config() {
    echo -e "${BLUE}=== Sprawdzanie konfiguracji Obsidian ===${NC}"
    echo ""

    if [[ ! -f "$OBSIDIAN_CONFIG" ]]; then
        echo -e "${RED}❌ Brak pliku konfiguracji: $OBSIDIAN_CONFIG${NC}"
        return 1
    fi

    echo -e "${GREEN}✅ Plik konfiguracji istnieje${NC}"
    echo ""

    echo "Zarejestrowane vaults:"
    python3 -c "
import json
with open('$OBSIDIAN_CONFIG') as f:
    config = json.load(f)
    for vault_id, vault_info in config.get('vaults', {}).items():
        path = vault_info.get('path', 'N/A')
        open_status = '🟢 OTWARTY' if vault_info.get('open', False) else '⚪ ZAMKNIĘTY'
        print(f'  • {path} {open_status}')
" 2>/dev/null || cat "$OBSIDIAN_CONFIG"

    echo ""
    echo "Weryfikacja ścieżek:"

    # Sprawdź czy istnieje główny vault
    if [[ -d "$EWW_ROOT/.obsidian" ]]; then
        echo -e "  ${GREEN}✅ $EWW_ROOT - OK${NC}"
    else
        echo -e "  ${RED}❌ $EWW_ROOT - brak .obsidian${NC}"
    fi

    # Sprawdź vault karinam
    if [[ -d "$EWW_ROOT/usr/karinam/.obsidian" ]]; then
        echo -e "  ${GREEN}✅ $EWW_ROOT/usr/karinam - OK${NC}"
    else
        echo -e "  ${YELLOW}⚠️  $EWW_ROOT/usr/karinam - brak .obsidian${NC}"
    fi
}

# Napraw konfigurację
fix_config() {
    echo -e "${BLUE}=== Naprawa konfiguracji Obsidian ===${NC}"
    echo ""

    if [[ ! -f "$OBSIDIAN_CONFIG" ]]; then
        echo -e "${RED}❌ Brak pliku konfiguracji do naprawy${NC}"
        return 1
    fi

    # Backup
    local backup
    backup="${OBSIDIAN_CONFIG}.bak.$(date +%Y%m%d_%H%M%S)"
    cp "$OBSIDIAN_CONFIG" "$backup"
    echo -e "${GREEN}✅ Utworzono backup: $backup${NC}"

    # Zamień błędne ścieżki
    local current_user
    current_user=$(whoami)

    sed -i "s|/home/[^/]*/git/eww|/home/$current_user/git/eww|g" "$OBSIDIAN_CONFIG"

    echo -e "${GREEN}✅ Poprawiono ścieżki dla użytkownika: $current_user${NC}"
    echo ""

    check_config
}

# Main
main() {
    local action="check"

    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--check)
                action="check"
                shift
                ;;
            -f|--fix)
                action="fix"
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
        check)
            check_config
            ;;
        fix)
            fix_config
            ;;
    esac
}

main "$@"
