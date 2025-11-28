#!/usr/bin/env bash
# graph-optimize.sh - Optymalizacja wydajności grafu Obsidiana
# Rozwiązuje problem mulenia/lagowania grafu
set -euo pipefail

readonly OBSIDIAN_DIR="/home/karinam/git/eww/.obsidian"
readonly GRAPH_JSON="${OBSIDIAN_DIR}/graph.json"
readonly BACKUP_DIR="${OBSIDIAN_DIR}/graph-backups"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Backup obecnej konfiguracji
backup_current() {
    mkdir -p "$BACKUP_DIR"
    local timestamp=$(date +%Y%m%d-%H%M%S)
    cp "$GRAPH_JSON" "${BACKUP_DIR}/graph-before-optimize-${timestamp}.json"
    echo -e "${GREEN}✓${NC} Backup: graph-before-optimize-${timestamp}.json"
}

# Zastosuj optymalizację
apply_optimization() {
    local option="$1"
    
    case "$option" in
        A|a|balanced)
            echo -e "${BLUE}Aplikuję BALANCED optimization (Jakub rekomenduje)${NC}"
            jq '.linkDistance = 120 | .scale = 0.3 | .centerStrength = 0.15' "$GRAPH_JSON" > "${GRAPH_JSON}.tmp"
            ;;
        B|b|standard)
            echo -e "${BLUE}Aplikuję STANDARD optimization (community typical)${NC}"
            jq '.linkDistance = 200 | .scale = 0.8 | .centerStrength = 0.4' "$GRAPH_JSON" > "${GRAPH_JSON}.tmp"
            ;;
        C|c|performance)
            echo -e "${BLUE}Aplikuję PERFORMANCE MAX optimization (najszybszy)${NC}"
            jq '.linkDistance = 300 | .scale = 1.0 | .centerStrength = 0.5 | .showAttachments = false | .showOrphans = false' "$GRAPH_JSON" > "${GRAPH_JSON}.tmp"
            ;;
        *)
            echo -e "${RED}✗${NC} Nieznana opcja: $option"
            return 1
            ;;
    esac
    
    mv "${GRAPH_JSON}.tmp" "$GRAPH_JSON"
    echo -e "${GREEN}✓${NC} Optymalizacja zastosowana!"
}

# Pokaż obecną konfigurację
show_current() {
    echo -e "${YELLOW}📊 Obecna konfiguracja:${NC}"
    echo ""
    jq -r '"linkDistance: \(.linkDistance)\nscale: \(.scale)\ncenterStrength: \(.centerStrength)\nshowAttachments: \(.showAttachments)\nshowOrphans: \(.showOrphans)"' "$GRAPH_JSON"
    echo ""
}

# Menu
show_menu() {
    cat <<EOF
${BLUE}🎯 OPTYMALIZACJA GRAFU OBSIDIANA${NC}

${YELLOW}Problem:${NC} Graf muli, laguje, trzeba zoom-out
${YELLOW}Powód:${NC} linkDistance=62 (za compact), scale=0.0078 (za przybliżony)

${BLUE}Dostępne opcje:${NC}

${GREEN}A) BALANCED${NC} (Jakub rekomenduje) ⭐
   - linkDistance: 120 (2x więcej przestrzeni)
   - scale: 0.3 (widzisz więcej klastrów na start)
   - centerStrength: 0.15 (lekko silniejsze centrum)
   ${GREEN}→ Dobry balans między compactness a czytelnością${NC}

${GREEN}B) STANDARD${NC} (community typical)
   - linkDistance: 200 (normalny spacing)
   - scale: 0.8 (szeroki widok)
   - centerStrength: 0.4 (balanced center)
   ${GREEN}→ Typowy setup większości użytkowników${NC}

${GREEN}C) PERFORMANCE MAX${NC} (najszybszy) ⚡
   - linkDistance: 300 (dużo przestrzeni)
   - scale: 1.0 (full wide view)
   - centerStrength: 0.5 (silne centrum)
   - showAttachments: false (bez załączników)
   - showOrphans: false (bez samotnych plików)
   ${GREEN}→ Maksymalna wydajność, minimalny render time${NC}

${YELLOW}D) POKAŻ OBECNĄ KONFIGURACJĘ${NC}

${RED}Q) WYJDŹ BEZ ZMIAN${NC}

EOF
}

# Sprawdź czy Obsidian jest uruchomiony
obsidian_running() {
    pgrep -f "obsidian" >/dev/null 2>&1
}

# Main
main() {
    show_current
    show_menu
    
    echo -n "Wybierz opcję (A/B/C/D/Q): "
    read -r choice
    
    case "$choice" in
        D|d)
            show_current
            main
            ;;
        Q|q)
            echo -e "${YELLOW}Wyjście bez zmian${NC}"
            exit 0
            ;;
        A|a|B|b|C|c)
            backup_current
            apply_optimization "$choice"
            
            if obsidian_running; then
                echo -e "${YELLOW}⚠${NC} Obsidian jest uruchomiony - restart zalecany"
                echo -n "Restart Obsidiana teraz? (y/n): "
                read -r restart
                if [[ "$restart" =~ ^[Yy]$ ]]; then
                    pkill -f obsidian
                    sleep 2
                    obsidian &
                    echo -e "${GREEN}✓${NC} Obsidian uruchomiony ponownie"
                fi
            fi
            
            echo ""
            echo -e "${GREEN}✅ GOTOWE!${NC}"
            echo ""
            echo "🎯 Co dalej:"
            echo "1. Otwórz Obsidiana (jeśli nie zrestartowałeś)"
            echo "2. Naciśnij Ctrl+G (otwórz graf)"
            echo "3. Zobacz różnicę w wydajności! 🚀"
            echo ""
            echo "📊 Nowa konfiguracja:"
            show_current
            ;;
        *)
            echo -e "${RED}✗${NC} Nieznana opcja"
            exit 1
            ;;
    esac
}

main "$@"
