---
title: PLAN PORZADKOWANIA
description: Plan porządkowania repozytorium
type: file
category: docs
filepath: docs/PLAN-PORZADKOWANIA.md
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
  - markdown
  - docs
  - knowledge
keywords:
aliases:
  - PLAN_PORZADKOWANIA
related:
  - dev/Development.md
  - docs/docs.md
  - scripts/scripts.md
dependencies:
sources:
  - docs/PLAN-PORZADKOWANIA.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# Plan porządkowania repozytorium

Repozytorium `eww` łączy w sobie narzędzia CLI, automatyzację konfiguracji systemu, dokumentację oraz prywatny knowledge-base. Poniższe zestawienie opisuje warstwy projektu i sugeruje konkretne działania porządkujące.

## 1. Warstwy i odpowiedzialności

| Warstwa | Kluczowe katalogi/pliki | Obecny stan | Działania porządkujące |
| --- | --- | --- | --- |
| CLI i biblioteki | `bin/`, `lib/`, `scripts/`, `dev/bin/`, `core/` | Skrypty CLI są rozproszone po kilku katalogach, część ma zdublowane nazwy (`eww-banner` w `bin/` i `scripts/`). Biblioteki w `lib/` są kompletne, ale brak im spójnego README/opisu. | 1) Zdefiniować jasny podział: `bin/` – tylko narzędzia użytkownika, `scripts/` – helpery instalacyjne, `dev/bin/` – narzędzia developera. 2) Opisać każdą bibliotekę w `lib/README.md` (lista funkcji + przykłady). 3) Usunąć duplikaty (`eww-banner (1).sh` itp.) i wprowadzić wersjonowanie przez `scripts/eww-*.sh`. |
| Inicjalizacja systemu | `init-eww.sh`, `projects/init/`, `systemd/`, `infra/ansible/`, `core/installers/` | Istnieje wiele ścieżek inicjalizacji (skrypty idempotentne, playbooki Ansible, jednostki systemd). Dokumentacja rozbita na `README.md`, `AGENTS.md` i notatki w `projects/e-waste-workshop`. | 1) Utworzyć centralny dokument „Init Pipeline” w `docs/` opisujący kolejność: `init-eww.sh` → `projects/init/...` → `systemd/`. 2) W plikach `.service` wskazać aktualne ścieżki (`/git/eww` vs `/jakubc/git/eww`). 3) Zmapować zależności Ansible (`infra/`) i określić czy są aktywne. |
| Dokumentacja i indeksy | `README.md`, `AGENTS.md`, `INDEX.md`, `FULL-INDEX.md`, `docs/`, `Makefile` (targety `index`, `frontmatter`) | Dokumentacja jest bogata, ale powiela informacje (np. spisy katalogów w kilku plikach). `INDEX.md` generowany ręcznie/sporadycznie. | 1) Wprowadzić cykl `make index` + commit co większą zmianę. 2) Dodać do `docs/` wykaz ważnych przewodników (np. `Development.md`, `dev/README`). 3) Oznaczyć w `README.md` sekcję odsyłającą do nowego planu porządkowania. |
| Projekty, biznes, wiedza | `business/`, `usr/`, `Tags/`, `logs/`, `projects/e-waste-workshop/` | `usr/` zawiera notatki osobiste (`TODO`, `workspace`), `business/` i `Tags/` są mało opisane. Brakuje jednolitego indeksu knowledge-base. | 1) W `usr/README.md` utworzyć index użytkowników i ich workspace. 2) Wprowadzić konwencję frontmatter (obecna w wielu plikach) do wszystkich `TODO`. 3) Zbudować `docs/knowledge-index.md` odsyłający do `business/`, `Tags/`, `usr/`. |
| Rozwój i testy | `dev/` (Playbooks, Projects, tests), `tests/` (BATS), `site/`, `tools/`, `core/tests` | Testy są rozproszone; `tests/` zawiera BATS, a `dev/tests` dodatkowe szkice. `site/` oraz `tools/` nie mają aktualnego opisu. | 1) Spiąć testy przez jeden target (`make test` → BATS + eksperymenty). 2) Dodać `docs/testing.md` z opisem uruchamiania. 3) W `dev/README.md` dopisać status poszczególnych projektów/podfolderów. |

## 2. Priorytety porządkowe

### 2.1 CLI i biblioteki
- **Audyt katalogów `bin/`, `scripts/`, `dev/bin/`:** zbudować listę narzędzi (np. `eww-status`, `eww-commit`, `eww-banner`) i przypisać do jednego miejsca. Wyróżnić, które są częścią dystrybucji (`install`), a które są tylko narzędziami maintainerskimi.
- **Standaryzacja nagłówków:** w każdym skrypcie `bash` dodać krótką sekcję z opisem, wymaganiami i przykładem wywołania (przykład w `AGENTS.md` – sekcja „Struktura funkcji”).
- **Biblioteki w `lib/`:** przygotować zwięzłe README (lista funkcji + odpowiedzialność). `lib/banner.sh`, `lib/git.sh`, `lib/log.sh`, `lib/sys.sh` powinny mieć opis wejść/wyjść, aby ułatwić użycie w skryptach.

### 2.2 Inicjalizacja i release
- **Dokument „Init Pipeline”:** spisać krok po kroku: `init-eww.sh` → `projects/init/init-eww.sh` → `systemd/` → `make release`. Pozwoli to nowym osobom zrozumieć zależności w jednym miejscu.
- **Systemd + ścieżki:** przejrzeć `systemd/*.service` i upewnić się, że wskazują aktualny katalog (`/jakubc/git/eww` jeśli to nowe repo produkcyjne). Dopisać instrukcje w `systemd/README.md`.
- **Proces wydania:** obecny `Makefile` ma target `release`. Wprowadzić checklistę (np. w `docs/release.md`) opisującą `make changelog-version`, `git tag`, `git push`.

### 2.3 Dokumentacja i indeksy
- **Aktualizacja indeksu:** zautomatyzować `make index` (np. w CI lub jako część release). Uporządkowany `INDEX.md` ograniczy powielanie list w `README.md`.
- **Kanon dokumentów:** w `docs/` zebrać spis istotnych plików (`Development.md`, `dev/README`, `AGENTS.md`, niniejszy plan). Każdy dokument powinien mieć datę aktualizacji i kontakt.
- **Frontmatter:** narzędzia `make frontmatter`/`frontmatter-dry` są gotowe – włączyć je w workflow dla `docs/` i `usr/`, aby spójnie tagować materiały.

### 2.4 Knowledge-base i notatki
- **`usr/README.md`:** rozwinąć plik o listę użytkowników (`jakubc`, `karinam`) z linkami do kluczowych notatek (`workspace`, `TODO-SSH`, `TODO`). Dodać sekcję, jak prowadzić prywatne notatki, by nie mieszać z kodem.
- **`business/` i `Tags/`:** stworzyć w `docs/knowledge-index.md` mapę prowadzącą do najważniejszych katalogów (projekty eBay, SOP, integracje). Pozwoli to łatwo odnaleźć kontekst biznesowy.
- **Logi i archiwa:** rozważyć przeniesienie `archive/` i `logs/` do osobnych repo lub S3, jeśli nie muszą być w głównym drzewie Gita. Jeśli zostają, dodać opis co można usuwać/archiwizować.

### 2.5 Rozwój, testy i automatyzacje
- **Uniwersalny target testów:** przygotować `make test`, który uruchomi BATS z `tests/` oraz ewentualne dodatkowe testy w `dev/tests`. W `README.md` i `docs/testing.md` opisać sposób uruchamiania.
- **`site/` i `tools/`:** dodać krótkie README w każdym katalogu (cel, sposób uruchamiania, status). Aktualnie brakuje informacji czy to aktywne moduły.
- **Integracja TODO-SSH:** nowy `Makefile` posiada cele `sync-*` oraz `todo-*`. Warto spisać w `docs/operations.md` w jaki sposób te cele integrują się z codzienną pracą (np. migracja repo, zadania domowe).

## 3. Checklista operacyjna (do wykonywania cyklicznie)

1. **Codziennie rano:** `make todo` oraz `make todo-ssh` – błyskawiczny podgląd planów osobistych i migracyjnych.
2. **Przed większą zmianą w repo:** `make backup-gerc` → `make prepare-target` → `make sync-dry` → `make sync-run` – zapewnia bezpieczne rsync zarówno z Asus_Z77, jak i ze starego `/git/eww`.
3. **Po synchronizacji:** `make diff-repos` i `make git-verify`, aby mieć raport różnic i potwierdzić historię Gita.
4. **Przed wydaniem:** `make changelog`, `make changelog-update`, `make release VERSION=x.y.z.b` – wszystko opisane w głównym `Makefile`.
5. **Dokumentacja:** `make index` + `make frontmatter FILE=...` – aktualizacja indeksów oraz frontmatter dla nowych notatek.

## 4. Otwarte kwestie i ryzyka

- **Duplikaty skryptów:** pliki z sufiksami `(1).sh` w `scripts/` sugerują konflikty kopiowania; trzeba zdecydować, które wersje są kanoniczne.
- **Ścieżki absolutne:** wiele narzędzi operuje na `/git/eww` albo `/jakubc/git/eww`. Wraz z migracją (zob. `usr/jakubc/TODO-SSH.md`) należy wprowadzić zmienne środowiskowe (np. `EWW_ROOT`) lub automatyczne wykrywanie lokalizacji.
- **Repo prywatne vs publiczne:** katalogi `usr/` i `business/` zawierają wrażliwe dane. Warto zdecydować, czy zostają w repo publicznym, czy powinny zostać odsunięte do submodułu/prywatnego archiwum.
- **CI/CD:** brak automatycznych testów w GitHub Actions. Po uporządkowaniu struktur warto przygotować pipeline (shellcheck + BATS + generatory dokumentacji).

---

Ten plan można traktować jako punkt wyjścia: po wykonaniu każdej sekcji warto odnotować rezultaty w `docs/CHANGELOG` lub w dedykowanym wątku w `usr/jakubc/workspace`. Dzięki temu repo pozostanie czytelne zarówno dla maintainerów, jak i narzędzi AI korzystających z `AGENTS.md`.
