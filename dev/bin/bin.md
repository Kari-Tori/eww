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
title: "🧰 bin — katalog skryptów CLI"






owner: jakubc
---



# 🧰 bin — katalog skryptów CLI

> [!TIP] Jak korzystać?
> Po dodaniu `/git/eww/bin` do `PATH` możesz uruchamiać komendy `eww-*` bezpośrednio w terminalu. Większość skryptów służy do szybkich testów, automatycznego generowania banerów lub przygotowywania środowiska.

## 🧭 Zakres folderu
- Publiczne skrypty CLI (szybkie akcje DevOps/obsługi repo).
- Minimalne zależności (czysty Bash + standardowe narzędzia systemowe).
- Interfejsy pomocnicze dla folderów `scripts/` i `systemd/`.

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Skrypt | `eww::baner` | Wrapper ładuje `init-eww.sh`, aby wywołać funkcję `eww_banner` nawet poza skonfigurowaną sesją. |
| Skrypt | `eww-banner` | Minimalny generator baneru z sygnaturą użytkownika/hosta – szybkie powitanie CLI. |
| Skrypt | `eww-cli-filemanagers` | Manager CLI do instalacji/uruchamiania `ranger`, `nnn`, `lf`, `mc`, `broot` z poziomu jednego polecenia. |
| Skrypt | `eww-commit` | Automatyczny commit snapshotu (`git add -A; git commit auto:snapshot ...`). Przydatne przed rsync. |
| Skrypt | `eww-doctor` | Testuje czy `eww_banner` i inicjalizacja repo działają poprawnie (kontrola `EWW_CD_ROOT`). |
| Skrypt | `eww-setup-plugins-monitor` | Konfiguruje monitoring wtyczek Obsidian (`systemd --user`, kopiowanie jednostek i wymuszenie aktualizacji listy pluginów). |
| Skrypt | `eww-status` | Bardzo lekki healthcheck – zwraca `EWW STATUS OK`, przydatny w cron/systemd. |

## ⚙️ Kluczowe funkcje
1. **Szybkie sanity-checki** – `eww-doctor`, `eww-status` i `eww-banner` pozwalają w sekundę potwierdzić, że środowisko działa.
2. **Automaty snapshotowe** – `eww-commit` umożliwia bezpieczne migawki przed większymi refaktorami i synchronizacjami.
3. **Integracje użytkowe** – `eww-cli-filemanagers` i `eww-setup-plugins-monitor` spinają zasoby CLI z plikami Obsidian + systemd.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [docs/README.md](../docs/README.md)

## 📚 Źródła i referencje
- [AGENTS.md](../AGENTS.md) – opisuje ogólną strukturę katalogów.
- [README.md](../README.md) – sekcja „Struktura projektu”.
- [docs/README.md](../docs/README.md) – przewodnik dokumentacyjny, z którego korzystają skrypty CLI.


## 🔗 Powiązane dokumenty

- [[bin/bin|bin]]
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

