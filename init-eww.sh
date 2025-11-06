#!/usr/bin/env bash
set -Eeuo pipefail

info(){ printf 'EWW: INFO: %s\n' "$*"; }
pass(){ printf 'EWW: PASS: %s\n' "$*"; }
fail(){ printf 'EWW: FAIL: %s\n' "$*" >&2; }
run(){ local label="$1"; shift; if "$@"; then pass "$label"; else fail "$label"; [[ "${STRICT:-0}" = "1" ]] && exit 1; fi; }

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT"
info "Start inicjalizacji w $ROOT"

# 0) sanity
mkdir -p "$ROOT/eww" "$ROOT/scripts" "$ROOT/logs"

# 1) init.sh (opcjonalnie)
if [[ -x "$ROOT/init.sh" ]]; then
  run "init.sh" "$ROOT/init.sh"
else
  info "pomijam init.sh (brak/nie-wykonywalny)"
fi

# 2) eww-index.sh (stwórz stub jeśli brak)
if [[ ! -x "$ROOT/scripts/eww-index.sh" ]]; then
  cat > "$ROOT/scripts/eww-index.sh" <<'STUB'
#!/usr/bin/env bash
set -Eeuo pipefail
R="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
mkdir -p "$R/eww"
T="$R/eww/index.md"
[[ -f "$T" ]] || cat > "$T" <<'MD'
# E-Waste Workshop — Start
- Wejście operacyjne.
MD
echo "OK: $T"
STUB
  chmod +x "$ROOT/scripts/eww-index.sh"
fi
run "eww-index.sh" "$ROOT/scripts/eww-index.sh"

# 3) manifest-check (soft)
if [[ -x "$ROOT/scripts/eww_check_paths.sh" && -f "$ROOT/eww-manifest.yml" ]]; then
  if CHECK_PATHS=0 "$ROOT/scripts/eww_check_paths.sh" "$ROOT/eww-manifest.yml"; then
    pass "manifest-check soft"
  else
    info "manifest-check: ostrzeżenia (soft)"
  fi
else
  info "pomijam manifest-check (brak skryptu/manifestu)"
fi

# 4) git status
info "git status"
( cd "$ROOT" && git status -s ) || true

# 5) open index (opcjonalnie)
if [[ "${OPEN_INDEX:-1}" = "1" ]]; then
  T="$ROOT/eww/index.md"
  for cmd in "xdg-open" "code -g" "kate" "gedit" "nano"; do
    if command -v ${cmd%% *} >/dev/null 2>&1; then
      ( eval "$cmd \"$T\"" >/dev/null 2>&1 & ) || true
      pass "open: $cmd"
      break
    fi
  done
fi

pass "Init complete"
