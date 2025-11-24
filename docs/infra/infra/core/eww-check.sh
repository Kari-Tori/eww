#!/usr/bin/env bash
# File: core/eww-check.sh
# Author: 
# Created: 
# Updated: 
# Description: Skrypt Bash dla projektu EWW
set -euo pipefail
REQ_FILE="${1:-requirements.md}"
[ -f "$REQ_FILE" ] || { echo "Brak pliku: $REQ_FILE" >&2; exit 2; }

ver_ge(){ [[ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" == "$2" ]]; }
DEFAULT_RX='([0-9]+(\.[0-9]+)+)'

echo "== Sprawdzam wymagania z: $REQ_FILE =="
fail=0
printf "%-12s %-12s %-12s %s\n" "NAME" "REQUIRED" "FOUND" "STATUS"

table_lines=$(awk 'BEGIN{in=0} /^\|/{in=1;print;next} in&&!/^\|/{exit}' "$REQ_FILE" | tail -n +3)
IFS=$'\n'
for line in $table_lines; do
  [[ "${#line}" -lt 5 ]] && continue
  name=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$2);print $2}')
  minv=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$3);print $3}')
  cmd=$( echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$4);print $4}')
  rx=$(  echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$5);print $5}')
  [[ -z "$name" || -z "$minv" || -z "$cmd" ]] && continue
  [[ -z "$rx" ]] && rx="$DEFAULT_RX"
  out="$($cmd 2>&1 || true)"
  if [[ -z "$out" ]]; then printf "%-12s %-12s %-12s %s\n" "$name" "$minv" "n/a" "MISSING"; fail=1; continue; fi
  ver=$(echo "$out" | sed -n -E "s/.*$rx.*/\1/p" | head -n1)
  if [[ -z "$ver" ]]; then printf "%-12s %-12s %-12s %s\n" "$name" "$minv" "n/a" "PARSE_ERR"; fail=1; continue; fi
  if ver_ge "$ver" "$minv"; then
    printf "%-12s %-12s %-12s %s\n" "$name" "$minv" "$ver" "OK"
  else
    printf "%-12s %-12s %-12s %s\n" "$name" "$minv" "$ver" "TOO_OLD"; fail=1
  fi
done
exit "$fail"
