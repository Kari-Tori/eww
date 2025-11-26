---
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T13:00:00Z
modified: 2025-11-21T13:00:00Z
author: jakubc
title: "🧩 lib — katalog funkcji Bash"






owner: jakubc
---



# 🧩 lib — katalog funkcji Bash

> [!NOTE] Konwencje
> Każdy plik `.sh` eksportuje funkcje przestrzeni nazw `eww::` lub proste helpery. W skryptach należy go importować przez `. "$EWW_ROOT/lib/<plik>.sh"` z zachowaniem `set -euo pipefail`.

## 🧭 Zakres folderu
- Biblioteki dla banerów, logowania i operacji Git/systemd.
- Kod współdzielony między `bin/`, `scripts/` i `projects/*`.

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik | `banner.sh` | Funkcje rysujące banery i nagłówki CLI. |
| Folder | `bash/` | Rozszerzenia / moduły Bash (np. aliasy, matchery). |
| Plik | `git.sh` | Helpery Git (logowanie, walidacja repo). |
| Plik | `idempotent.sh` | Narzędzia do pisania idempotentnych operacji. |
| Plik | `log.sh` | Ujednolicone logowanie (`eww::log`, `eww::err`). |
| Plik | `README.md` | Dokumentacja bibliotek. |
| Plik | `sys.sh` | Pomocnicy systemowi (sprawdzanie usług, ścieżek). |

## ⚙️ Kluczowe funkcje
1. **Wspólny styl CLI** – `banner.sh` + `log.sh` zapewniają spójne UI tekstowe.
2. **Bezpieczeństwo operacji** – `idempotent.sh` i `sys.sh` pilnują, aby skrypty nie wykonywały destrukcyjnych działań dwa razy.
3. **Integracja Git** – `git.sh` ułatwia operacje `fetch`, `clean` itp. w całym repo.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [bin/bin.md](../bin/bin.md)

## 📚 Źródła
- [lib/README.md](README.md)
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)

## 📑 Index plików

- [README](README.md)

## 📁 Podfoldery

- [bash/](bash/bash.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

