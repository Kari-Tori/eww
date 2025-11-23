#!/usr/bin/env bash
# generate-graph-config.sh - Automatyczne generowanie konfiguracji grafu Obsidian
# Zasady:
# - Max 5000 nodes (hard limit Obsidian)
# - Max 18 nodes per render (dla daily auto-commit)
# - Waypoint: top 20 folder_note według liczby plików
# - Każdy folder_note ma unikalny kolor
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly OBSIDIAN_DIR="$PROJECT_ROOT/.obsidian"
readonly GRAPH_JSON="$OBSIDIAN_DIR/graph.json"
readonly WAYPOINT_JSON="$OBSIDIAN_DIR/plugins/waypoint/data.json"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Limity
readonly MAX_NODES_TOTAL=5000
readonly MAX_NODES_PER_RENDER=18
readonly MAX_WAYPOINT_FOLDERS=20

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

# Znajdź wszystkie folder notes
find_folder_notes() {
    log_info "Szukam folder notes..."

    find "$PROJECT_ROOT" -type f -name "*.md" \
        ! -path "*/.git/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/node_modules/*" \
        -exec grep -l "type.*folder.*note\|#folder.note\|#folder_note" {} \; 2>/dev/null
}

# Policz pliki w folderze
count_files_in_folder() {
    local folder_note="$1"
    local folder_path
    folder_path=$(dirname "$folder_note")

    find "$folder_path" -type f -name "*.md" 2>/dev/null | wc -l
}

# Generuj kolor dla folderu (RGB decimal)
generate_color_for_folder() {
    local index="$1"

    # Paleta 20 kolorów
    local colors=(
        65331      # #00FF33 - jasny zielony
        16711680   # #FF0000 - czerwony
        255        # #0000FF - niebieski
        16776960   # #FFFF00 - żółty
        16711935   # #FF00FF - magenta
        65535      # #00FFFF - cyan
        16744448   # #FF8C00 - pomarańczowy
        9109504    # #8B00FF - fioletowy
        52479      # #00CCFF - jasny niebieski
        11141290   # #AA00AA - purpurowy
        43775      # #00AAFF - błękit
        16753920   # #FFA500 - złoty
        2664719    # #28AA0F - zielony las
        16724736   # #FF6600 - pomarańcz
        5570815    # #5500FF - indygo
        13434879   # #CCFFFF - lodowy
        16744319   # #FF007F - różowy
        8388863    # #7FFFFF - turkusowy
        16777088   # #FFFF80 - jasnożółty
        12582912   # #C00000 - ciemnoczerwony
    )

    local color_index=$((index % ${#colors[@]}))
    echo "${colors[$color_index]}"
}

# Generuj top 20 folder notes
# UWAGA: Ta funkcja NIE używa log_* - output musi być czysty (tylko dane)
# Format: count|folder_path|rel_path (jeden na linię)
# Używane w: generate_graph_json, validate_node_count, generate_report
generate_top_folder_notes() {
    local temp_file="/tmp/eww-folder-notes-ranking.txt"
    : > "$temp_file"

    # Tablica już przetworzonych folderów (unikaj duplikatów)
    local -A seen_folders

    while IFS= read -r folder_note; do
        # Relatywna ścieżka
        local rel_path="${folder_note#$PROJECT_ROOT/}"
        local folder_path
        folder_path=$(dirname "$rel_path")

        # Skip pusty folder lub "."
        [[ "$folder_path" == "." ]] && continue
        [[ "$folder_path" == "" ]] && continue

        # Skip jeśli folder już przetworzony
        [[ -n "${seen_folders[$folder_path]:-}" ]] && continue
        seen_folders[$folder_path]=1

        # Policz pliki
        local count
        count=$(count_files_in_folder "$folder_note")

        # Skip jeśli brak plików
        [[ "$count" -eq 0 ]] && continue

        echo "$count|$folder_path|$rel_path" >> "$temp_file"
    done < <(find_folder_notes)    # Sortuj i weź top 20
    sort -t'|' -k1 -rn "$temp_file" | head -n "$MAX_WAYPOINT_FOLDERS"
}

# Generuj grupę kolorów dla graph.json
generate_color_groups() {
    local index=0

    echo "  \"colorGroups\": ["

    while IFS='|' read -r count folder_path rel_path; do
        local color
        color=$(generate_color_for_folder "$index")

        local comma=","
        if [ "$index" -eq $((MAX_WAYPOINT_FOLDERS - 1)) ]; then
            comma=""
        fi

        cat <<EOF
    {
      "query": "path:$folder_path/",
      "color": {
        "a": 1,
        "rgb": $color
      }
    }$comma
EOF

        ((index++)) || true
    done < <(generate_top_folder_notes)

    echo "  ]"
}

# Generuj search query dla graph.json
generate_search_query() {
    local queries=()

    while IFS='|' read -r count folder_path rel_path; do
        queries+=("path:$folder_path/")
    done < <(generate_top_folder_notes)

    # Join z OR
    local search=""
    for i in "${!queries[@]}"; do
        if [ "$i" -eq 0 ]; then
            search="${queries[$i]}"
        else
            search="$search OR ${queries[$i]}"
        fi
    done

    echo "$search"
}

# Sprawdź czy łączna liczba nodes nie przekracza limitów
validate_node_count() {
    local total_nodes
    total_nodes=0

    log_info "Walidacja liczby nodes..."

    while IFS='|' read -r count folder_path rel_path; do
        if [[ "$count" =~ ^[0-9]+$ ]]; then
            total_nodes=$((total_nodes + count))
            log_info "  $folder_path: $count plików"
        fi
    done < <(generate_top_folder_notes)

    log_info "Łączna liczba nodes: $total_nodes"

    if [ "$total_nodes" -gt "$MAX_NODES_TOTAL" ]; then
        log_error "BŁĄD: Łączna liczba nodes ($total_nodes) przekracza limit $MAX_NODES_TOTAL!"
        return 1
    fi

    if [ "$total_nodes" -gt "$MAX_NODES_PER_RENDER" ]; then
        log_warn "UWAGA: Liczba nodes ($total_nodes) > $MAX_NODES_PER_RENDER"
        local batches=$(( (total_nodes + MAX_NODES_PER_RENDER - 1) / MAX_NODES_PER_RENDER ))
        log_warn "Daily auto-commit będzie podzielony na $batches części"
    fi

    log_success "Walidacja OK: $total_nodes nodes"
    return 0
}

# Generuj plik graph.json
generate_graph_json() {
    log_info "Generuję $GRAPH_JSON..."

    # Backup
    if [ -f "$GRAPH_JSON" ]; then
        local timestamp
        timestamp=$(date +%s)
        cp "$GRAPH_JSON" "$GRAPH_JSON.backup-$timestamp"
        log_info "Backup: graph.json.backup-$timestamp"
    fi

    # Pobierz dane (cache do użycia w pętlach)
    local cached_results
    cached_results=$(generate_top_folder_notes)

    # Buduj search query
    local search_query=""
    while IFS='|' read -r count folder_path rel_path; do
        if [[ -n "$search_query" ]]; then
            search_query="$search_query OR "
        fi
        search_query="${search_query}path:$folder_path/"
    done <<< "$cached_results"

    # Zapisz początek graph.json
    cat > "$GRAPH_JSON" <<EOF
{
  "collapse-filter": true,
  "search": "$search_query",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "collapse-color-groups": false,
  "colorGroups": [
EOF

    # Generuj grupy kolorów
    local index=0
    local is_first=true
    while IFS='|' read -r count folder_path rel_path; do
        local color
        color=$(generate_color_for_folder $index)

        if [[ "$is_first" == true ]]; then
            is_first=false
        else
            echo "," >> "$GRAPH_JSON"
        fi

        cat >> "$GRAPH_JSON" <<EOF
    {
      "query": "path:$folder_path/",
      "color": {
        "a": 1,
        "rgb": $color
      }
    }
EOF
        ((index++)) || true
    done <<< "$cached_results"

    # Zamknij JSON
    cat >> "$GRAPH_JSON" <<'EOF'
  ],
  "collapse-display": true,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1,
  "lineSizeMultiplier": 1,
  "repelStrength": 10,
  "linkStrength": 0.5,
  "linkDistance": 200,
  "centerStrength": 0.4
}
EOF

    log_success "Wygenerowano: $GRAPH_JSON"
}

# Aktualizuj waypoint config
update_waypoint_config() {
    log_info "Aktualizuję $WAYPOINT_JSON..."

    if [ ! -f "$WAYPOINT_JSON" ]; then
        mkdir -p "$(dirname "$WAYPOINT_JSON")"
    fi

    cat > "$WAYPOINT_JSON" <<EOF
{
  "waypointFlag": "%% Waypoint %%",
  "stopScanAtFolderNotes": true,
  "showFolderNotes": true,
  "showNonMarkdownFiles": false,
  "debugLogging": false,
  "useWikiLinks": true,
  "showEnclosingNote": false,
  "useSpaces": true,
  "maxFiles": 20,
  "maxDepth": 2
}
EOF

    log_success "Zaktualizowano: $WAYPOINT_JSON"
}

# Raport
generate_report() {
    log_info "=== RAPORT GENEROWANIA GRAFU ==="
    echo ""

    echo "📊 Top $MAX_WAYPOINT_FOLDERS folder notes:"
    echo ""

    # Cache wyników aby uniknąć wielokrotnego wywoływania
    local cached_results
    cached_results=$(generate_top_folder_notes 2>/dev/null)

    local index=0
    while IFS='|' read -r count folder_path rel_path; do
        ((index++)) || true
        local color
        color=$(generate_color_for_folder $((index - 1)))
        printf "%2d. %s (%d plików) - kolor: #%06X\n" \
            "$index" "$folder_path" "$count" "$color"
    done <<< "$cached_results"

    echo ""
    log_info "=== LIMITY ==="
    echo "  Max nodes total: $MAX_NODES_TOTAL"
    echo "  Max nodes per render: $MAX_NODES_PER_RENDER"
    echo "  Max waypoint folders: $MAX_WAYPOINT_FOLDERS"
}

# Main
main() {
    log_info "Generowanie konfiguracji grafu Obsidian..."
    echo ""

    # Walidacja
    if ! validate_node_count; then
        log_error "Walidacja nie powiodła się!"
        exit 1
    fi

    echo ""

    # Generuj
    generate_graph_json
    update_waypoint_config

    echo ""
    generate_report

    echo ""
    log_success "Gotowe! Zrestartuj Obsidian (Ctrl+R) aby zastosować zmiany."
}

main "$@"

