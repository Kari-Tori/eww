#!/usr/bin/env bash
: "${EWW_AC_OVERRIDE:=on}"
# źródłowane z ~/.bashrc; bez "exit"
eww::init() {
  [[ $- == *i* ]] || return 0
  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB="$EWW_ROOT/lib/bash/baner.sh"

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

  # raz na sesję
  if [[ -z "${EWW_BANNER_SHOWN-}" ]]; then
    export EWW_BANNER_SHOWN=1 EWW_INIT_OK=1
    if declare -F eww_banner >/dev/null; then
      eww_banner
    fi
  else
    export EWW_INIT_OK=1
  fi
}
eww::init
