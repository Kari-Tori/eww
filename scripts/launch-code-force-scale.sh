#!/usr/bin/env bash
# eww-launch-code-force-scale - Uruchom VS Code z wymuszonym współczynnikiem skalowania
set -euo pipefail

# Ustawienia - wymusza ~90% (0.9) przez flagę Electron
readonly FORCE_SCALE="0.9"

usage() {
  cat <<EOF
Użycie: launch-code-force-scale.sh [--] [<vscode-args>...]

Uruchamia Visual Studio Code (kod) z flagą Electron --force-device-scale-factor=${FORCE_SCALE}
Przykład:
  ./scripts/launch-code-force-scale.sh --new-window

Uwagi:
- Skrypt nie zmienia ustawień użytkownika. Wymuszenie działa tylko dla procesu uruchamianego przez ten skrypt.
EOF
}

if [[ "${1-}" == "-h" || "${1-}" == "--help" ]]; then
  usage
  exit 0
fi

# Znajdź polecenie 'code' - dopuszcza kilka nazw
if command -v code >/dev/null 2>&1; then
  CODE_CMD="code"
elif command -v code-insiders >/dev/null 2>&1; then
  CODE_CMD="code-insiders"
else
  echo "[EWW] Nie znaleziono polecenia 'code' ani 'code-insiders' w PATH." >&2
  echo "Zainstaluj VS Code i upewnij się, że polecenie 'code' jest dostępne." >&2
  exit 2
fi

exec "$CODE_CMD" --force-device-scale-factor=${FORCE_SCALE} "$@"
