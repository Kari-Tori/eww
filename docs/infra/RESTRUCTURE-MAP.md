---
tags:
  - #docs
  - #structure
  - #eww
  - #plan
created: 2025-11-24T00:00:00Z
author: jakubc & codex
title: "Mapa migracji struktury katalogów"
owner: jakubc
---

# Mapa migracji struktury katalogów

Dokument opisuje docelową strukturę repozytorium po sprzątaniu. Pokazuje, które katalogi należy przenieść, jakie nowe foldery tworzymy oraz jakie działania wykonujemy przy okazji.

## Docelowe warstwy

1. `business/` – wiedza domenowa, procesy, governance, backlog.
2. `development/` – warsztat deweloperski, narzędzia, projekty i testy.
3. `docs/infra/` – dokumentacja infrastruktury i operacji (pozostałe działy wychodzą z `docs/`).
4. `core/` – konfiguracje i runtime repo (SOP, systemd, Makefile).
5. `users/` (obecne `usr/`) – prywatne workspace użytkowników + indeks.

## Mapa przenosin

| Priorytet | Źródło | Docelowy katalog | Działanie |
|-----------|--------|------------------|-----------|
| 1 | ~~`docs/governance/`~~ | `business/governance/` | ✅ przeniesione 2025-11-24 — pozostało odświeżyć odnośniki (`dev/INDEX.md`, `docs/FULL-INDEX.md`). |
| 1 | ~~`docs/methodologies/`~~ | `business/methodologies/` | ✅ przeniesione 2025-11-24 — sprawdzić folder note (`business/methodologies/methodologies.md`) i linki. |
| 1 | ~~`docs/infra/references/proces*` + `docs/infra/references/vendor.md`~~ | `business/processes/` / `business/vendors/` | ✅ przeniesione 2025-11-24 — pozostało kategoryzowanie podfolderów i linki cross-reference. |
| 1 | `docs/archive/04_TEAM/` + `docs/archive/Idea/` | `business/archive/` | zachować historię zespołów, dodać index. |
| 2 | `dev/` (całość) | `development/` | rename katalogu + ujednolicony README (narzędzia, tests, playbooks). |
| 2 | `scripts/` + `dev/scripts/` | `development/tools/automation/` | rozdzielić: `development/bin/` (skróty), `development/automation/` (batch). |
| 2 | `dev/tests/`, `tests/`, `tests-tools/` | `development/tests/` | jeden katalog testowy + opis targetów w Makefile. |
| 3 | ~~`docs/graphs/`~~ | `docs/infra/graphs/` | ✅ przeniesione 2025-11-24 — traktować graf jako komponent infra (monitoring repo). |
| 3 | `docs/infra/site/` + `docs/infra/software/obsidian/` | `development/site/` i `development/obsidian/` | to warsztatowe narzędzia, nie dokumentacja infra. |
| 3 | `core/systemd/`, `core/tasks/`, `core/reports/` | `core/runtime/` | trzy podfoldery + README tłumaczące przepływ. |
| 3 | `core/bashrc.eww.snippet`, `core/gitconfig.repo`, `core/pre-commit.yaml` | `core/config/` | pliki dotfiles w jednym miejscu. |
| 4 | `usr/` | `users/` | rename, upewnić się, że `.gitignore` nadal chroni prywatne dane. |
| 4 | `usr/*/INDEX.md` | `users/*/README.md` | utrzymać indeksy użytkowników, dodać linki do `business/` jeśli współdzielą materiały. |
| 5 | `docs/archive/03_DEVELOPMENT/` | `development/archive/` | dokumenty historyczne dev, żeby odseparować od bieżącej wiedzy biznesowej. |

## Kolejność prac

1. **Przygotowanie** – zaktualizować `dev/INDEX.md` oraz główny `TODO` z linkiem do tej mapy (gotowe). Sprawdzić, czy `Makefile` ma targety wspierające przenosiny (np. `make index`).
2. **Business wave** – utworzyć podkatalogi `business/governance`, `business/methodologies`, `business/processes`, `business/vendors`, `business/archive`. Przenieść pliki wg. tabeli i poprawić odnośniki.
3. **Development wave** – rename `dev/` → `development/`. Zaktualizować importy w skryptach/README oraz w `Makefile`.
4. **Infra wave** – przesunąć grafy, site i obsidian do właściwych miejsc; `docs/` pozostawić głównie dla infrastruktury (architektura, hardware, ansible).
5. **Core + users wave** – posprzątać `core/` (config/runtime) i przechrzcić `usr/` na `users/` wraz z README w każdym katalogu użytkownika.
6. **Finalizacja** – wykonać `make index` i `make frontmatter-dry` dla nowych ścieżek, zaktualizować `docs/FULL-INDEX.md` oraz `docs/governance/PLAN-PORZADKOWANIA.md` (sekcja statusu).

## Wymagane README / indeksy

- `business/README.md` (istnieje) – dodać listę podkatalogów.
- `business/governance/README.md`, `business/methodologies/README.md`, `business/processes/README.md`.
- `development/README.md` – nowa struktura warsztatu, kroki build/test.
- `core/README.md` – opis podziału config/runtime.
- `users/README.md` – indeks użytkowników (`jakubc`, `karinam`, `gary`) + zasady prywatności.
- Aktualizacja `dev/INDEX.md` i `docs/index.md` (kiedy przenosiny się zakończą).

## Notatki dodatkowe

- Podczas przenosin utrzymuj frontmatter (tagi, daty). Skrócone ścieżki w innych plikach najlepiej poprawiać przez `rg -l 'docs/governance'`.
- `docs/infra/site/` zawiera artefakty statyczne – warto oznaczyć je jako build-output i ewentualnie wydzielić do `development/site/` lub osobnego repo.
- `docs/infra/graphs/` gromadzi teraz największy zbiór plików graficznych; aktualizuj indeks po każdej większej zmianie.
- Po rename `usr/` → `users/` sprawdź `.gitignore` i skrypty (np. `Makefile` target `todo`), aby nowe ścieżki były wykluczone/zaktualizowane.

Ten dokument jest punktem odniesienia do czasu zakończenia porządków. Każdą zmianę warto oznaczać w `docs/infra/reports/CLEANUP-LOG.md` oraz dopisać krótką notkę w `business/CHANGELOG-business.md` (jeśli taki powstanie).
