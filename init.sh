#!/usr/bin/env bash
cd /git/eww 2>/dev/null || cd /git/eww.git 2>/dev/null || { echo "ERR: missing /git/eww(.git)"; exit 0; }
echo "cwd: $(pwd)"
${SHELL:-/bin/bash}
