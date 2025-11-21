---
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🪝 hooks — kontrola jakości Git"






---

# 🪝 hooks — kontrola jakości Git

> [!TIP] Jak aktywować?
> Skopiuj wybrane pliki z `hooks/` do `.git/hooks/` (np. `cp hooks/pre-push .git/hooks/pre-push && chmod +x .git/hooks/pre-push`). Dzięki temu każdy `git push` wykona niezbędne testy/linty.

## 🧭 Zakres folderu
- Hooki przed wysyłką (`pre-push`).
- Miejsce na przyszłe `pre-commit`, `commit-msg` itd.

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik wykonywalny | `pre-push` | Hook uruchamiany przed `git push` – miejsce do dodania testów, lintów i kontroli wersjonowania. |

## ⚙️ Kluczowe funkcje
1. **Automatyczne sanity-checki** – wymusza wykonanie testów przed publikacją.
2. **Spójność zespołu** – wszyscy używają tego samego hooka zamiast własnych konfiguracji.
3. **Łatwe rozszerzenia** – skrypt można bezpiecznie rozbudować o kolejne kroki QA.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [config/pre-commit.yaml](../config/pre-commit.yaml)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)
- [config/pre-commit.yaml](../config/pre-commit.yaml)



## 🔗 Powiązane dokumenty

- [[hooks/hooks|hooks]]
- [[docs/INDEX|INDEX]]

**Auto-linked:** 2025-11-21

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

*Brak podfolderów.*

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

