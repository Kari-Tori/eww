#!/usr/bin/env bash
# Test konfiguracji grafu Obsidian
set -euo pipefail

VAULT="/home/jakubc/git/eww"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== TEST KONFIGURACJI GRAFU OBSIDIAN ===${NC}\n"

# Sprawdź pluginy
echo -e "${YELLOW}📦 Sprawdzam pluginy:${NC}"
plugins="waypoint folder-notes extended-graph graph-nested-tags obsidian-living-graph graph-analysis"
for plugin in $plugins; do
    if [[ -d "$VAULT/.obsidian/plugins/$plugin" ]]; then
        echo -e "  ${GREEN}✓${NC} $plugin"
    else
        echo -e "  ${RED}✗${NC} $plugin - BRAK!"
    fi
done

# Sprawdź pliki konfiguracyjne
echo -e "\n${YELLOW}⚙️  Sprawdzam konfigurację:${NC}"
configs="graph.json graph-colors.json community-plugins.json"
for config in $configs; do
    if [[ -f "$VAULT/.obsidian/$config" ]]; then
        echo -e "  ${GREEN}✓${NC} $config"
    else
        echo -e "  ${RED}✗${NC} $config - BRAK!"
    fi
done

# Sprawdź folder notes
echo -e "\n${YELLOW}📁 Sprawdzam folder notes:${NC}"
folders="business config core dev docs infra scripts tools usr"
for folder in $folders; do
    if [[ -f "$VAULT/$folder/$folder.md" ]]; then
        echo -e "  ${GREEN}✓${NC} $folder/$folder.md"
    else
        echo -e "  ${YELLOW}○${NC} $folder/$folder.md - do utworzenia"
    fi
done

# Statystyki tagów
echo -e "\n${YELLOW}🏷️  Statystyki tagów:${NC}"
tags_list="candy pink jakubc core docs business config tools scripts dev infrastructure"
for tag in $tags_list; do
    count=$(find "$VAULT" -name "*.md" -not -path "*/.obsidian/*" -exec grep -l "#$tag" {} \; 2>/dev/null | wc -l)
    if [[ ${count:-0} -gt 0 ]]; then
        echo -e "  #$tag: ${GREEN}$count${NC}"
    fi
done

# Podsumowanie
echo -e "\n${BLUE}=== PODSUMOWANIE ===${NC}"
total_md=$(find "$VAULT" -name "*.md" -not -path "*/.obsidian/*" | wc -l)
echo -e "  Pliki MD: ${GREEN}$total_md${NC}"

echo -e "\n${GREEN}✅ Test zakończony!${NC}"
echo -e "${YELLOW}💡 Aby zobaczyć graf w Obsidian:${NC}"
echo -e "   1. Otwórz vault: $VAULT"
echo -e "   2. Ctrl+G → Graph view"
echo -e "   3. Sprawdź kolorowanie folderów/tagów"
