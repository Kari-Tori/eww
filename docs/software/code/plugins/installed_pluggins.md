---
version: 0.0.5
title: "installed_pluggins"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---
title: code_plugins_installed
source: "/home/karinam/git/eww/docs/software/code/plugins (konfiguracja lokalna)"
generated: 2025-11-18
description: Automatycznie wygenerowana lista wtyczek z vaulta "code" (skrypt do skopiowania i uruchomienia).
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

Plik "code_plugins_installed" zawiera skrypt, który po skopiowaniu i wklejeniu do terminala wypisze wszystkie zainstalowane wtyczki dla vaulta "code" wraz z numerami wersji i opisami.

Domyślna lokalizacja vaulta "code":
- ~/Obsidian/code
Katalog z wtyczkami (domyślnie):
- ~/Obsidian/code/.obsidian/plugins

Skopiuj cały blok poniżej i wklej do terminala; po uruchomieniu otrzymasz listę zainstalowanych pluginów z wersjami i opisami.

```bash
# filepath: /home/karinam/git/eww/docs/software/code/plugins/code_plugins_installed.md
#!/usr/bin/env bash
set -euo pipefail

# Skrypt listuje zainstalowane wtyczki dla vault: ~/Obsidian/code
# Jeśli vault jest w innym miejscu, podaj ścieżkę jako pierwszy argument.
VAULT_PATH="${1:-$HOME/Obsidian/code}"
PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

if [[ ! -d "$PLUGINS_DIR" ]]; then
  printf "[EWW] Katalog wtyczek nie istnieje: %s\n" "$PLUGINS_DIR" >&2
  exit 1
fi

# Wypisz nagłówek
printf "Wtyczki w: %s\n\n" "$PLUGINS_DIR"

# Dla każdej podkatalogu odczytaj manifest.json (jeśli jest) i wypisz: nazwa (wersja) — opis
shopt -s nullglob
counter=0
for d in "$PLUGINS_DIR"/*; do
  [[ -d "$d" ]] || continue
  ((counter++))
  id="$(basename "$d")"
  manifest="$d/manifest.json"
  name=""
  ver=""
  desc=""

  if [[ -f "$manifest" ]]; then
    if command -v jq >/dev/null 2>&1; then
      name="$(jq -r '.name // empty' "$manifest" 2>/dev/null || true)"
      ver="$(jq -r '.version // empty' "$manifest" 2>/dev/null || true)"
      desc="$(jq -r '.description // empty' "$manifest" 2>/dev/null || true)"
    else
      name="$(grep -oP '\"name\"\s*:\s*\"\K[^\"]+' "$manifest" 2>/dev/null || true)"
      ver="$(grep -oP '\"version\"\s*:\s*\"\K[^\"]+' "$manifest" 2>/dev/null || true)"
      desc="$(grep -oP '\"description\"\s*:\s*\"\K[^\"]+' "$manifest" 2>/dev/null || true)"
    fi
  fi

  [[ -n "$name" ]] || name="$id"
  line="$name"
  [[ -n "$ver" ]] && line+=" ($ver)"
  [[ -n "$desc" ]] && line+=" — $desc"

  printf "%d. %s\n" "$counter" "$line"
done
shopt -u nullglob

if [[ $counter -eq 0 ]]; then
  printf "Brak wykrytych wtyczek w: %s\n" "$PLUGINS_DIR"
fi
```

Sekcja z wynikami zostanie wygenerowana po wklejeniu i uruchomieniu powyższego skryptu w terminalu.

<!-- EWW-PLUGINS-START -->
## Zainstalowane wtyczki (auto-generated)
<!-- EWW-PLUGINS-END -->

## 🔗 Backlinks

- [[INDEX]]
- [[docs]]
- [[README]]