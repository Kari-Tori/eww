#!/usr/bin/env bash
# File: dev/scripts/eww-banner.sh
# Author: 
# Created: 
# Updated: 
# Description: compact, stable banner implementation — intentionally small and shellcheck-friendly
# compact, stable banner implementation — intentionally small and shellcheck-friendly
set -o pipefail

: "${EWW_BANNER_PREFIX:=Miłego dnia}"
: "${EWW_REPO:=/git/eww}"
: "${EWW_CFG:=/git/eww/projects/init/init-eww.sh}"

eww_uptime() {
	uptime -p 2>/dev/null | sed 's/^up //;s/,//g' || printf '?'
}

eww_load() {
	awk '{printf "%s %s %s", $1,$2,$3}' /proc/loadavg 2>/dev/null || printf '? ? ?'
}

eww_mem() {
	local mt ma used
	mt=$(grep -m1 '^MemTotal:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
	ma=$(grep -m1 '^MemAvailable:' /proc/meminfo 2>/dev/null | awk '{print $2}' || true)
	if [[ -n $mt && -n $ma ]]; then
		used=$(((mt - ma) / 1024))
		printf '%d/%dMiB' "$used" "$((mt / 1024))"
	else
		printf '?'
	fi
}

eww_home() {
	local path="${HOME:-/}" s
	s=$(df --output=avail "$path" 2>/dev/null | tail -1 | tr -d ' ')
	printf '%s' "${s:-?}"
}

eww_repo() {
	if command -v git >/dev/null 2>&1 && [[ -d "$EWW_REPO/.git" ]]; then
		local b
		b=$(git -C "$EWW_REPO" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')
		printf '%s • br:%s' "$EWW_REPO" "$b"
	else
		printf '%s' "$EWW_REPO"
	fi
}

eww_shell() {
	printf 'bash:%s' "$(printf '%s' "$BASH_VERSION" | cut -d'(' -f1)"
}

eww_banner() {
	local now user host cfg_status
	now="$(date '+%F %T')" || now='?'
	user="$(whoami 2>/dev/null || echo '?')"
	host="$(hostname 2>/dev/null || echo '?')"
	cfg_status=$([[ -r "$EWW_CFG" ]] && echo '[OK]' || echo '[MISS]')

	printf '%s %s\n' "$EWW_BANNER_PREFIX" "$now"
	printf 'up:%s • load:%s • mem:%s • home:%s\n' "$(eww_uptime)" "$(eww_load)" "$(eww_mem)" "$(eww_home)"
	printf 'repo:%s • %s@%s\n' "$(eww_repo)" "$user" "$host"
	printf 'cfg:%s %s\n' "$EWW_CFG" "$cfg_status"
}

alias ewwbanner=eww_banner
