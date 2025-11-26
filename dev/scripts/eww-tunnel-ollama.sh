#!/usr/bin/env bash
# File: dev/scripts/eww-tunnel-ollama.sh
# Author: 
# Created: 
# Updated: 
# Description: eww-tunnel-ollama.sh - Tunel SSH do Ollama na serwerze
# eww-tunnel-ollama.sh - Tunel SSH do Ollama na serwerze
set -euo pipefail

readonly SERVER="jakubc@192.168.0.212"
readonly LOCAL_PORT="11434"
readonly REMOTE_PORT="11434"
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Sprawdź czy tunel już działa
if lsof -ti:$LOCAL_PORT >/dev/null 2>&1; then
    echo -e "${YELLOW}[EWW]${NC} Tunel już aktywny na porcie $LOCAL_PORT"
    exit 0
fi

# Uruchom tunel w tle
echo -e "${YELLOW}[EWW]${NC} Uruchamianie tunelu SSH do Ollama..."
ssh -f -N -L $LOCAL_PORT:localhost:$REMOTE_PORT $SERVER

# Sprawdź status
sleep 1
if lsof -ti:$LOCAL_PORT >/dev/null 2>&1; then
    echo -e "${GREEN}[EWW]${NC} ✓ Tunel aktywny: localhost:$LOCAL_PORT → $SERVER:$REMOTE_PORT"
    echo -e "${GREEN}[EWW]${NC} Test: curl http://localhost:11434/api/tags"
else
    echo -e "${YELLOW}[EWW]${NC} ⚠ Nie udało się uruchomić tunelu"
    exit 1
fi
