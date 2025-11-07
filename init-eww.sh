#!/usr/bin/env bash
eww::init() {
  [[ $- == *i* ]] || return 0
  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB="$EWW_ROOT/lib/bash/baner.sh"

  : "${EWW_CD_ROOT:=1}"
  [[ "$EWW_CD_ROOT" != 0 && -d "$EWW_ROOT" && "$PWD" != "$EWW_ROOT" ]] && cd "$EWW_ROOT" || :

  : "${EWW_BANNER_PREFIX:=Miłego dnia}"
  : "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
  : "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

  [[ -r "$LIB" ]] && . "$LIB"

  if ! declare -F eww_banner >/dev/null; then
    eww_banner() { printf "EWW minimal banner\n"; }
  fi

  export EWW_INIT_OK=1
  if [[ -z "${EWW_BANNER_SHOWN-}" ]]; then
    export EWW_BANNER_SHOWN=1
    eww_banner
  fi
}
eww::init
