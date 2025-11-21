#!/usr/bin/env bash
# File: dev/scripts/version.sh
# Author: 
# Created: 
# Updated: 
# Description: Skrypt Bash dla projektu EWW
set -Eeuo pipefail
latest_tag() { git describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || echo 'v0.0.0'; }
short_sha() { git rev-parse --short HEAD; }
commits_since() { git rev-list "$1"..HEAD --count 2>/dev/null || echo 0; }
t="$(latest_tag)"
b="${t#v}"
n="$(commits_since "$t")"
if [[ "$n" -eq 0 ]]; then echo "$b"; else echo "$b+${n}.g$(short_sha)"; fi
