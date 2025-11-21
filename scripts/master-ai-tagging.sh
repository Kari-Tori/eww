#!/usr/bin/env bash
# Master skrypt - wyczyść i otaguj wszystkie pliki przez AI
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

readonly VAULT_ROOT="/home/jakubc/git/eww"
readonly SCRIPTS_DIR="$VAULT_ROOT/scripts"

echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     🤖 MASTER AI AUTO-TAGGING PIPELINE                    ║
║                                                           ║
║     Krok 1: Wyczyść wszystkie stare tagi                  ║
║     Krok 2: Przeanalizuj pliki przez AI                   ║
║     Krok 3: Wygeneruj 7 tagów dla każdego pliku          ║
║     Krok 4: Zbierz statystyki i listę wszystkich tagów   ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo ""

# Szacowany czas
total_files=$(find "$VAULT_ROOT" -name "*.md" -type f | wc -l)
estimated_minutes=$(( total_files / 10 ))

echo -e "${BLUE}📊 Analiza repozytorium:${NC}"
echo -e "  • Plików MD: ${YELLOW}$total_files${NC}"
echo -e "  • Szacowany czas: ${YELLOW}~${estimated_minutes} minut${NC} (bez AI)"
echo -e "  • Szacowany czas z AI: ${YELLOW}~$(( total_files / 2 )) minut${NC} (z Ollama/Copilot)"
echo ""

read -p "Kontynuować? (t/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Tt]$ ]]; then
    echo -e "${RED}✗${NC} Anulowano"
    exit 0
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN} KROK 1/4: CZYSZCZENIE STARYCH TAGÓW${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""

if [ -f "$SCRIPTS_DIR/clean-all-frontmatter-tags.sh" ]; then
    "$SCRIPTS_DIR/clean-all-frontmatter-tags.sh"
else
    echo -e "${RED}✗${NC} Brak skryptu: clean-all-frontmatter-tags.sh"
    exit 1
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN} KROK 2/4: SPRAWDZENIE AI ENGINE${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Sprawdź czy Ollama jest dostępna
if command -v ollama &>/dev/null && pgrep -x ollama >/dev/null; then
    echo -e "${GREEN}✓${NC} Ollama dostępna - użyję lokalnego AI"
    AI_ENGINE="ollama"
elif command -v gh &>/dev/null && gh copilot --version &>/dev/null; then
    echo -e "${GREEN}✓${NC} GitHub Copilot CLI dostępny - użyję Copilot"
    AI_ENGINE="copilot"
else
    echo -e "${YELLOW}⚠${NC}  Brak AI engine - użyję heurystyki"
    AI_ENGINE="heuristic"
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN} KROK 3/4: GENEROWANIE TAGÓW${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""

case "$AI_ENGINE" in
    ollama)
        if [ -f "$SCRIPTS_DIR/ai-tagger.sh" ]; then
            "$SCRIPTS_DIR/ai-tagger.sh"
        else
            echo -e "${RED}✗${NC} Brak skryptu: ai-tagger.sh"
            exit 1
        fi
        ;;
    copilot)
        if [ -f "$SCRIPTS_DIR/copilot-ai-tagger.sh" ]; then
            "$SCRIPTS_DIR/copilot-ai-tagger.sh"
        else
            echo -e "${RED}✗${NC} Brak skryptu: copilot-ai-tagger.sh"
            exit 1
        fi
        ;;
    heuristic)
        if [ -f "$SCRIPTS_DIR/copilot-ai-tagger.sh" ]; then
            # Copilot tagger ma wbudowaną heurystykę
            "$SCRIPTS_DIR/copilot-ai-tagger.sh"
        else
            echo -e "${RED}✗${NC} Brak skryptu tagowania"
            exit 1
        fi
        ;;
esac

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN} KROK 4/4: STATYSTYKI I RAPORT${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Zbierz statystyki
if [ -f "$VAULT_ROOT/var/all-generated-tags.txt" ]; then
    total_unique_tags=$(sort "$VAULT_ROOT/var/all-generated-tags.txt" | uniq | wc -l)
    total_tag_uses=$(wc -l < "$VAULT_ROOT/var/all-generated-tags.txt")
    
    echo -e "${BLUE}📊 Statystyki globalne:${NC}"
    echo -e "  • Unikalnych tagów: ${GREEN}$total_unique_tags${NC}"
    echo -e "  • Całkowite użycia: ${GREEN}$total_tag_uses${NC}"
    echo -e "  • Średnio tagów/plik: ${GREEN}$(( total_tag_uses / total_files ))${NC}"
    echo ""
    
    # Top 30 tagów
    echo -e "${BLUE}📌 Top 30 najczęstszych tagów:${NC}"
    sort "$VAULT_ROOT/var/all-generated-tags.txt" | uniq -c | sort -rn | head -30 | \
        awk '{printf "  %3d × %s\n", $1, $2}'
    echo ""
    
    # Zapisz raport
    cat > "$VAULT_ROOT/var/AI-TAGGING-REPORT.md" << EOF
# 🤖 AI Auto-Tagging Report

**Data:** $(date '+%Y-%m-%d %H:%M:%S')  
**AI Engine:** $AI_ENGINE  
**Plików przetworzonych:** $total_files  

## 📊 Statystyki

- **Unikalnych tagów:** $total_unique_tags
- **Całkowite użycia tagów:** $total_tag_uses
- **Średnio tagów na plik:** $(( total_tag_uses / total_files ))

## 📌 Top 30 Tagów

$(sort "$VAULT_ROOT/var/all-generated-tags.txt" | uniq -c | sort -rn | head -30 | awk '{printf "- **%s** - użyty %d razy\n", $2, $1}')

## 📁 Pliki

Zobacz szczegóły w: \`var/ai-tagging-progress.txt\`
EOF
    
    echo -e "${GREEN}✓${NC} Raport zapisany w: var/AI-TAGGING-REPORT.md"
fi

echo ""
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║                    ✅ GOTOWE!                             ║
║                                                           ║
║     Wszystkie pliki przetworzone i otagowane              ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo ""

echo -e "${BLUE}📁 Pliki wyjściowe:${NC}"
echo -e "  • ${GREEN}var/all-generated-tags.txt${NC} - wszystkie tagi"
echo -e "  • ${GREEN}var/ai-tagging-progress.txt${NC} - progress"
echo -e "  • ${GREEN}var/AI-TAGGING-REPORT.md${NC} - raport końcowy"
echo ""

echo -e "${YELLOW}ℹ  Następne kroki:${NC}"
echo -e "  1. Sprawdź raport: cat var/AI-TAGGING-REPORT.md"
echo -e "  2. Commit zmian: git add . && git commit -m 'feat: AI auto-tagging complete'"
echo -e "  3. Odśwież Obsidian graph"
echo ""
