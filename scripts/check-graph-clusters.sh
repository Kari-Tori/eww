#!/usr/bin/env bash
# check-graph-clusters.sh - Diagnostyka klastrów grafów
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[EWW]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW]${NC} ✅ $*"
}

log_warn() {
    echo -e "${YELLOW}[EWW]${NC} ⚠️  $*"
}

log_error() {
    echo -e "${RED}[EWW]${NC} ❌ $*"
}

# Sprawdź pliki w ścieżce i ich backlinki
check_path_connectivity() {
    local path="$1"
    local color="$2"
    
    if [[ ! -d "$path" ]]; then
        log_warn "Ścieżka nie istnieje: $path"
        return
    fi
    
    local total=0
    local with_3_links=0
    local orphans=0
    
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        ((total++))
        
        local links
        links=$(grep -o '\[\[[^]]*\]\]' "$file" 2>/dev/null | wc -l | tr -d ' ')
        
        if (( links >= 3 )); then
            ((with_3_links++))
        elif (( links == 0 )); then
            ((orphans++))
        fi
    done < <(find "$path" -name "*.md" -type f 2>/dev/null | grep -v archive | grep -v var/log)
    
    local percent=0
    if (( total > 0 )); then
        percent=$(( with_3_links * 100 / total ))
    fi
    
    echo -e "\n${color} $path"
    echo "  📁 Plików: $total"
    echo "  🔗 Z ≥3 backlinkami: $with_3_links ($percent%)"
    echo "  👻 Orphans (0 linków): $orphans"
    
    if (( percent >= 75 )); then
        log_success "Klaster OK"
    else
        log_warn "Klaster wymaga więcej połączeń"
    fi
}

main() {
    log_info "🔍 Diagnostyka klastrów grafów"
    echo
    
    check_path_connectivity "core" "🔴"
    check_path_connectivity "config" "🟢"
    check_path_connectivity "business" "��"
    check_path_connectivity "usr/jakubc" "🔵"
    check_path_connectivity "usr/karinam" "🟣"
    check_path_connectivity "docs" "🔷"
    check_path_connectivity "infra" "🟤"
    check_path_connectivity "scripts" "🟠"
    check_path_connectivity "tools" "⚫"
    
    echo
    log_info "💡 Aby poprawić separację klastrów:"
    echo "  1. Zwiększ repelStrength (obecnie 25)"
    echo "  2. Zwiększ linkDistance (obecnie 600)"
    echo "  3. Zmniejsz linkStrength (obecnie 0.5)"
    echo "  4. Dodaj więcej backlinków w klastrach"
    echo
    echo "🔧 Edytuj: .obsidian/graph.json"
    echo "🔗 Dodaj linki: bash auto-backlinks.sh"
}

main "$@"
