#!/usr/bin/env bash
# graph-history.sh - Generuj changelog grafu na podstawie snapshots
set -euo pipefail

readonly VERSIONS_DIR=".obsidian/graph-versions"
readonly HISTORY_FILE="$VERSIONS_DIR/graph-history.md"

readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

# Przejdź do root repo
cd "$(git rev-parse --show-toplevel)"

# Sprawdź czy katalog istnieje
if [[ ! -d "$VERSIONS_DIR" ]]; then
    echo "[EWW] Błąd: Katalog $VERSIONS_DIR nie istnieje" >&2
    exit 1
fi

# Rozpocznij generowanie
cat > "$HISTORY_FILE" <<'EOF'
---
tags:
  - #graph
  - #history
  - #auto-generated
created: 2025-11-23T00:00:00Z
modified: AUTO_UPDATE
author: system
title: "Graph History - Auto-generated changelog"
---

# Graph History

*Auto-generowane: AUTO_TIMESTAMP*

## 📊 Snapshots Timeline

| Data | Color Groups | Physics | Nodes Filter | Zmiany |
|------|--------------|---------|--------------|--------|
EOF

# Zastąp placeholdery
sed -i "s/AUTO_UPDATE/$(date -Iseconds)/" "$HISTORY_FILE"
sed -i "s/AUTO_TIMESTAMP/$(date '+%Y-%m-%d %H:%M:%S')/" "$HISTORY_FILE"

# Parsuj każdy snapshot
for snapshot in $(find "$VERSIONS_DIR" -name "graph-*.json" | sort -r); do
    DATE=$(basename "$snapshot" | sed 's/graph-//;s/.json//')
    
    # Wyciągnij dane z JSON (jeśli jq dostępne)
    if command -v jq &> /dev/null; then
        GROUPS=$(jq '.colorGroups | length' "$snapshot" 2>/dev/null || echo "N/A")
        REPEL=$(jq '.repelStrength' "$snapshot" 2>/dev/null || echo "N/A")
        DISTANCE=$(jq '.linkDistance' "$snapshot" 2>/dev/null || echo "N/A")
        FILTER=$(jq -r '.search // "none"' "$snapshot" 2>/dev/null | head -c 30)
        
        echo "| $DATE | $GROUPS | repel:$REPEL dist:$DISTANCE | $FILTER... | Auto-snapshot |" \
            >> "$HISTORY_FILE"
    else
        echo "| $DATE | N/A | N/A | N/A | Auto-snapshot (install jq for details) |" \
            >> "$HISTORY_FILE"
    fi
done

echo -e "${GREEN}[EWW] ✅ Graph history generated: $HISTORY_FILE${NC}"

# Pokaż ostatnie 5 wpisów
echo ""
echo "📋 Ostatnie snapshots:"
tail -n 6 "$HISTORY_FILE"
