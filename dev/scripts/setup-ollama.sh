#!/usr/bin/env bash
# Setup Ollama + LLaMA dla AI taggowania
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║    SETUP OLLAMA + LLAMA 3.2            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# 1. Sprawdź czy Ollama jest zainstalowany
if ! command -v ollama &> /dev/null; then
    echo -e "${YELLOW}[1/4]${NC} Instaluję Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo -e "${GREEN}✓${NC} Ollama już zainstalowane"
fi

# 2. Uruchom Ollama
echo -e "${YELLOW}[2/4]${NC} Uruchamiam Ollama service..."
if ! pgrep -x ollama > /dev/null; then
    ollama serve &
    sleep 5
fi
echo -e "${GREEN}✓${NC} Ollama działa"

# 3. Pobierz model LLaMA 3.2 (3B - szybki i efektywny)
echo -e "${YELLOW}[3/4]${NC} Pobieram model LLaMA 3.2:3b..."
if ! ollama list | grep -q "llama3.2:3b"; then
    ollama pull llama3.2:3b
else
    echo -e "${GREEN}✓${NC} Model już pobrany"
fi

# 4. Test
echo -e "${YELLOW}[4/4]${NC} Test modelu..."
response=$(curl -s http://localhost:11434/api/generate \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3.2:3b",
        "prompt": "Wygeneruj 3 przykładowe tagi dla pliku o nazwie setup.md. Odpowiedz tylko listą tagów.",
        "stream": false
    }' | jq -r '.response')

echo -e "${GREEN}✓${NC} Odpowiedź modelu:"
echo "$response"
echo ""

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║         GOTOWE! Możesz używać          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo "Uruchom teraz: ./scripts/ai-tagger.sh"
