#!/usr/bin/env bash
# File: scripts/bash/eww-banner.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# display
# script
# ui
# eww-banner.sh — kolorowy baner + metryki + fast/neofetch
set -Eeuo pipefail

eww_banner() {
  [[ $- == *i* ]] || return
  [[ -n "${EWW_BANNER_OFF:-}" ]] && return

  local title="${EWW_BANNER_TITLE:-E-Waste Workshop}"
  local width="${EWW_BANNER_WIDTH:-120}"
  local fonts
  # populate fonts array safely from space-separated variable (or fallback list)
  IFS=' ' read -r -a fonts <<< "${EWW_BANNER_FONTS:-big slant standard future pagga shadow}"

  # deterministyczny wybór czcionki: host + dzień roku
  local seed idx font
  seed="$(printf '%s' "$(hostname)$(date +%j)" | cksum | awk '{print $1}')"
  idx=$(( seed % ${#fonts[@]} ))
  font="${fonts[$idx]}"

  banner_text() {
    if command -v toilet >/dev/null; then
      toilet -w "$width" -f "$font" -F border -F metal "$title"
    elif command -v figlet >/dev/null; then
      figlet -w "$width" -f "$font" "$title"
    elif command -v banner >/dev/null; then
      banner "$title"
    else
      printf '\n===== %s =====\n' "$title"
    fi
  }

  sys_line() {
    local up load mem disk
    up="$(uptime -p 2>/dev/null | sed 's/^up //')"
    load="$(cut -d' ' -f1-3 /proc/loadavg)"
    mem="$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    disk="$(df -h / | awk 'NR==2{printf "%s/%s /", $3, $2}')"
    printf 'up:%s • load:%s • mem:%s • disk:%s\n' "${up:-n/a}" "$load" "$mem" "$disk"
  }

  block() {
    if command -v boxes >/dev/null; then
      boxes -d stone -p a1v1
    else
      sed '1s/^/[ /;$s/$/ ]/'
    fi
  }

  if [[ -t 1 ]] && command -v lolcat >/dev/null; then
    banner_text | lolcat
    sys_line | block | lolcat
  else
    banner_text
    sys_line | block
  fi

  if command -v fastfetch >/dev/null; then fastfetch
  elif command -v neofetch >/dev/null; then neofetch
  fi
}

# alias ręczny
alias ewwbanner='eww_banner'
