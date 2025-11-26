---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T22:00:00Z
modified: 2025-11-21T22:00:00Z
author: jakubc
title: "Zalecane ustawienia VS Code dla repozytorium"






owner: jakubc
---

<!-- Instrukcja repozytorium: zalecane ustawienia VS Code dla tego projektu -->
# Zalecane ustawienia VS Code dla repozytorium

W tym repozytorium zalecamy używać ustawienia zoomu interfejsu VS Code:

- `window.zoomLevel`: `-1`  (około 90% — przydatne przy mniejszych ekranach lub gdy chcesz większy obszar roboczy)

Plik `./.vscode/settings.json` w repo zawiera te ustawienia jako ustawienia workspace. Jeśli chcesz, aby to ustawienie było domyślne globalnie (dla wszystkich okien VS Code na Twoim komputerze), wykonaj jedną z poniższych opcji:

1. Ustawienie globalne (User Settings) - GUI
   - Otwórz VS Code
   - Otwórz paletę poleceń (Ctrl+Shift+P) i wpisz: "Preferences: Open User Settings"
   - W polu wyszukiwania wpisz: `window zoom` i ustaw `Window: Zoom Level` na `-1`.

2. Ustawienie globalne (User Settings) - JSON
   - Otwórz paletę poleceń i wybierz: "Preferences: Open User Settings (JSON)"
   - Dodaj/zmień linię:

```jsonc
"window.zoomLevel": -1
```

Uwaga:
- Niektóre instalacje VS Code mogą zaokrąglać wartości ułamkowe zoomLevel do najbliższego obsługiwanego kroku. `-1` to stabilny krok odpowiadający ~90%.
- Jeśli chcesz precyzyjnie wymusić skalę (np. 0.85), uruchamiaj VS Code przez skrypt z flagą Electron: `--force-device-scale-factor=0.85`. W repo był wcześniej przykładowy skrypt `scripts/launch-code-scale.sh` — mogę go przywrócić lub dodać ponownie jeśli chcesz.

Jeśli chcesz wymusić skalę dokładnie na ~90% niezależnie od zaokrągleń `window.zoomLevel`, możesz uruchamiać VS Code przez dołączony skrypt:

```bash
./scripts/launch-code-force-scale.sh [--] [<vscode-args>...]
```

Skrypt uruchamia `code` z flagą Electron `--force-device-scale-factor=0.9` (wymusza ~90%). Uwaga: działa tylko dla procesu uruchamianego przez skrypt i nie modyfikuje globalnych ustawień użytkownika.

Plik ten jest tylko dokumentacją — nie modyfikuje Twoich globalnych ustawień bez Twojej zgody.
