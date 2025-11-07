# shellcheck shell=bash
eww_banner() {
  local who host now up load mem home ac repo cfg ok
  who="$(id -un)"; host="$(hostname)"; now="$(date '+%F %T')"

  if uptime -p >/dev/null 2>&1; then up="$(uptime -p | sed 's/^up //')"; else up="n/a"; fi
  load="$(awk '{printf "%s %s %s",$1,$2,$3}' /proc/loadavg 2>/dev/null || echo "n/a n/a n/a")"

  if [[ -r /proc/meminfo ]]; then
    mem="$(awk '
      $1=="MemTotal:"{tot=$2}
      $1=="MemAvailable:"{ava=$2}
      END{
        if(tot>0){
          if(ava=="") ava=0;
          use=tot-ava; printf "%d/%dMiB", use/1024, tot/1024
        } else { print "" }
      }' /proc/meminfo)"
  fi
  [[ -z "${mem:-}" ]] && mem="n/a"

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

# kompatybilność: spróbuj zarejestrować starą nazwę
eval 'eww::baner(){ eww_banner "$@"; }' 2>/dev/null || :
