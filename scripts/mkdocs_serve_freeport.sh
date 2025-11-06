#!/usr/bin/env bash
set -Eeuo pipefail
port(){ for p in $(seq 8000 8999); do ss -ltn 2>/dev/null | grep -q ":$p " || { echo "$p"; return; }; done; }
P="$(port)"; echo "http://127.0.0.1:$P"
exec mkdocs serve -a 127.0.0.1:"$P"
