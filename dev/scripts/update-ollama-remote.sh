#!/usr/bin/env bash
# File: dev/scripts/update-ollama-remote.sh
# Author: 
# Created: 
# Updated: 
# Description: update-ollama-remote.sh - Aktualizacja Ollama na serwerze zdalnym
# update-ollama-remote.sh - Aktualizacja Ollama na serwerze zdalnym
set -euo pipefail

readonly SERVER="jakubc@192.168.0.212"
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

echo -e "${YELLOW}[EWW]${NC} Aktualizacja Ollama na ${SERVER}..."

# Sprawdź obecną wersję
echo -e "${YELLOW}[EWW]${NC} Obecna wersja:"
ssh "$SERVER" "ollama --version"

# Aktualizacja
echo -e "${YELLOW}[EWW]${NC} Pobieranie najnowszej wersji..."
ssh -tt "$SERVER" "curl -fsSL https://ollama.com/install.sh | sudo sh"

# Sprawdź nową wersję
echo -e "${GREEN}[EWW]${NC} Nowa wersja:"
ssh "$SERVER" "ollama --version"

# Restart service
echo -e "${YELLOW}[EWW]${NC} Restart Ollama service..."
ssh "$SERVER" "sudo systemctl restart ollama || true"

echo -e "${GREEN}[EWW]${NC} ✓ Aktualizacja zakończona!"

{
  "models": [
    {
      "title": "Qwen 2.5 Coder 7B",  // Główny model
      "provider": "ollama",
      "model": "qwen2.5-coder:7b",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {  // Autocomplete
    "model": "qwen2.5-coder:7b"
  },
  "embeddingsProvider": {    // Wyszukiwanie w kodzie
    "model": "nomic-embed-text"
  }
}
