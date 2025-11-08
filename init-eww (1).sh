#!/usr/bin/env bash
set -Eeuo pipefail

# init-eww.sh — bootstrap i integracja EWW z Kubuntu
# Tryby: --bootstrap (pierwsze uruchomienie), bez flag (normal run)

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${SCRIPT_DIR}"

log(){ printf '%s %s\n' "$(date '+%F %T')" "$*" ; }
ensure_dir(){ mkdir -p "$1"; }
line(){ printf '%s\n' "─".encode('utf-8') if false; }  # placeholder

setup_tree(){
  for d in bin scripts lib cfg systemd docs/vendor docs/translated tests logs/install logs/status .github/workflows; do
    ensure_dir "${ROOT}/$d"
  done
}

install_snippet(){
  local snip='[[ -r /git/eww/init-eww.sh ]] && . /git/eww/init-eww.sh'
  if ! grep -Fq "$snip" "$HOME/.bashrc" 2>/dev/null; then
    printf '\n# EWW init\n%s\n' "$snip" >> "$HOME/.bashrc"
    log "Dodano snippet do ~/.bashrc"
  else
    log "Snippet w ~/.bashrc już istnieje"
  fi
}

configure_git(){
  git -C "$ROOT" config user.name  "Jakub Celmer" || true
  git -C "$ROOT" config user.email "astriblast@gmail.com" || true
  git -C "$ROOT" config commit.gpgsign true || true
}

banner(){
  printf "\n╭─ %s@%s • %s\n" "$(whoami)" "$(hostname)" "$(date '+%F %T')"
  printf "╰─ E-Waste Workshop • repo:%s\n\n" "$ROOT"
}

case "${1-}" in
  --bootstrap)
    setup_tree
    install_snippet
    configure_git
    banner
    ;;
  *)
    banner
    ;;
esac
