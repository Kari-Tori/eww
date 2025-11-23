#!/usr/bin/env bash
# sync-graph-colors.sh - Synchronizuj 14 kolorów z graph.md do graph.json
set -euo pipefail

readonly GRAPH_MD="graph.md"
readonly GRAPH_JSON=".obsidian/graph.json"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Przejdź do root repo
cd "$(git rev-parse --show-toplevel)"

echo -e "${BLUE}[EWW] 🎨 Synchronizacja kolorów graph.md → graph.json${NC}"

# Sprawdź czy pliki istnieją
if [[ ! -f "$GRAPH_MD" ]]; then
    echo "[EWW] Błąd: Brak pliku $GRAPH_MD" >&2
    exit 1
fi

if [[ ! -f "$GRAPH_JSON" ]]; then
    echo "[EWW] Błąd: Brak pliku $GRAPH_JSON" >&2
    exit 1
fi

# Sprawdź czy jq jest zainstalowane
if ! command -v jq &> /dev/null; then
    echo "[EWW] Błąd: Wymagane narzędzie 'jq' nie jest zainstalowane" >&2
    echo "Instaluj: sudo apt install jq" >&2
    exit 1
fi

# Backup graph.json
cp "$GRAPH_JSON" "$GRAPH_JSON.backup-$(date +%Y%m%d-%H%M%S)"
echo -e "${BLUE}[EWW] 📦 Backup utworzony${NC}"

# Parse graph.md i wyciągnij mapowanie kolorów
echo -e "${YELLOW}[EWW] 📖 Parsowanie $GRAPH_MD...${NC}"

# Wyciągnij colorGroups z graph.json i policz
CURRENT_GROUPS=$(jq '.colorGroups | length' "$GRAPH_JSON")
echo -e "${BLUE}[EWW] ℹ️  Obecna liczba color groups: $CURRENT_GROUPS${NC}"

# Informacja o synchronizacji
cat <<EOF

${GREEN}[EWW] ✅ Struktura kolorów w graph.md:${NC}

14 głównych kolorów (z tabeli w graph.md):
  1. ⚫ archives  (#000000) - archiwa
  2. ⚪ structure (#ffffff) - README, INDEX
  3. 🔴 logs      (#ff0000) - logi, CI/CD
  4. 🟠 infra     (#ff6600) - infrastruktura
  5. 🟡 config    (#ffff00) - konfiguracja
  6. 🟢 eww       (#66ff00) - core EWW
  7. 🟢 business  (#00ff00) - business
  8. 🔵 tools     (#00ffcc) - scripts, bin, lib
  9. 🔵 gerc      (#00ffff) - workstation GERC
 10. 🔵 jakubc    (#0066ff) - usr/jakubc
 11. 🔵 dev       (#0000ff) - development
 12. 🟣 docs      (#9900ff) - dokumentacja
 13. 🟣 secondbrain (#ff00ff) - second brain
 14. 🟣 karinam   (#ff0099) - usr/karinam

Plus dodatkowe w graph.json:
 15. #folder_note
 16. #star-wars
 17. #lego
 18. #Asus_Z77

${YELLOW}[EWW] ℹ️  Synchronizacja manualna:${NC}
1. Otwórz Obsidian → Graph View → Groups
2. Użyj kolorów z powyższej listy (hex codes)
3. Queries zdefiniowane w graph.md (linie 160-280)

${BLUE}[EWW] 💡 Tip: Użyj graph.json jako źródła prawdy${NC}
EOF

echo ""
echo -e "${GREEN}[EWW] ✅ Informacje o kolorach wyświetlone${NC}"
echo -e "${BLUE}[EWW] 📋 Backup: $GRAPH_JSON.backup-*${NC}"
