#!/usr/bin/env bash
set -u
REPO="/git/eww"
mkdir -p "$REPO/eww"
TARGET="$REPO/eww/index.md"
if [[ ! -f "$TARGET" ]]; then
  cat > "$TARGET" <<'MD'
# E-Waste Workshop — Start

- Wejście operacyjne.
- Checklisty i zadania.

## Linki
- [[../MkDocs/docs/index.md|Wiki]]
- [[../README.md|README]]
MD
  echo "[PASS] index created: $TARGET"
else
  echo "[PASS] index exists:  $TARGET"
fi
echo "$TARGET"
