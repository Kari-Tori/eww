#!/usr/bin/env bash
# tune-graph-separation.sh - Dostrajanie separacji klastrów
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[EWW]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW]${NC} ✅ $*"
}

# Menu interaktywne
show_menu() {
    cat << 'EOF'

🎨 TUNE GRAPH SEPARATION
========================

Wybierz poziom separacji klastrów:

1) 🟢 MILD    - Łagodna separacja (repel: 15, dist: 400)
2) 🟡 MEDIUM  - Średnia separacja (repel: 25, dist: 600) [OBECNY]
3) 🟠 STRONG  - Silna separacja (repel: 35, dist: 800)
4) 🔴 EXTREME - Ekstremalna separacja (repel: 50, dist: 1200)
5) 🎯 CUSTOM  - Własne wartości

q) Wyjście

EOF
}

apply_preset() {
    local preset="$1"
    local repel link_dist center link_str
    
    case "$preset" in
        1)
            repel=15
            link_dist=400
            center=0.15
            link_str=0.7
            ;;
        2)
            repel=25
            link_dist=600
            center=0.05
            link_str=0.5
            ;;
        3)
            repel=35
            link_dist=800
            center=0.03
            link_str=0.3
            ;;
        4)
            repel=50
            link_dist=1200
            center=0.01
            link_str=0.1
            ;;
        5)
            read -p "repelStrength [25]: " repel
            repel=${repel:-25}
            read -p "linkDistance [600]: " link_dist
            link_dist=${link_dist:-600}
            read -p "centerStrength [0.05]: " center
            center=${center:-0.05}
            read -p "linkStrength [0.5]: " link_str
            link_str=${link_str:-0.5}
            ;;
        *)
            echo "Nieprawidłowy wybór"
            return 1
            ;;
    esac
    
    log_info "Aplikowanie: repel=$repel, dist=$link_dist, center=$center, link=$link_str"
    
    # Backup
    cp .obsidian/graph.json ".obsidian/graph.json.backup-$(date +%s)"
    
    # Aktualizuj graph.json
    local tmp_file
    tmp_file=$(mktemp)
    
    jq --arg repel "$repel" \
       --arg dist "$link_dist" \
       --arg center "$center" \
       --arg link "$link_str" \
       '.repelStrength = ($repel | tonumber) |
        .linkDistance = ($dist | tonumber) |
        .centerStrength = ($center | tonumber) |
        .linkStrength = ($link | tonumber)' \
        .obsidian/graph.json > "$tmp_file"
    
    mv "$tmp_file" .obsidian/graph.json
    
    log_success "Konfiguracja zaktualizowana!"
    echo
    echo "📊 Nowe wartości:"
    echo "  repelStrength: $repel"
    echo "  linkDistance: $link_dist"
    echo "  centerStrength: $center"
    echo "  linkStrength: $link_str"
    echo
    echo "🔄 Zrestartuj Obsidian aby zobaczyć efekt"
}

main() {
    if [[ ! -f .obsidian/graph.json ]]; then
        echo "❌ Błąd: Brak .obsidian/graph.json"
        exit 1
    fi
    
    if ! command -v jq &>/dev/null; then
        echo "⚠️  Instaluję jq..."
        sudo apt-get update -qq && sudo apt-get install -y -qq jq
    fi
    
    while true; do
        show_menu
        read -p "Wybór: " choice
        
        case "$choice" in
            [1-5])
                apply_preset "$choice"
                read -p "Kontynuować? [y/n]: " cont
                [[ "$cont" != "y" ]] && break
                ;;
            q|Q)
                echo "👋 Do zobaczenia!"
                break
                ;;
            *)
                echo "❌ Nieprawidłowy wybór"
                ;;
        esac
    done
}

main "$@"
