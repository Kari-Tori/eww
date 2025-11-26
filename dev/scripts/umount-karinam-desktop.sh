#!/usr/bin/env bash
# umount-karinam-desktop.sh - Odmontowuje zdalny pulpit Kariny
set -euo pipefail

readonly LOCAL_MOUNT="/home/jakubc/git/eww/usr/karinam/desktop"

readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Sprawdź czy zamontowane
if ! mountpoint -q "$LOCAL_MOUNT"; then
    echo -e "${YELLOW}[EWW] Katalog nie jest zamontowany: $LOCAL_MOUNT${NC}"
    exit 0
fi

# Odmontuj
echo -e "${YELLOW}[EWW] Odmontowywanie: $LOCAL_MOUNT${NC}"
fusermount -u "$LOCAL_MOUNT"

if ! mountpoint -q "$LOCAL_MOUNT"; then
    echo -e "${GREEN}[EWW] ✓ Pomyślnie odmontowano${NC}"
else
    echo -e "${RED}[EWW] Błąd odmontowania${NC}" >&2
    exit 1
fi
