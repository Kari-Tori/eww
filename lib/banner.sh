#!/usr/bin/env bash
# /git/eww/lib/banner.sh
# Format:
# ╭─ baner.sh uzyty dnia: DD:MM:YYYY HH:mm przez user@zalogowanynaHOST:/abs/pwd w folderze /abs/pwd
# ╰─ eww_baner eww info?

: "${EWW_BANNER_ENABLE:=1}"            # 1=on, 0=off
: "${EWW_BANNER_TTY_ONLY:=1}"          # 1=drukuj tylko na TTY
: "${EWW_BANNER_PREFIX:=baner.sh uzyty dnia:}"
: "${EWW_BANNER_ZALOGOWANYNA:=zalogowanyna}"  # dokładnie jak żądasz
: "${EWW_BANNER_BOTTOM_LEFT:=eww_baner}"
: "${EWW_BANNER_BOTTOM_RIGHT:=eww info?}"
: "${EWW_BANNER_TIMEFMT:=%d:%m:%Y %H:%M}"

# — helpers (bez set -e/-u)
_banner_now()  { date +"${EWW_BANNER_TIMEFMT}"; }
_banner_user() { { id -un 2>/dev/null || whoami; } | tr -d '\n'; }
_banner_host() { hostname | tr -d '\n'; }
_banner_pwd()  { pwd -P 2>/dev/null || printf '%s' "${PWD-?}"; }

banner::line_top() {
  local now usr host path
  now="$(_banner_now)"; usr="$(_banner_user)"; host="$(_banner_host)"; path="$(_banner_pwd)"
  printf '╭─ %s %s przez %s@%s%s%s:%s w folderze %s\n' \
    "${EWW_BANNER_PREFIX}" \
    "${now}" \
    "${usr}" \
    "${EWW_BANNER_ZALOGOWANYNA}" \
    "" \
    "${host}" \
    "${path}" \
    "${path}"
}

banner::line_bottom() {
  printf '╰─ %s %s\n' "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}"
}

banner::show() {
  [[ "${EWW_BANNER_ENABLE}" -eq 1 ]] || return 0
  [[ -n "${PS1-}" ]] || return 0
  [[ "${EWW_BANNER_TTY_ONLY}" -eq 0 || -t 1 ]] || return 0
  [[ -z "${EWW_BANNER_SHOWN-}" ]] || return 0
  export EWW_BANNER_SHOWN=1
  banner::line_top
  banner::line_bottom
}
