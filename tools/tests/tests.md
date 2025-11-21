---
title: "🧪 tests — Testy BATS"
description: "Zestaw testów automatycznych w Bash Automated Testing System walidujący krytyczne skrypty."
color: orange
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.2.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#1E88E5]tests"
  - "[#43A047]qa"
  - "[#8E24AA]bash"
  - automation
  - tools
  - dev
sources:
  - path: "../README.md"
    title: "Repo README"
  - path: "../AGENTS.md"
    title: "AGENTS"
  - path: "./test_init.bats"
    title: "Test init"
backlinks:
  - path: "../INDEX.md"
    title: "Główny indeks"
  - path: "../FULL-INDEX.md"
    title: "Full Index"
  - path: "../eww.md"
    title: "Opis repo"
---

# 🧪 tests — automaty QA

> [!TIP] Uruchomienie
> Wymagany jest `bats` ≥ 1.8. Zalecane polecenie: `bats tests`. Przed uruchomieniem upewnij się, że `EWW_ROOT` wskazuje aktualne repo.

## 🧭 Zakres folderu
- Testy inicjalizacji (`test_init*.bats`).
- Walidacja listy pluginów i narzędzi (`list_code_plugins.bats`).

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik | `list_code_plugins.bats` | Sprawdza czy generatory pluginów zwracają oczekiwane dane. |
| Plik | `test_idempotency.bats` | Waliduje idempotentne działanie inicjalizatora. |
| Plik | `test_init.bats` | Podstawowy test `init-eww.sh`. |
| Plik | `test_init_behavior.bats` | Scenariusze edge-case dla init (np. brak katalogów). |

## ⚙️ Kluczowe funkcje
1. **Stabilność init** – szybkie wykrywanie regresji w `init-eww.sh`.
2. **Kontrola generatorów** – testy pluginów pilnują spójności dokumentacji.
3. **Regresje** – BATS pozwala na łatwe dodawanie scenariuszy shellowych.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [docs/docs.md](../docs/docs.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)
- [tests/test_init.bats](test_init.bats)

