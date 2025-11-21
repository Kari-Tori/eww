---
title: "🪝 hooks — Git hooki lokalne"
description: "Szablony hooków Git (na razie pre-push) zwiększające kontrolę jakości przed publikacją zmian."
color: purple
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.2.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#1E88E5]git"
  - "[#43A047]quality"
  - "[#E53935]hooks"
  - infra
  - infrastructure
  - devops
sources:
  - path: "../README.md"
    title: "Repo README"
  - path: "../AGENTS.md"
    title: "AGENTS"
backlinks:
  - path: "../INDEX.md"
    title: "Główny indeks"
  - path: "../FULL-INDEX.md"
    title: "Full Index"
  - path: "../eww.md"
    title: "Opis repo"
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

---
**Auto-linked:** 2025-11-21
