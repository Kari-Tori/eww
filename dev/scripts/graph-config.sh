#!/usr/bin/env bash
# graph-config.sh - Zarządzanie konfiguracją grafu Obsidian
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly OBSIDIAN_DIR="$PROJECT_ROOT/.obsidian"
readonly GRAPH_JSON="$OBSIDIAN_DIR/graph.json"
readonly GRAPH_COLORS="$OBSIDIAN_DIR/graph-colors.json"
readonly GRAPH_EXCLUDE="$OBSIDIAN_DIR/graph-exclude.json"

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

# Konwertuj RGB decimal na HEX
rgb_to_hex() {
    local rgb="$1"
    local r=$(( (rgb >> 16) & 0xFF ))
    local g=$(( (rgb >> 8) & 0xFF ))
    local b=$(( rgb & 0xFF ))
    printf "#%02X%02X%02X" "$r" "$g" "$b"
}

# Konwertuj HEX na RGB decimal
hex_to_rgb() {
    local hex="${1#\#}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    echo $(( (r << 16) | (g << 8) | b ))
}

# Pokaż status konfiguracji
show_status() {
    log_info "Status konfiguracji grafu Obsidian"
    echo ""

    if [[ ! -f "$GRAPH_JSON" ]]; then
        log_error "Brak pliku: $GRAPH_JSON"
        return 1
    fi

    # Parsuj JSON za pomocą Pythona
    python3 << EOF
import json

with open('$GRAPH_JSON', 'r') as f:
    config = json.load(f)

print("📊 Parametry grafu:")
print(f"  Link Distance:        {config.get('linkDistance', 'N/A')}")
print(f"  Repel Strength:       {config.get('repelStrength', 'N/A')}")
print(f"  Center Strength:      {config.get('centerStrength', 'N/A')}")
print(f"  Link Strength:        {config.get('linkStrength', 'N/A')}")
print(f"  Node Size Multiplier: {config.get('nodeSizeMultiplier', 'N/A')}")
print()

groups = config.get('colorGroups', [])
print(f"🎨 Grupy kolorystyczne: {len(groups)}")
for i, group in enumerate(groups, 1):
    rgb = group['color']['rgb']
    r = (rgb >> 16) & 0xFF
    g = (rgb >> 8) & 0xFF
    b = rgb & 0xFF
    hex_color = f"#{r:02X}{g:02X}{b:02X}"
    query = group['query']
    print(f"  {i:2d}. {hex_color} - {query}")
EOF
}

# Utwórz backup
create_backup() {
    local timestamp
    timestamp=$(date +%s)
    
    log_info "Tworzę backup konfiguracji..."
    
    if [[ -f "$GRAPH_JSON" ]]; then
        cp "$GRAPH_JSON" "$GRAPH_JSON.backup-$timestamp"
        log_success "Backup: graph.json.backup-$timestamp"
    fi
    
    if [[ -f "$GRAPH_COLORS" ]]; then
        cp "$GRAPH_COLORS" "$GRAPH_COLORS.backup-$timestamp"
        log_success "Backup: graph-colors.json.backup-$timestamp"
    fi
}

# Waliduj konfigurację
validate_config() {
    log_info "Walidacja konfiguracji..."
    
    if [[ ! -f "$GRAPH_JSON" ]]; then
        log_error "Brak graph.json"
        return 1
    fi
    
    # Walidacja JSON za pomocą Pythona
    python3 << EOF
import json
import sys

try:
    with open('$GRAPH_JSON', 'r') as f:
        config = json.load(f)
    
    # Sprawdź wymagane pola
    required = ['linkDistance', 'repelStrength', 'centerStrength', 'colorGroups']
    missing = [field for field in required if field not in config]
    
    if missing:
        print(f"❌ Brakujące pola: {', '.join(missing)}")
        sys.exit(1)
    
    # Sprawdź grupy kolorystyczne
    groups = config['colorGroups']
    if not groups:
        print("❌ Brak grup kolorystycznych")
        sys.exit(1)
    
    for i, group in enumerate(groups):
        if 'query' not in group:
            print(f"❌ Grupa {i}: brak 'query'")
            sys.exit(1)
        if 'color' not in group or 'rgb' not in group['color']:
            print(f"❌ Grupa {i}: brak 'color.rgb'")
            sys.exit(1)
    
    print(f"✅ Konfiguracja poprawna ({len(groups)} grup)")
    sys.exit(0)
    
except json.JSONDecodeError as e:
    print(f"❌ Nieprawidłowy JSON: {e}")
    sys.exit(1)
except Exception as e:
    print(f"❌ Błąd: {e}")
    sys.exit(1)
EOF
}

# Wyczyść stare backupy
clean_backups() {
    local keep="${1:-5}"
    
    log_info "Czyszczę stare backupy (zachowuję ostatnie $keep)..."
    
    # Usuń stare backupy graph.json
    local count=0
    while IFS= read -r -d '' backup; do
        if [[ $count -ge $keep ]]; then
            rm "$backup"
            log_info "Usunięto: $(basename "$backup")"
        fi
        count=$((count + 1))
    done < <(find "$OBSIDIAN_DIR" -name "graph.json.backup-*" -type f -print0 | sort -zr)
    
    log_success "Backupy wyczyszczone"
}

# Pokaż pomoc
usage() {
    cat << EOF
Użycie: $(basename "$0") [KOMENDA]

Zarządzanie konfiguracją grafu Obsidian.

KOMENDY:
    status      Pokaż aktualną konfigurację
    backup      Utwórz backup konfiguracji
    validate    Waliduj poprawność JSON
    clean       Wyczyść stare backupy (zachowaj 5 ostatnich)
    help        Pokaż tę pomoc

PRZYKŁADY:
    $(basename "$0") status      # Pokaż status
    $(basename "$0") backup      # Backup przed zmianami
    $(basename "$0") validate    # Sprawdź poprawność
    $(basename "$0") clean       # Usuń stare backupy
EOF
}

# Główna funkcja
main() {
    local command="${1:-status}"
    
    case "$command" in
        status)
            show_status
            ;;
        backup)
            create_backup
            ;;
        validate)
            validate_config
            ;;
        clean)
            clean_backups "${2:-5}"
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
