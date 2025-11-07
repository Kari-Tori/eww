#!/usr/bin/env bash
# UWAGA: plik musi być SOURCOWANY z ~/.bashrc, nie uruchamiany.
# Nigdy nie wychodź z powłoki: zero "exit", tylko "return".

# tylko interaktywna powłoka
case "$-" in *i*) : ;; *) return 0 2>/dev/null || : ;; esac

# strażnik: baner tylko raz
if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then return 0 2>/dev/null || :; fi
export EWW_BANNER_SHOWN=1

# ścieżki
export EWW_ROOT="${EWW_ROOT:-/git/eww}"
LIB_BANER="${EWW_ROOT}/lib/bash/baner.sh"

# opcjonalne auto-cd (wyłącz: export EWW_CD_ROOT=0 w ~/.bashrc przed sourcem)
: "${EWW_CD_ROOT:=1}"
if [[ "$EWW_CD_ROOT" != "0" && -d "$EWW_ROOT" && "${PWD:-}" != "$EWW_ROOT" ]]; then
  cd "$EWW_ROOT" 2>/dev/null || :
fi

# domyślne teksty banera (bez set -u, więc bezpieczne)
: "${EWW_BANNER_PREFIX:=Miłego dnia}"
: "${EWW_BANNER_ZALOGOWANYNA:=zalogowany na}"
: "${EWW_BANNER_BOTTOM_LEFT:=E-Waste Workshop}"
: "${EWW_BANNER_BOTTOM_RIGHT:=www.E-WasteWorkshop.co.uk}"

# drukuj baner jeśli biblioteka istnieje; w przeciwnym razie minimalny fallback
if [[ -r "$LIB_BANER" ]]; then
  # shellcheck source=/git/eww/lib/bash/baner.sh
  . "$LIB_BANER"
  type eww::baner >/dev/null 2>&1 && eww::baner || :
else
  printf "\n╭─ %s@%s • %s\n" "$(id -un)" "$(hostname)" "$(date '+%F %T')"
  printf "╰─ %s • %s • repo:%s • cfg:%s [MIN]\n\n" \
    "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}" \
    "$EWW_ROOT" "$EWW_ROOT/init-eww.sh"
fi

return 0 2>/dev/null || :
