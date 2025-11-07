#!/usr/bin/env bash
# Nie używaj set -e/-u. Plik jest sourcowany.

# Drukuj tylko raz na proces powłoki
if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then
  return 0 2>/dev/null || exit 0
fi
EWW_BANNER_SHOWN=1   # celowo BEZ export

# Tymczasowo poluzuj pułapki, przywróć po banerze
__nu_state="$(set -o | awk '/nounset/{print $2}')"
__pf_state="$(set -o | awk '/pipefail/{print $2}')"
set +u; set +o pipefail

# Domyślne etykiety (nadpisywane w ~/.bashrc)
: "${EWW_BANNER_GREETING:=Miłego dnia}"
: "${EWW_BANNER_TITLE:=E-Waste Workshop}"

if [[ -r /git/eww/lib/banner.sh ]]; then
  . /git/eww/lib/banner.sh
  banner::show || true
else
  printf '╭─ %s@%s • %s\n' "$(whoami)" "$(hostname)" "$(date '+%F %T')"
  printf '╰─ %s • %s\n' "${EWW_BANNER_GREETING}" "${EWW_BANNER_TITLE}"
fi

[[ "${__nu_state}" == on ]] && set -u || set +u
[[ "${__pf_state}" == on ]] && set -o pipefail || set +o pipefail
unset __nu_state __pf_state
