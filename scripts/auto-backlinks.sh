#!/usr/bin/env bash
# auto-backlinks.sh - Automatyczne dodawanie backlinków do plików
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

log_warn() {
    echo -e "${YELLOW}[EWW]${NC} ⚠️  $*"
}

# Struktura backlinków według kolorów/ścieżek
declare -A BACKLINK_GROUPS=(
    ["core"]="core/core.md config/config.md business/business.md"
    ["business"]="core/core.md business/business.md docs/docs.md"
    ["config"]="core/core.md config/config.md infra/infra.md"
    ["infra"]="config/config.md infra/infra.md tools/tools.md"
    ["docs"]="docs/docs.md core/core.md README.md"
    ["usr/jakubc"]="usr/jakubc/jakubc.md usr/jakubc/INDEX.md core/core.md"
    ["usr/karinam"]="usr/karinam/karinam.md usr/jakubc/jakubc.md core/core.md"
    ["scripts"]="scripts/scripts.md core/core.md tools/tools.md"
    ["tools"]="tools/tools.md scripts/scripts.md infra/infra.md"
)

# Licznik backlinków w pliku
count_backlinks() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        echo 0
        return
    fi
    
    # Zlicz linki [[...]]
    local count
    count=$(grep -o '\[\[[^]]*\]\]' "$file" 2>/dev/null | wc -l || echo 0)
    # Usuń białe znaki
    count=$(echo "$count" | tr -d ' \t\n')
    echo "$count"
}

# Dodaj sekcję backlinków do pliku
add_backlinks_section() {
    local file="$1"
    local backlinks="$2"
    
    if [[ ! -f "$file" ]]; then
        log_warn "Plik nie istnieje: $file"
        return
    fi
    
    # Sprawdź czy ma już sekcję backlinków
    if grep -q "## 🔗 Backlinks" "$file" 2>/dev/null; then
        log_info "Plik już ma backlinki: $file"
        return
    fi
    
    # Dodaj sekcję na końcu pliku
    cat >> "$file" << EOF

## 🔗 Backlinks

$backlinks

---
*Auto-generated backlinks for cluster connectivity*
EOF
    
    log_success "Dodano backlinki do: $file"
}

# Generuj backlinki dla grupy
generate_backlinks() {
    local path_pattern="$1"
    local backlink_list="$2"
    
    log_info "Przetwarzanie: $path_pattern"
    
    # Znajdź wszystkie pliki MD w ścieżce
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        [[ "$file" == *"/archive/"* ]] && continue
        [[ "$file" == *"/var/log/"* ]] && continue
        
        local current_backlinks
        current_backlinks=$(count_backlinks "$file")
        
        # Jeśli ma mniej niż 3 backlinki, dodaj
        if (( current_backlinks < 3 )); then
            local links_text=""
            for link_file in $backlink_list; do
                # Konwertuj ścieżkę na link
                local link_name
                link_name=$(basename "$link_file" .md)
                links_text+="- [[$link_name]]\n"
            done
            
            add_backlinks_section "$file" "$(echo -e "$links_text")"
        else
            log_info "OK: $file ma $current_backlinks backlinków"
        fi
    done < <(find "$path_pattern" -name "*.md" -type f 2>/dev/null)
}

# Główna funkcja
main() {
    log_info "🔗 Dodawanie backlinków dla kolorowych klastrów"
    echo
    
    local total_processed=0
    local total_updated=0
    
    # Przetwarzaj każdą grupę
    for path_pattern in "${!BACKLINK_GROUPS[@]}"; do
        local backlinks="${BACKLINK_GROUPS[$path_pattern]}"
        
        if [[ -d "$path_pattern" ]]; then
            generate_backlinks "$path_pattern" "$backlinks"
            ((total_processed++))
        else
            log_warn "Ścieżka nie istnieje: $path_pattern"
        fi
    done
    
    echo
    log_success "Przetworzono $total_processed grup"
    echo
    echo "📋 Sprawdź pliki - każdy powinien mieć min. 3 backlinki"
    echo "🎨 Backlinki łączą pliki w kolorowe klastry"
}

main "$@"
