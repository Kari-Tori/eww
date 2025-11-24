#!/usr/bin/env bash
# sync-karinam-obsidian.sh - Synchronizuje usr/karinam do Obsidian vault Kariny
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

readonly LOCAL_PATH="usr/karinam/"
readonly REMOTE_USER="karinam"
readonly REMOTE_HOST="192.168.0.77"
readonly REMOTE_PATH="~/git/eww/usr/karinam/"

cd "$(git rev-parse --show-toplevel)"

echo -e "${BLUE}[EWW] Synchronizacja usr/karinam → Obsidian vault Kariny...${NC}"

# Rsync (bez desktop - to SSHFS mount)
rsync -avz --delete \
  --exclude='.Trash*' \
  --exclude='desktop/' \
  "${LOCAL_PATH}" \
  "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo -e "${GREEN}[EWW] ✓ Zsynchronizowano!${NC}"
echo -e "${BLUE}[EWW] Karina może teraz odświeżyć Obsidian (Ctrl+R)${NC}"
