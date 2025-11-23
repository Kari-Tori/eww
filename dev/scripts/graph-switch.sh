#!/usr/bin/env bash
# graph-switch.sh - Szybkie przełączanie presetów grafu Obsidiana
set -euo pipefail

readonly OBSIDIAN_DIR="/home/jakubc/git/eww/.obsidian"
readonly GRAPH_JSON="${OBSIDIAN_DIR}/graph.json"
readonly BACKUP_DIR="${OBSIDIAN_DIR}/graph-backups"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Sprawdź czy Obsidian jest uruchomiony
obsidian_running() {
    pgrep -f "obsidian" >/dev/null 2>&1
}

# Backup obecnej konfiguracji
backup_current() {
    mkdir -p "$BACKUP_DIR"
    local timestamp=$(date +%Y%m%d-%H%M%S)
    cp "$GRAPH_JSON" "${BACKUP_DIR}/graph-${timestamp}.json"
    echo -e "${GREEN}✓${NC} Backup: ${BACKUP_DIR}/graph-${timestamp}.json"
}

# Lista dostępnych presetów
list_presets() {
    echo -e "${BLUE}Dostępne presety grafu:${NC}\n"

    echo "1. ULTIMATE      - Zoptymalizowany dla 927 plików (aktywny)"
    echo "2. BUSINESS      - Tylko business/ (governance, processes, methodologies)"
    echo "3. JAKUBC        - Tylko usr/jakubc/ i #secondbrain"
    echo "4. DEV           - Tylko dev/ (scripts, lib, Playbooks, Projects)"
    echo "5. MINIMAL       - Tylko indexy (README, INDEX, #folder_note)"
    echo "6. PERFORMANCE   - Max wydajność dla słabszego laptopa"
    echo ""
}

# Przełącz na wybrany preset
switch_preset() {
    local preset="$1"
    local source_file=""

    case "$preset" in
        1|ultimate)
            echo -e "${YELLOW}Aktualnie używany preset${NC}"
            return 0
            ;;
        2|business)
            source_file="${OBSIDIAN_DIR}/graph-business.json"
            ;;
        3|jakubc)
            source_file="${OBSIDIAN_DIR}/graph-jakubc.json"
            ;;
        4|dev)
            source_file="${OBSIDIAN_DIR}/graph-dev.json"
            ;;
        5|minimal)
            source_file="${OBSIDIAN_DIR}/graph-minimal.json"
            ;;
        6|performance)
            source_file="${OBSIDIAN_DIR}/graph-performance.json"
            ;;
        *)
            echo -e "${RED}✗${NC} Nieznany preset: $preset"
            return 1
            ;;
    esac

    if [[ ! -f "$source_file" ]]; then
        echo -e "${RED}✗${NC} Plik presetu nie istnieje: $source_file"
        return 1
    fi

    # Backup + zamiana
    backup_current
    cp "$source_file" "$GRAPH_JSON"
    echo -e "${GREEN}✓${NC} Załadowano preset: $(basename "$source_file")"

    # Sprawdź czy Obsidian wymaga restartu
    if obsidian_running; then
        echo -e "${YELLOW}⚠${NC} Obsidian jest uruchomiony - restart zalecany"
        echo -e "   Uruchom: ${BLUE}pkill -f obsidian && obsidian${NC}"
    fi
}

# Restore backup
restore_backup() {
    local backup_file="$1"

    if [[ ! -f "$backup_file" ]]; then
        echo -e "${RED}✗${NC} Backup nie istnieje: $backup_file"
        return 1
    fi

    cp "$backup_file" "$GRAPH_JSON"
    echo -e "${GREEN}✓${NC} Przywrócono backup: $(basename "$backup_file")"
}

# Main
main() {
    if [[ $# -eq 0 ]]; then
        list_presets
        echo -n "Wybierz preset (1-6): "
        read -r choice
        switch_preset "$choice"
    else
        switch_preset "$1"
    fi
}

main "$@"
