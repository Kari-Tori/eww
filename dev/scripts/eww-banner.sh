#!/usr/bin/env bash
# File: scripts/eww-banner.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# display
# script
# ui
# Stabilny banner do źródłowania z .bashrc. Bez -e.
set -o pipefail

: "${EWW_BANNER_PREFIX:=Miłego dnia}"
: "${EWW_BANNER_SUFFIX:=}"
: "${EWW_BANNER_URL:=www.E-WasteWorkshop.co.uk}"
: "${EWW_REPO:=/git/eww}"
: "${EWW_CFG:=/git/eww/init-eww.sh}"

# eww_ac defined later in this file (more robust implementation).

eww_load(){ awk '{printf "load:%s %s %s", $1,$2,$3}' /proc/loadavg 2>/dev/null || printf 'load:? ? ?'; }

eww_mem(){
  local mt ma mf mb mc used
  mt=$(grep -m1 '^MemTotal:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
  ma=$(grep -m1 '^MemAvailable:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
  if [[ -n $mt && -n $ma ]]; then
    used=$(( (mt - ma) / 1024 )); printf 'mem:%d/%dMiB' "$used" "$(( mt/1024 ))"; return
  fi
  mf=$(grep -m1 '^MemFree:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
  mb=$(grep -m1 '^Buffers:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
  mc=$(grep -m1 '^Cached:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
  [[ -z $mt || -z $mf || -z $mb || -z $mc ]] && { printf 'mem:?'; return; }
  used=$(( (mt - mf - mb - mc) / 1024 )); printf 'mem:%d/%dMiB' "$used" "$(( mt/1024 ))"
}

eww_home(){
  local path="${HOME:-/}" s
  s=$(df -h --output=avail "$path" 2>/dev/null | tail -1 | tr -d ' ')
  printf 'home:%s' "${s:-?}"
}

eww_repo(){
  if command -v git >/dev/null 2>&1 && [[ -d "$EWW_REPO/.git" ]]; then
    local b left right
    b=$(git -C "$EWW_REPO" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')
    if git -C "$EWW_REPO" rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1; then
      read -r left right < <(git -C "$EWW_REPO" rev-list --left-right --count '@{upstream}'...HEAD 2>/dev/null || echo "0 0")
      printf 'repo:%s • br:%s%s%s' "$EWW_REPO" "$b" "${right:+ ↑$right}" "${left:+ ↓$left}"
    else
      printf 'repo:%s • br:%s' "$EWW_REPO" "$b"
    fi
  else
    printf 'repo:%s' "$EWW_REPO"
  fi
}

eww_uptime(){
  local up; up=$(uptime -p 2>/dev/null | sed 's/^up //;s/,//g' || true)
  [[ -n $up ]] && printf '%s' "$up" || uptime 2>/dev/null | sed 's/.* up \([^,]*\),.*/\1/' || printf '?'
}

eww_banner(){
  # Izolacja od -e/-u/pipefail rodzica
  local _had_e=0 _had_u=0 _had_pf=0
  case $- in *e*) _had_e=1;; esac
  case $- in *u*) _had_u=1;; esac
  if set -o | grep -q '^pipefail\W\+on$'; then _had_pf=1; fi
  set +e +u; set +o pipefail

  local now user host cfg_status
  now="$(date '+%F %T')" || true
  user="$(whoami 2>/dev/null || echo '?')"
  host="$(hostname 2>/dev/null || echo '?')"
  cfg_status=$([[ -r "$EWW_CFG" ]] && echo '[OK]' || echo '[MISS]')

  printf '%s %s\n\n' "$EWW_BANNER_PREFIX" "$now"
  printf '╭─ %s@%s • %s\n' "$user" "$host" "$now"
  printf '├─ up:%s • %s • %s • %s • %s • %s\n' "$(eww_uptime)" "$(eww_load)" "$(eww_mem)" "$(eww_home)" "$(eww_ac)" "$(eww_shell)"
  printf '╰─ E-Waste Workshop • %s • %s • cfg:%s %s%s\n\n' \
    "$EWW_BANNER_URL" "$(eww_repo)" "$EWW_CFG" "$cfg_status" \
    "${EWW_BANNER_SUFFIX:+ • $EWW_BANNER_SUFFIX}"

  if (( _had_pf )); then
    set -o pipefail
  else
    set +o pipefail
  fi
  if (( _had_e )); then
    set -e
  else
    set +e
  fi
  if (( _had_u )); then
    set -u
  else
    set +u
  fi
  return 0
}
eww_ac(){
  # sysfs → upower → acpi → n/a, z opcjonalnym override
  local mains="" bat="" s="ac:n/a"

  # override przez zmienną środowiskową
  if [[ -n ${EWW_AC_OVERRIDE-} ]]; then
    printf 'ac:%s' "$EWW_AC_OVERRIDE"; return 0
  fi

  shopt -s nullglob
  for d in /sys/class/power_supply/*; do
    [[ -r "$d/type" ]] || continue
    case "$(cat "$d/type")" in
      Mains)   mains="$d" ;;
      Battery) bat="$d" ;;
    esac
  done
  shopt -u nullglob

  if [[ -n $mains && -r "$mains/online" ]]; then
    local v; v=$(cat "$mains/online" 2>/dev/null || echo "")
    s="ac:$([[ $v == 1 ]] && echo on || echo off)"
  fi
  if [[ -n $bat && -r "$bat/capacity" ]]; then
    local p; p=$(cat "$bat/capacity" 2>/dev/null || echo "")
    [[ -n $p ]] && s="${s} • bat:${p}%"
  fi

  if [[ $s == ac:n/a ]] && command -v upower >/dev/null 2>&1; then
    local lp; lp=$(upower -e 2>/dev/null | grep -m1 line_power || true)
    if [[ -n $lp ]]; then
      local on; on=$(upower -i "$lp" 2>/dev/null | awk -F: '/online/{gsub(/[[:space:]]/,"",$2);print $2;exit}')
      [[ $on == yes ]] && s="ac:on" || [[ $on == no ]] && s="ac:off"
    fi
    local bp; bp=$(upower -e 2>/dev/null | grep -m1 battery || true)
    if [[ -n $bp ]]; then
      local pct; pct=$(upower -i "$bp" 2>/dev/null | awk -F: '/percentage/{gsub(/%|[[:space:]]/,"",$2);print $2;exit}')
      [[ -n $pct ]] && s="${s} • bat:${pct}%"
    fi
  fi

  if [[ $s == ac:n/a ]] && command -v acpi >/dev/null 2>&1; then
    local a; a=$(acpi -a 2>/dev/null | awk -F: '{gsub(/[[:space:]]/,"");print $2}')
    case "$a" in on-line) s="ac:on";; off-line) s="ac:off";; esac
    local b; b=$(acpi -b 2>/dev/null | awk -F, '{gsub(/[[:space:]]/,"");print $2;exit}')
    [[ -n $b ]] && s="${s} • bat:${b%%%}"
  fi

  printf '%s' "$s"
}
eww_shell(){ printf 'bash:%s' "${BASH_VERSION%%(*}"; }
