#!/usr/bin/env bash
: "${EWW_AC_OVERRIDE:=on}"
# źródłowane z ~/.bashrc; bez "exit"
eww::init() {
  [[ $- == *i* ]] || return 0
  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB="$EWW_ROOT/lib/bash/baner.sh"
  local LOG_LIB="$EWW_ROOT/lib/log.sh"

  : "${EWW_CD_ROOT:=1}"
  if [[ "$EWW_CD_ROOT" != 0 && -d "$EWW_ROOT" && "$PWD" != "$EWW_ROOT" ]]; then
    cd "$EWW_ROOT" || true
  fi

  : "${EWW_BANNER_PREFIX:=Miłego dnia}"
  : "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
  : "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

  if [[ -r "$LIB" ]]; then
    # shellcheck source=/git/eww/lib/bash/baner.sh
    . "$LIB"
  fi

  # Optional logger: provides info/warn/error functions and appends to a per-user log
  if [[ -r "$LOG_LIB" ]]; then
    # shellcheck source=/git/eww/lib/log.sh
    . "$LOG_LIB"
  fi

# Opcjonalna rotacja logów przy starcie (domyślnie 0)
: "${EWW_ROTATE_ON_START:=0}"
  if [[ "${EWW_ROTATE_ON_START}" = "1" ]] && declare -F eww_log_rotate >/dev/null 2>&1; then
    # przenieś stary plik loga do archiwum z timestampem
    eww_log_rotate
    if declare -F info >/dev/null 2>&1; then
      info "Log zrotowany przed startem"
    fi
  fi

  # log start
  if declare -F info >/dev/null 2>&1; then
    info "Rozpoczynam init-eww"
    info "EWW_ROOT=${EWW_ROOT}"
  fi

  # raz na sesję
  if [[ -z "${EWW_BANNER_SHOWN-}" ]]; then
    export EWW_BANNER_SHOWN=1 EWW_INIT_OK=1
    if declare -F eww_banner >/dev/null; then
      eww_banner
      if declare -F info >/dev/null 2>&1; then
        info "Banner wyświetlony"
      fi
    fi
  else
    export EWW_INIT_OK=1
  fi

  if declare -F info >/dev/null 2>&1; then
    info "init-eww zakończone; EWW_INIT_OK=${EWW_INIT_OK:-0}"
  fi
}
eww::init
