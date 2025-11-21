---
title: Code Plugins Installed
description: 🧩 code_plugins_installed — lista wtyczek dla vaulta "code"
type: file
category: docs
filepath: docs/software/code/plugins/code_plugins_installed.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - ide
  - markdown
  - vscode
  - docs
  - knowledge
keywords:
  - editor
  - ide
  - vscode
aliases:
related:
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/software/code/plugins/code_plugins_installed.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# 🧩 code_plugins_installed — lista wtyczek dla vaulta "code"

> Krótki skrypt do szybkiej inwentaryzacji zainstalowanych wtyczek Obsidian dla vaulta "code".  
> Domyślny vault: /home/karinam/Obsidian/code  
> Katalog wtyczek: /home/karinam/Obsidian/code/.obsidian/plugins

## ✨ Co otrzymasz
- Numerowaną listę wtyczek z ikonami: 🧩 (nazwa), 🔖 (wersja), 📝 (opis).
- Możliwość wklejenia skryptu bezpośrednio do terminala.
- Opcję --embed aby automatycznie wstawić wynik do tego pliku między markerami.

---

## ▶️ Szybkie uruchomienie
1. Skopiuj cały blok "Skrypt" i wklej do terminala — otrzymasz wypisane wtyczki.  
2. Aby użyć innego vaulta: podaj ścieżkę jako pierwszy argument.  
   Przykład:
   bash -c '<wklejony skrypt>' /ścieżka/do/vault
3. Aby nadpisać tę sekcję wynikami automatycznie dodaj flagę --embed:
   - Po wklejeniu i uruchomieniu: ./script.sh --embed
   - Lub: ./script.sh /ścieżka/do/vault --embed

---

## 🧾 Skrypt (skopiuj i wklej do terminala)
````bash
#!/usr/bin/env bash
set -euo pipefail

# Użycie:
#   paste i Enter -> wypisze listę pluginów dla domyślnego vaulta
#   ./script.sh /ścieżka/do/vault       -> użyj innego vaulta
#   ./script.sh --embed                 -> wypisz i wstaw wyniki do tego pliku
#   ./script.sh /ścieżka --embed        -> użyj ścieżki i wstaw do pliku
#
# Domyślny vault: /home/karinam/Obsidian/code
# Plik doc do nadpisania (jeśli --embed): /home/karinam/git/eww/docs/software/code/plugins/code_plugins_installed.md

EWW_DOC="/home/karinam/git/eww/docs/software/code/plugins/code_plugins_installed.md"
DEFAULT_VAULT="/home/karinam/Obsidian/code"

# Parse args
EMBED=0
VAULT_PATH="$DEFAULT_VAULT"
for a in "$@"; do
  case "$a" in
    --embed) EMBED=1 ;;
    --help|-h) echo "Użycie: [VAULT_PATH] [--embed]"; exit 0 ;;
    *)
      # jeśli nie flaga i nie ustawiony jeszcze jako vault (pierwszy nie-flaga)
      if [[ "$VAULT_PATH" == "$DEFAULT_VAULT" ]]; then
        VAULT_PATH="$a"
      fi
      ;;
  esac
done

PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

if [[ ! -d "$PLUGINS_DIR" ]]; then
  printf "[EWW] Katalog wtyczek nie istnieje: %s\n" "$PLUGINS_DIR" >&2
  exit 1
fi

# Odczyt pola z manifest.json; użyj jq jeśli dostępne, fallback sed
eww::read_manifest_field() {
  local manifest="$1"
  local field="$2"
  if [[ ! -f "$manifest" ]]; then
    printf ""
    return 0
  fi
  if command -v jq >/dev/null 2>&1; then
    jq -r --arg f "$field" '.[$f] // empty' "$manifest" 2>/dev/null || true
  else
    sed -nE "s/^[[:space:]]*\"$field\"[[:space:]]*:[[:space:]]*\"([^\"]*)\".*$/\1/p" "$manifest" 2>/dev/null || true
  fi
}

# Zbierz listę pluginów (markdown-friendly)
gather_plugins_md() {
  local lines=()
  shopt -s nullglob
  local counter=0
  for d in "$PLUGINS_DIR"/*; do
    [[ -d "$d" ]] || continue
    ((counter++))
    local id="$(basename "$d")"
    local manifest="$d/manifest.json"
    local name ver desc
    name="$(eww::read_manifest_field "$manifest" "name" || true)"
    ver="$(eww::read_manifest_field "$manifest" "version" || true)"
    desc="$(eww::read_manifest_field "$manifest" "description" || true)"
    [[ -n "$name" ]] || name="$id"
    local line="- 🧩 ${name}"
    [[ -n "$ver" ]] && line+=" 🔖 ${ver}"
    [[ -n "$desc" ]] && line+=" — 📝 ${desc}"
    lines+=("$line")
  done
  shopt -u nullglob

  if [[ ${#lines[@]} -eq 0 ]]; then
    printf "Brak wykrytych wtyczek w: %s\n" "$PLUGINS_DIR"
    return 0
  fi

  for l in "${lines[@]}"; do
    printf "%s\n" "$l"
  done
}

# Wypisz nagłówek i nazwy
printf "Wtyczki w: %s\n\n" "$PLUGINS_DIR"
gather_plugins_md | tee /dev/stdout > /tmp/eww_code_plugins_list.txt

# Jeśli --embed, wstaw sekcję między markerami w pliku doc
if [[ $EMBED -eq 1 ]]; then
  START="<!-- EWW-PLUGINS-START -->"
  END="<!-- EWW-PLUGINS-END -->"
  new_section="$START"$'\n'"## Zainstalowane wtyczki (auto-generated) 🧩"$'\n\n'
  new_section+="$(cat /tmp/eww_code_plugins_list.txt)"$'\n'
  new_section+="$END"$'\n'
  if grep -q "$START" "$EWW_DOC" 2>/dev/null; then
    awk -v s="$START" -v e="$END" -v ns="$new_section" '
      BEGIN{inside=0}
      {
        if(index($0,s)){ print ns; inside=1; next }
        if(index($0,e)){ inside=0; next }
        if(inside==0){ print $0 }
      }' "$EWW_DOC" > "$EWW_DOC.tmp" && mv "$EWW_DOC.tmp" "$EWW_DOC"
    printf "[EWW] Zaktualizowano sekcję w: %s\n" "$EWW_DOC"
  else
    printf "%s\n\n%s\n" "$new_section" >> "$EWW_DOC"
    printf "[EWW] Dodano sekcję do: %s\n" "$EWW_DOC"
  fi
fi
````

---

## 📋 Przykładowy wynik
1. 🧩 Obsidian Git 🔖 0.12.3 — 📝 Integracja Git dla Obsidian  
2. 🧩 Templater 🔖 1.30.0 — 📝 Dynamiczne szablony  
3. 🧩 Dataview 🔖 0.5.0 — 📝 Raporty i zapytania

> Sekcja wyników jest wstawiana między markerami:
> <!-- EWW-PLUGINS-START --> … <!-- EWW-PLUGINS-END -->

---

## ⚙️ Wskazówki
- Jeśli masz `jq` — skrypt odczyta JSON poprawniej.  
- Możesz zapisać wynik do pliku: ./script.sh > code_plugins_list.md  
- Aby automatycznie aktualizować dokumentację użyj `--embed` lub skonfiguruj wcześniej utworzone workflow/systemd.

<!-- EWW-PLUGINS-START -->
## Zainstalowane wtyczki (auto-generated) 🧩
<!-- EWW-PLUGINS-END -->
