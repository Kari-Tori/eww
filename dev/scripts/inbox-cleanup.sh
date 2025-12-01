#!/usr/bin/env bash
# File: scripts/inbox-cleanup.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# cleanup
# maintenance
# script
# inbox-cleanup.sh - Przenoszenie plików z inbox'ów zgodnie z INBOX_ANALYSIS_20251121.md
# Autor: Analiza AI
# Data: 2025-11-21
# Opis: Reorganizacja 71 plików z inbox'ów do odpowiednich lokalizacji

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly PROJECT_ROOT

cd "$PROJECT_ROOT"

echo "📥 Przenoszenie plików z inbox'ów - według INBOX_ANALYSIS_20251121.md"
echo "📍 Lokalizacja: $PROJECT_ROOT"
echo ""

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Liczniki
moved=0
deleted=0
errors=0

# Funkcja pomocnicza do przenoszenia
move_file() {
    local src="$1"
    local dst="$2"

    if [[ ! -f "$src" ]]; then
        echo -e "${YELLOW}  ⚠️  Brak pliku: $src${NC}"
        return 1
    fi

    mkdir -p "$(dirname "$dst")"
    if mv -v "$src" "$dst" 2>/dev/null; then
        ((moved++))
        echo -e "${GREEN}  ✅ $src → $dst${NC}"
        return 0
    else
        ((errors++))
        echo -e "${RED}  ❌ Błąd: $src${NC}"
        return 1
    fi
}

read -p "❓ Kontynuować reorganizację inbox'ów? (71 plików) [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Anulowano"
    exit 0
fi

echo ""
echo -e "${BLUE}📚 Etap 1: Metodyki i strategie (6 plików)${NC}"

mkdir -p business/methodologies
move_file "archive/Archives Inbox/DevOps_Methodology.md" "business/methodologies/DevOps_Methodology.md"
move_file "archive/Archives Inbox/PARA_Metodyka_SecondBrain.md" "business/methodologies/PARA_Metodyka_SecondBrain.md"
move_file "archive/Archives Inbox/PARA_Metodyka_SecondBrain 1.md" "business/methodologies/PARA_Metodyka_SecondBrain_v2.md" || true
move_file "archive/Archives Inbox/Strategia_Blitzscaling_Uniwersalna.md" "business/methodologies/Strategia_Blitzscaling_Uniwersalna.md"
move_file "archive/Archives Inbox/Obsidian Dashboard.md" "business/methodologies/Obsidian_Dashboard.md"
move_file "archive/Archives Inbox/CopyCode_Cursor_Workflow.md" "business/methodologies/CopyCode_Cursor_Workflow.md"

echo ""
echo -e "${BLUE}👥 Etap 2: Dokumentacja team (5 plików)${NC}"

mkdir -p docs/team/karinam docs/team
move_file "archive/Archives Inbox/Karina_ESFP-T_Profil_E-Waste_Workshop.md" "docs/team/karinam/Karina_Profile_ESFP-T.md"
move_file "archive/Archives Inbox/Karina Tips.md" "docs/team/karinam/Karina_Tips.md"
move_file "archive/Archives Inbox/Karina Tips 2.md" "docs/team/karinam/Karina_Tips_v2.md"
move_file "archive/Archives Inbox/_Karina_Bash_NOTE.md" "docs/team/karinam/Karina_Bash_Notes.md"
move_file "archive/Archives Inbox/ADHD_General.md" "docs/team/ADHD_General.md"

echo ""
echo -e "${BLUE}📖 Etap 3: Dokumenty referencyjne (5 plików)${NC}"

mkdir -p docs/infra/references business/processes business/vendors
move_file "archive/Archives Inbox/Obsidian_Links.md" "docs/infra/references/Obsidian_Links.md"
move_file "archive/Archives Inbox/ctrl_h_dolphin.md" "docs/infra/references/ctrl_h_dolphin.md"
move_file "archive/Archives Inbox/Study.md" "docs/infra/references/Study.md"
move_file "archive/Archives Inbox/proces operacyjny.md" "business/processes/proces_operacyjny.md"
move_file "archive/Archives Inbox/wykonawca.md" "business/vendors/wykonawca.md"

echo ""
echo -e "${BLUE}🏗️ Etap 4: Infrastruktura i systemy (2 pliki)${NC}"

mkdir -p docs/infra/architecture var/status
move_file "projects/e-waste-workshop/Inbox/Systems_Deep_Dive.md" "docs/infra/architecture/Systems_Deep_Dive.md"
move_file "projects/e-waste-workshop/Inbox/EWW_System_Style_Status_2025-11-01_114327.md" "var/status/EWW_System_Style_Status_2025-11-01.md"

echo ""
echo -e "${BLUE}🎮 Etap 5: Grywalizacja i operacje (1 plik)${NC}"

mkdir -p business/Operacje/Gamification
move_file "projects/e-waste-workshop/Inbox/EWW_Motywacja_Grywalizacja.md" "business/Operacje/Gamification/EWW_Motywacja_Grywalizacja.md"

echo ""
echo -e "${BLUE}💰 Etap 6: Finanse i projekty (2 pliki)${NC}"

mkdir -p business/Finanse archive/05_PROJECTS/1Taat
move_file "archive/Archives Inbox/payments.md" "business/Finanse/payments.md"
move_file "archive/Archives Inbox/1Taat.md" "archive/05_PROJECTS/1Taat/1Taat.md"

echo ""
echo -e "${BLUE}📊 Etap 7: Dashboardy (1 plik)${NC}"

mkdir -p docs/infra/dashboards
move_file "projects/e-waste-workshop/Inbox/eww_weekly_dashboard_iso_w_45_03_09_11.md" "docs/infra/dashboards/eww_weekly_dashboard_w45.md"

echo ""
echo -e "${BLUE}📅 Etap 8: Daily notes (20+ plików)${NC}"

mkdir -p archive/daily-notes/2025/{04,05,06}

# Kwiecień
move_file "archive/Archives Inbox/2025-04-29.md" "archive/daily-notes/2025/04/2025-04-29.md"

# Maj
shopt -s nullglob
for f in "archive/Archives Inbox"/2025-05-*.md; do
    [[ "$f" =~ sync-conflict ]] && continue
    move_file "$f" "archive/daily-notes/2025/05/$(basename "$f")"
done
for f in "archive/Archives Inbox/"*.05.2025.md; do
    move_file "$f" "archive/daily-notes/2025/05/$(basename "$f")"
done

# Czerwiec
for f in "archive/Archives Inbox/"*.06.2025.md; do
    move_file "$f" "archive/daily-notes/2025/06/$(basename "$f")"
done
for f in "archive/Archives Inbox/Daily Notes/"*.md; do
    [[ "$(basename "$f")" == "Bez nazwy.md" ]] && continue
    move_file "$f" "archive/daily-notes/2025/06/$(basename "$f")"
done
shopt -u nullglob

echo ""
echo -e "${BLUE}📋 Etap 9: Metadata i indexy (8 plików)${NC}"

mkdir -p archive/indexes archive/tasks-snapshots

move_file "archive/Archives Inbox/Index.md" "archive/indexes/Index.md"
move_file "archive/Archives Inbox/_Index_of_01_INBOX.md" "archive/indexes/_Index_of_01_INBOX.md"
move_file "archive/Archives Inbox/_Index_of_E-Waste Workshop Vault.md" "archive/indexes/_Index_of_E-Waste_Workshop_Vault.md"
move_file "archive/Archives Inbox/Archives Inbox.md" "archive/indexes/Archives_Inbox.md"
move_file "archive/Archives Inbox/(Poprzedni) README.md" "archive/indexes/Poprzedni_README.md"

shopt -s nullglob
for f in "archive/Archives Inbox/Tasks Plugin"*.md; do
    move_file "$f" "archive/tasks-snapshots/$(basename "$f")"
done
shopt -u nullglob
move_file "archive/Archives Inbox/Todo.md" "archive/tasks-snapshots/Todo.md"

echo ""
echo -e "${RED}🗑️ Etap 10: Usuwanie śmieciowych plików${NC}"

# Bez nazwy
[[ -f "archive/Archives Inbox/Bez nazwy.md" ]] && { rm -f "archive/Archives Inbox/Bez nazwy.md"; echo "  🗑️  Bez nazwy.md"; ((deleted++)); }
[[ -f "archive/Archives Inbox/Bez nazwy 1.md" ]] && { rm -f "archive/Archives Inbox/Bez nazwy 1.md"; echo "  🗑️  Bez nazwy 1.md"; ((deleted++)); }
[[ -f "archive/Archives Inbox/Daily Notes/Bez nazwy.md" ]] && { rm -f "archive/Archives Inbox/Daily Notes/Bez nazwy.md"; echo "  🗑️  Daily Notes/Bez nazwy.md"; ((deleted++)); }

# Sync conflicts
shopt -s nullglob
for f in "archive/Archives Inbox/"*sync-conflict*.md; do
    rm -f "$f"
    echo "  🗑️  $(basename "$f")"
    ((deleted++))
done
shopt -u nullglob

# Screenshots
shopt -s nullglob
for f in "archive/Archives Inbox/screenshot"*.png; do
    rm -f "$f"
    echo "  🗑️  $(basename "$f")"
    ((deleted++))
done
shopt -u nullglob

# Puste pliki
[[ -f "archive/Archives Inbox/Inbox.md.md" ]] && { rm -f "archive/Archives Inbox/Inbox.md.md"; echo "  🗑️  Inbox.md.md"; ((deleted++)); }
[[ -f "archive/Archives Inbox/.keep" ]] && { rm -f "archive/Archives Inbox/.keep"; echo "  🗑️  .keep"; ((deleted++)); }

echo ""
echo -e "${BLUE}🧹 Etap 11: Czyszczenie pustych katalogów${NC}"

# Usuń puste foldery
rmdir "archive/Archives Inbox/Daily Notes" 2>/dev/null && echo "  🗑️  Daily Notes/" || true
rmdir "archive/Archives Inbox/.space" 2>/dev/null && echo "  🗑️  .space/" || true
rmdir "projects/e-waste-workshop/Inbox" 2>/dev/null && echo "  🗑️  projects/e-waste-workshop/Inbox/" || true
rmdir "archive/Archives Inbox" 2>/dev/null && echo "  🗑️  Archives Inbox/" || true

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Reorganizacja inbox'ów zakończona!${NC}"
echo ""
echo "📊 Statystyki:"
echo "  ✅ Przeniesione: $moved plików"
echo "  🗑️  Usunięte: $deleted plików"
echo "  ❌ Błędy: $errors"
echo ""
echo "📁 Nowa struktura:"
echo "  business/methodologies/    - 6 plików (PARA, DevOps, Blitzscaling)"
echo "  business/processes/        - 2 pliki (proces operacyjny)"
echo "  business/vendors/          - 1 plik (profil wykonawcy)"
echo "  docs/team/karinam/         - 4 pliki (profile, tips, bash)"
echo "  docs/team/                 - 1 plik (ADHD)"
echo "  docs/infra/references/           - 3 pliki (Obsidian, Study, ctrl_h_dolphin)"
echo "  docs/infra/architecture/   - 1 plik (Systems Deep Dive)"
echo "  docs/infra/dashboards/           - 1 plik"
echo "  business/Operacje/Gamification/ - 1 plik"
echo "  business/Finanse/          - 1 plik"
echo "  archive/daily-notes/2025/   - 20+ plików"
echo "  archive/indexes/            - 5 plików"
echo "  archive/tasks-snapshots/    - 4 pliki"
echo "  var/status/                 - 1 plik"
echo ""
echo "🎯 Inbox'y opróżnione i gotowe do usunięcia!"
