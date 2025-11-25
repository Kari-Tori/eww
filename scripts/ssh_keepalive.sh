#!/usr/bin/env bash
set -euo pipefail

# Skrypt uruchamia autossh (jeśli dostępny) lub pętlę ssh,
# aby utrzymać stałe połączenie z hostem zdalnym.
# Domyślnie:
#   REMOTE_USER=$USER
#   REMOTE_HOST=192.168.0.99
#   SSH_KEY=$HOME/.ssh/id_rsa_eww
# Można nadpisać przez eksport zmiennych lub argumenty:
#   REMOTE_USER=foo REMOTE_HOST=1.2.3.4 SSH_KEY=~/.ssh/key ./ssh_keepalive.sh

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

# Domyślne wartości
REMOTE_USER="${REMOTE_USER:-$USER}"
REMOTE_HOST="${REMOTE_HOST:-192.168.0.99}"
SSH_KEY="${SSH_KEY:-$HOME/.ssh/id_rsa_eww}"
SSH_PORT="${SSH_PORT:-22}"

# Jeśli podano argumenty pozycyjne: user host key port
if [[ $# -ge 1 ]]; then REMOTE_USER="$1"; fi
if [[ $# -ge 2 ]]; then REMOTE_HOST="$2"; fi
if [[ $# -ge 3 ]]; then SSH_KEY="$3"; fi
if [[ $# -ge 4 ]]; then SSH_PORT="$4"; fi

if [[ ! -f "$SSH_KEY" ]]; then
  eww::err "Klucz SSH nie istnieje: $SSH_KEY"
  eww::log "Uruchom ./scripts/setup_ssh_keepalive.sh aby go wygenerować i skopiować na zdalny host"
  exit 1
fi

eww::log "Utrzymuję połączenie: ${REMOTE_USER}@${REMOTE_HOST}:${SSH_PORT} (klucz: ${SSH_KEY})"

# Preferuj autossh jeśli jest zainstalowany
if command -v autossh >/dev/null 2>&1; then
  eww::log "Uruchamiam autossh"
  exec autossh -M 0 -N \
    -o "ServerAliveInterval=30" \
    -o "ServerAliveCountMax=3" \
    -o "ExitOnForwardFailure=yes" \
    -i "$SSH_KEY" -p "$SSH_PORT" "${REMOTE_USER}@${REMOTE_HOST}"
else
  eww::log "autossh nie znaleziony — używam pętli ssh z restartem"
  # fallback: restartuj ssh w pętli
  while true; do
    ssh -o "ServerAliveInterval=30" -o "ServerAliveCountMax=3" -i "$SSH_KEY" -p "$SSH_PORT" "${REMOTE_USER}@${REMOTE_HOST}" || true
    eww::log "Połączenie zakończone — restart za 5s"
    sleep 5
  done
fi
