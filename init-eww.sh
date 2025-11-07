#!/usr/bin/env bash
# SOURCOWANY z ~/.bashrc; bezpieczny także przy uruchomieniu

eww::init() {
  case "$-" in *i*) ;; *) return 0 ;; esac

  export EWW_ROOT="${EWW_ROOT:-/git/eww}"
  local LIB_BANER="${EWW_ROOT}/lib/bash/baner.sh"

  # auto-cd działa zawsze
  : "${EWW_CD_ROOT:=1}"
  if [[ "$EWW_CD_ROOT" != "0" && -d "$EWW_ROOT" && "${PWD:-}" != "$EWW_ROOT" ]]; then
    cd "$EWW_ROOT" || :
  fi

  # domyślne napisy
  : "${EWW_BANNER_PREFIX:=Miłego dnia}"
  : "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
  : "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

  # pokaż baner tylko raz na sesję
  local SHOW=1
  if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then
    SHOW=0
  else
    export EWW_BANNER_SHOWN=1
  fi

  if [[ $SHOW -eq 1 ]]; then
    if [[ -r "$LIB_BANER" ]]; then
      # shellcheck source=/git/eww/lib/bash/baner.sh
      . "$LIB_BANER"
      export EWW_INIT_OK=1
      type eww::baner >/dev/null 2>&1 && eww::baner
    else
      printf "\n╭─ %s@%s • %s\n" "$(id -un)" "$(hostname)" "$(date '+%F %T')"
      printf "╰─ %s • %s • repo:%s • cfg:%s [MIN]\n\n" \
        "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}" \
        "$EWW_ROOT" "$EWW_ROOT/init-eww.sh"
    fi
  fi
  return 0
}

# sourced → return; uruchomiony → exit 0
else
  eww::init; exit 0
fi
eww::init
