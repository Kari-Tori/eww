#!/usr/bin/env bash
# musi być SOURCOWANY z ~/.bashrc; bezpieczny także przy uruchomieniu

eww::init() {
  case "$-" in *i*) ;; *) return 0 ;; esac
  [[ -n "${EWW_BANNER_SHOWN-}" ]] && return 0
  export EWW_BANNER_SHOWN=1
  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB_BANER="${EWW_ROOT}/lib/bash/baner.sh"

  : "${EWW_CD_ROOT:=1}"
  if [[ "$EWW_CD_ROOT" != "0" && -d "$EWW_ROOT" && "${PWD:-}" != "$EWW_ROOT" ]]; then
    cd "$EWW_ROOT" || :
  fi

  : "${EWW_BANNER_PREFIX:=Miłego dnia}"
  : "${EWW_BANNER_ZALOGOWANYNA:=zalogowany na}"
  : "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
  : "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

  if [[ -r "$LIB_BANER" ]]; then
    # shellcheck source=/git/eww/lib/bash/baner.sh
    . "$LIB_BANER"
    export EWW_INIT_OK=1
    if type eww::baner >/dev/null 2>&1; then
      eww::baner
    fi
  else
    printf "\n╭─ %s@%s • %s\n" "$(id -un)" "$(hostname)" "$(date '+%F %T')"
    printf "╰─ %s • %s • repo:%s • cfg:%s [MIN]\n\n" \
      "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}" \
      "$EWW_ROOT" "$EWW_ROOT/init-eww.sh"
  fi
  return 0
}

# działa poprawnie gdy: sourced → return; uruchomiony → exit 0
if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  eww::init; return
else
  eww::init; exit 0
fi
