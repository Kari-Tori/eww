#!/usr/bin/env bash
# graph-snapshot.sh - Daily backup graph.json z versjonowaniem
set -euo pipefail

readonly GRAPH_FILE=".obsidian/graph.json"
readonly VERSIONS_DIR=".obsidian/graph-versions"
readonly TODAY=$(date +%Y-%m-%d)
readonly SNAPSHOT="$VERSIONS_DIR/graph-$TODAY.json"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Przejdź do root repo
cd "$(git rev-parse --show-toplevel)"

# Utwórz katalog jeśli nie istnieje
mkdir -p "$VERSIONS_DIR"

# Sprawdź czy graph.json istnieje
if [[ ! -f "$GRAPH_FILE" ]]; then
    echo -e "${RED}[EWW] Błąd: Brak pliku $GRAPH_FILE${NC}" >&2
    exit 1
fi

# Snapshot tylko jeśli nie istnieje dla dzisiejszej daty
if [[ ! -f "$SNAPSHOT" ]]; then
    cp "$GRAPH_FILE" "$SNAPSHOT"
    echo -e "${GREEN}[EWW] ✅ Graph snapshot: $SNAPSHOT${NC}"

    # Git commit
    if git add "$SNAPSHOT" 2>/dev/null; then
        if git commit -m "chore(graph): daily snapshot $TODAY" 2>/dev/null; then
            echo -e "${BLUE}[EWW] 📦 Committed to git${NC}"
        else
            echo -e "${BLUE}[EWW] ℹ️  Snapshot saved (no git commit - nothing to commit)${NC}"
        fi
    fi
else
    echo -e "${BLUE}[EWW] ℹ️  Snapshot już istnieje: $SNAPSHOT${NC}"
fi

# Cleanup: zachowaj ostatnie 30 dni
DELETED=$(find "$VERSIONS_DIR" -name "graph-*.json" -mtime +30 -delete -print | wc -l)
if [[ $DELETED -gt 0 ]]; then
    echo -e "${BLUE}[EWW] 🗑️  Usunięto $DELETED starych snapshots (>30 dni)${NC}"
fi

# Pokaż statystyki
TOTAL_SNAPSHOTS=$(find "$VERSIONS_DIR" -name "graph-*.json" | wc -l)
echo -e "${GREEN}[EWW] 📊 Total snapshots: $TOTAL_SNAPSHOTS${NC}"
