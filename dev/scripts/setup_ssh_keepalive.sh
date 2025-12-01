#!/usr/bin/env bash
set -euo pipefail

# Skrypt pomocniczy: generuje klucz SSH do użytku przez ssh_keepalive.sh,
# kopiuje publiczny klucz na zdalny host (ssh-copy-id lub instrukcja),
# kopiuje jednostkę systemd --user z repo do ~/.config/systemd/user i uruchamia ją.
#
# Użycie:
#   ./scripts/setup_ssh_keepalive.sh [REMOTE_USER] [REMOTE_HOST] [SSH_KEY]
# Przykład:
#   ./scripts/setup_ssh_keepalive.sh gerc 192.168.0.99 ~/.ssh/id_rsa_eww

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

REMOTE_USER="${1:-$USER}"
REMOTE_HOST="${2:-192.168.0.99}"
SSH_KEY="${3:-$HOME/.ssh/id_rsa_eww}"
SSH_PUB="${SSH_KEY}.pub"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYSTEMD_SRC="$REPO_ROOT/systemd/eww-ssh-keepalive.service"
SYSTEMD_DST="$HOME/.config/systemd/user"

eww::log "Remote: ${REMOTE_USER}@${REMOTE_HOST}"
eww::log "Klucz: ${SSH_KEY}"

# Generuj klucz jeśli brak
if [[ ! -f "$SSH_KEY" ]]; then
  eww::log "Tworzę klucz SSH (ed25519): $SSH_KEY"
  mkdir -p "$(dirname "$SSH_KEY")"
  ssh-keygen -t ed25519 -f "$SSH_KEY" -N "" -C "eww-ssh-keepalive@$(hostname)" || true
fi

if [[ ! -f "$SSH_PUB" ]]; then
  eww::err "Brak pliku publicznego klucza: $SSH_PUB"
  exit 1
fi

# Spróbuj automatycznie skopiować klucz publiczny
if command -v ssh-copy-id >/dev/null 2>&1; then
  eww::log "Kopiuję klucz publiczny na ${REMOTE_USER}@${REMOTE_HOST} (ssh-copy-id)"
  ssh-copy-id -i "$SSH_PUB" -p 22 "${REMOTE_USER}@${REMOTE_HOST}" || {
    eww::err "ssh-copy-id nie powiodło się — sprawdź hasło/połączenie"
    eww::log "Jeśli ssh-copy-id nie działa, dodaj ręcznie zawartość $SSH_PUB do ~/.ssh/authorized_keys na zdalnym hoście."
  }
else
  eww::log "Brak ssh-copy-id — proszę ręcznie dodać zawartość:"
  eww::log "cat $SSH_PUB | ssh ${REMOTE_USER}@${REMOTE_HOST} 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys'"
fi

# Kopiuj systemd unit do katalogu użytkownika
if [[ -f "$SYSTEMD_SRC" ]]; then
  mkdir -p "$SYSTEMD_DST"
  cp -v "$SYSTEMD_SRC" "$SYSTEMD_DST"/ || true
  eww::log "Skopiowano jednostkę systemd do: $SYSTEMD_DST"
  eww::log "Przeładuję daemon użytkownika i włączę usługę..."
  systemctl --user daemon-reload || true
  systemctl --user enable --now eww-ssh-keepalive.service || {
    eww::err "Nie udało się włączyć usługi. Uruchom ręcznie: systemctl --user enable --now eww-ssh-keepalive.service"
  }
else
  eww::err "Brak jednostki systemd w repo: $SYSTEMD_SRC"
fi

eww::log "Gotowe. Sprawdź status: systemctl --user status eww-ssh-keepalive.service"
