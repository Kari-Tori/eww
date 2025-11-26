#!/usr/bin/env bash
set -euo pipefail

# Setup Continue.dev + Ollama dla auto-tagowania

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

echo -e "${BLUE}🚀 Konfiguracja Continue.dev + Ollama${NC}"
echo ""

# 1. Sprawdź Ollama
if ! command -v ollama &>/dev/null; then
    echo "📥 Instaluję Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# 2. Pobierz model CodeLlama
echo -e "${GREEN}📦 Pobieram model CodeLlama 13B...${NC}"
ollama pull codellama:13b

# 3. Uruchom Ollama service
echo -e "${GREEN}🔧 Uruchamiam Ollama service...${NC}"
systemctl --user enable ollama
systemctl --user start ollama

# 4. Konfiguracja Continue.dev
CONTINUE_CONFIG="$HOME/.continue/config.json"
mkdir -p "$(dirname "$CONTINUE_CONFIG")"

cat > "$CONTINUE_CONFIG" << 'EOF'
{
  "models": [
    {
      "title": "CodeLlama 13B",
      "provider": "ollama",
      "model": "codellama:13b",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {
    "title": "CodeLlama 13B",
    "provider": "ollama",
    "model": "codellama:13b"
  },
  "embeddingsProvider": {
    "provider": "ollama",
    "model": "nomic-embed-text"
  }
}
EOF

echo ""
echo -e "${GREEN}✅ Gotowe!${NC}"
echo ""
echo "Następne kroki:"
echo "  1. Zainstaluj Continue.dev extension w VSCode"
echo "  2. Uruchom: ./scripts/ai-auto-tag.sh"
echo ""
