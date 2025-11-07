#!/usr/bin/env bash
# SOURCOWANY z ~/.bashrc; bez "exit"

eww::init() {
  case "$-" in *i*) ;; *) return 0 ;; esac

  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB_BANER="${EWW_ROOT}/lib/bash/baner.sh"

  : "${EWW_CD_ROOT:=1}"
  if [[ "$EWW_CD_ROOT" != "0" && -d "$EWW_ROOT" && "${PWD:-}" != "$EWW_ROOT" ]]; then
    cd "$EWW_ROOT" || :
  fi

  : "${EWW_BANNER_PREFIX:=Miłego dnia}"
  : "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
  : "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

  # zawsze wczytaj bibliotekę
  [[ -r "$LIB_BANER" ]] && . "$LIB_BANER" && export EWW_INIT_OK=1

  # baner tylko raz na sesję
  if [[ -z "${EWW_BANNER_SHOWN-}" ]]; then
    export EWW_BANNER_SHOWN=1
    if declare -F eww_banner >/dev/null; then
      eww_banner
    elif declare -F 'eww::baner' >/dev/null; then
      eww::baner
    else
      printf "\n╭─ %s@%s • %s\n" "$(id -un)" "$(hostname)" "$(date '+%F %T')"
      printf "╰─ %s • %s • repo:%s • cfg:%s [MIN]\n\n" \
        "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}" \
        "$EWW_ROOT" "$EWW_ROOT/init-eww.sh"
    fi
  fi
}
eww::init
