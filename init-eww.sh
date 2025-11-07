#!/usr/bin/env bash
# init-eww.sh — stabilna inicjalizacja /git/eww z banerem jednokrotnym
set -Eeuo pipefail

EWW_ROOT="${EWW_ROOT:-/git/eww}"

banner() {
  printf "\n╭─ %s@%s • %s\n" "$(whoami)" "$(hostname)" "$(date '+%F %T')"
  printf "├─ up:%s • load:%s\n" "$(uptime -p | sed 's/^up //')" "$(cut -d' ' -f1-3 /proc/loadavg)"
  printf "╰─ E-Waste Workshop • %s\n\n" "$EWW_ROOT"
}

run_init() {
  mkdir -p "$EWW_ROOT"
  export EWW_ROOT
  export EWW_INIT_OK=1
  export EWW_INIT_DONE=1        # nowa powłoka nie zainicjuje ponownie przez .bashrc
  [[ "$PWD" != "$EWW_ROOT" ]] && cd "$EWW_ROOT"

  # baner tylko raz na proces i tylko gdy TTY
  if [[ -t 1 && -z "${EWW_BANNER_SHOWN-}" ]]; then
    export EWW_BANNER_SHOWN=1
    banner
  fi
}

# źródłowany → zmień bieżącą powłokę i wróć
if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  run_init
  return 0 2>/dev/null || exit 0
fi

# uruchomiony bezpośrednio → wejście do nowej interaktywnej powłoki w /git/eww bez re-init .bashrc
run_init
exec env EWW_INIT_DONE=1 bash -i
