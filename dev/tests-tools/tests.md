---
version: 0.0.3
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
  - #testing
created: 2025-11-21
modified: 2025-11-24
author: jakubc
title: "🧪 tests — automaty QA"






owner: jakubc
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