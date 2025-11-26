#!/usr/bin/env bash
# mount-karinam-desktop.sh - Montuje zdalny pulpit Kariny przez SSHFS
set -euo pipefail

readonly REMOTE_USER="karinam"
readonly REMOTE_HOST="192.168.0.77"
readonly REMOTE_PATH="/home/karinam/devices/asus_z77/desktop"
readonly LOCAL_MOUNT="/home/jakubc/git/eww/usr/karinam/devices/asus_z77/desktop"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Sprawdź czy katalog docelowy istnieje
if [[ ! -d "$LOCAL_MOUNT" ]]; then
    echo -e "${RED}[EWW] Błąd: Katalog docelowy nie istnieje: $LOCAL_MOUNT${NC}" >&2
    exit 1
fi

# Sprawdź czy już zamontowane
if mountpoint -q "$LOCAL_MOUNT"; then
    echo -e "${YELLOW}[EWW] Katalog już zamontowany: $LOCAL_MOUNT${NC}"
    exit 0
fi

# Sprawdź połączenie SSH
if ! ssh -q -o BatchMode=yes -o ConnectTimeout=5 "$REMOTE_USER@$REMOTE_HOST" exit 2>/dev/null; then
    echo -e "${RED}[EWW] Błąd: Nie można połączyć się przez SSH z $REMOTE_USER@$REMOTE_HOST${NC}" >&2
    echo -e "${YELLOW}[EWW] Upewnij się, że klucz SSH jest dodany: ssh-add${NC}" >&2
    exit 1
fi

# Montuj przez SSHFS
echo -e "${BLUE}[EWW] Montowanie: $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH${NC}"
echo -e "${BLUE}[EWW] Do katalogu: $LOCAL_MOUNT${NC}"

sshfs "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH" "$LOCAL_MOUNT" \
    -o reconnect \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o follow_symlinks

if mountpoint -q "$LOCAL_MOUNT"; then
    echo -e "${GREEN}[EWW] ✓ Pomyślnie zamontowano pulpit Kariny${NC}"
    echo -e "${GREEN}[EWW] Możesz teraz pracować na plikach w VS Code${NC}"
else
    echo -e "${RED}[EWW] Błąd montowania${NC}" >&2
    exit 1
fi
