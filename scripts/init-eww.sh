#!/usr/bin/env bash
set -Eeuo pipefail
say(){ printf '== %s ==\n' "$*"; }
pass(){ printf '[PASS] %s\n' "$*\n"; }
fail(){ printf '[FAIL] %s\n' "$*\n"; }
note(){ printf '[N] %s\n' "$*\n"; }
hard(){ [[ "${STRICT:-0}" = "1" ]] && exit 1 || exit 0; }

say "Rozpoczynam inicjalizację systemów"
say "Uruchamiam Protokół Init: /git/eww/init.sh"
if /git/eww/init.sh; then pass "init.sh"; else fail "init.sh"; hard; fi

say "Generuję plik index: /git/eww/scripts/eww-index.sh"
if /git/eww/scripts/eww-index.sh; then pass "eww-index.sh"; else fail "eww-index.sh"; hard; fi

# Soft manifest-check jeżeli dostępny
if [[ -x /git/eww/scripts/eww_check_paths.sh && -f /git/eww/eww-manifest.yml ]]; then
  say "manifest-check (soft)"
  if ( cd /git/eww; CHECK_PATHS=0 scripts/eww_check_paths.sh eww-manifest.yml ); then
    pass "manifest-check soft"
  else
    note "manifest-check: ostrzeżenia"
  fi
else
  note "pomijam manifest-check (brak skryptu/manifestu)"
fi

# Git status
say "git status"
( cd /git/eww; git status -s || true )

# Otwórz index w edytorze (opcjonalnie)
if [[ "${OPEN_INDEX:-1}" = "1" ]]; then
  TARGET="/git/eww/eww/index.md"
  for cmd in "xdg-open" "code -g" "kate" "gedit" "nano"; do
    if command -v ${cmd%% *} >/dev/null 2>&1; then
      ( eval "$cmd \"$TARGET\"" >/dev/null 2>&1 & ) || true
      pass "open: $cmd"
      break
    fi
  done
fi

pass "Init complete"
exit 0
