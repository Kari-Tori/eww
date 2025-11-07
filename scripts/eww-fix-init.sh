#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=/git/eww

# --- init-eww.sh ---
TMP="$(mktemp)"
cat >"$TMP" <<'INIT'
#!/usr/bin/env bash
# SOURCOWANY z ~/.bashrc

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

  local show=1
  if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then show=0; else export EWW_BANNER_SHOWN=1; fi

  if [[ $show -eq 1 ]]; then
    if [[ -r "$LIB_BANER" ]]; then
      # shellcheck source=/git/eww/lib/bash/baner.sh
      . "$LIB_BANER"
      export EWW_INIT_OK=1
      if type eww::baner >/dev/null 2>&1; then eww::baner; fi
    else
      printf "\n╭─ %s@%s • %s\n" "$(id -un)" "$(hostname)" "$(date '+%F %T')"
      printf "╰─ %s • %s • repo:%s • cfg:%s [MIN]\n\n" \
        "${EWW_BANNER_BOTTOM_LEFT}" "${EWW_BANNER_BOTTOM_RIGHT}" \
        "$EWW_ROOT" "$EWW_ROOT/init-eww.sh"
    fi
  fi
}
eww::init
INIT
bash -n "$TMP"; mv "$TMP" "$ROOT/init-eww.sh"; chmod 644 "$ROOT/init-eww.sh"

# --- lib/bash/baner.sh ---
TMP="$(mktemp)"
cat >"$TMP" <<'LIB'
# shellcheck shell=bash
eww::baner() {
  local who host now up load mem home ac repo cfg ok
  who="$(id -un)"; host="$(hostname)"; now="$(date '+%F %T')"

  if uptime -p >/dev/null 2>&1; then up="$(uptime -p | sed 's/^up //')"; else up="n/a"; fi
  load="$(awk '{printf "%s %s %s",$1,$2,$3}' /proc/loadavg 2>/dev/null || echo "n/a n/a n/a")"
  mem="$(free -m 2>/dev/null | awk '/Mem:/ {printf "%s/%sMiB",$3,$2}' || echo "n/a")"
  home="$(df -h ~ 2>/dev/null | awk 'NR==2{print $4}' || echo "n/a")"
  if command -v systemctl >/dev/null 2>&1; then
    systemctl --user is-active eww-autocommit.timer >/dev/null 2>&1 && ac="on" || ac="off"
  else ac="n/a"; fi

  repo="${EWW_ROOT:-/git/eww}"
  cfg="${repo}/init-eww.sh"
  ok=$([[ "${EWW_INIT_OK:-1}" = "1" ]] && echo "OK" || echo "MISS")

  [[ -n "${EWW_BANNER_PREFIX:-}" ]] && printf "%s %s\n" "${EWW_BANNER_PREFIX}" "${now}"

  printf "\n╭─ %s@%s • %s\n" "$who" "$host" "$now"
  printf "├─ up:%s • load:%s • mem:%s • home:%s • ac:%s\n" "$up" "$load" "$mem" "$home" "$ac"
  printf "╰─ %s • %s • repo:%s • cfg:%s [%s]\n\n" \
         "${EWW_BANNER_BOTTOM_LEFT:-E-Waste Workshop}" \
         "${EWW_BANNER_BOTTOM_RIGHT:-www.E-WasteWorkshop.co.uk}" \
         "$repo" "$cfg" "$ok"
  return 0
}
LIB
bash -n "$TMP"; mv "$TMP" "$ROOT/lib/bash/baner.sh"; chmod 644 "$ROOT/lib/bash/baner.sh"

# --- self-test ---
unset EWW_BANNER_SHOWN || true
bash -lc 'source ~/.bashrc; printf "PWD:%s\n" "$PWD"; type -t eww::baner'
