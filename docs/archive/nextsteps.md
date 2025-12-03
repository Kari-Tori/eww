---
version: 0.0.4
title: "nextsteps"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-21T18:00:00Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "Plan działań"






owner: jakubc
created: 2025-11-21T18:00:00Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---



<!--
 * @Author: jakubc vault@local
 * @Date: 2025-11-21 06:15:59
 * @LastEditors: jakubc vault@local
 * @LastEditTime: 2025-11-21 07:22:18
 * @FilePath: /eww/nextsteps.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
title: Następne kroki EWW
description: Skondensowany plan porządkowania repozytorium i przygotowania do kolejnego wydania
version: 0.1.0
updated: 2025-11-22
status: active
language: pl

# Plan działań

Dokument opisuje realne kroki niezbędne, aby zakończyć prace na gałęzi `feat/add-usr-karinam` i przygotować repozytorium do kolejnych releasów. Skupiamy się na trzech obszarach: higiena repozytorium, stabilizacja narzędzi i prace wydawnicze.

## Stan bieżący (skrót)
- Dużo zmian roboczych (`git status` pokazuje kilkadziesiąt plików M/D/??), brak czystego punktu wyjścia do testów.
- `usr/karinam/` jest usuwany, ale w repo pozostają prywatne artefakty (`?`, `ysinfo(){`, `karta 2: ...`, `alsa_output...`).
- Do repo dodano własne hooki Git (`.githooks/*`) i nowe workflowy GitHub Actions; brak integracji w dokumentacji.
- `AGENTS.md`, `README.md` i `CHANGELOG.md` mają otwarte zmiany, które trzeba doprowadzić do spójnej historii.

## Priorytet 1 – Higiena repozytorium (0–2 dni)
- [ ] Usunąć pliki-artefakty z katalogu głównego (`?`, `ysinfo(){`, `karta 2: NVidia_1...`, `alsa_output.pci-0000_**.hdmi-surround-ex`).
- [ ] Wyczyścić duplikaty rozszerzeń (`init-eww (1).sh`, `eww-banner (1).sh`, kopie `.pre-commit-config (1).yaml`).
- [ ] Zakończyć przenoszenie/wycinanie `usr/karinam/` i dodać do repo opis, że katalog `usr/` jest tylko przykładem (README + .gitignore dla prywatnych danych).
- [ ] Dodać do `.gitignore` katalogi generowane (`logs/`, `node_modules/` jeśli potrzebne, archiwa tymczasowe) i wyczyścić istniejące duże pliki z historii roboczej.
- [ ] Upewnić się, że `.gitattributes` i `.githooks/*` są opisane w `docs/` (np. krótkie HOWTO jak instalować hooki lokalnie).
- [x] **Zaimplementować `business/` i `reports/`** - skopiowano z `inbox/e-waste_workshop_vault/` (2025-11-21)

## Priorytet 2 – Stabilizacja narzędzi (2–5 dni)
- [ ] Przejrzeć `init-eww.sh` oraz biblioteki w `lib/`, usunąć zależności od usuwanych katalogów użytkowników i dodać testy BATS w `tests/` dla głównych funkcji.
- [ ] Zsynchronizować dokumentację (README, dev/README, docs/*) z aktualnym zestawem narzędzi w `bin/` i `scripts/`.
- [ ] Zweryfikować nowe workflowy (`.github/workflows/generate-*.yml`, `repo-contract.yml`) i dopisać wymagane sekcje w `docs/infra/`.
- [ ] Uporządkować `Makefile`: dodać cele do instalacji hooków, czyszczenia logów oraz sprawdzania wersji (`VERSION`, `package.json`).

## Priorytet 3 – Przygotowanie wydania (po uporządkowaniu)
- [ ] Zamknąć TODO w AGENTS/README/CHANGELOG i zaktualizować numer wersji (`VERSION`, frontmatter w dokumentach). 
- [ ] Dodać minimalny pipeline CI (lint + bats) jeżeli workflowy wymagają artefaktów.
- [ ] Wykonać testową instalację na czystym profilu użytkownika (`projects/init/init-eww.sh` + `bats tests/`).
- [ ] Przygotować draft notki wydawniczej (fragment do CHANGELOG + `docs/release-0.0.0.x.md`).

## Checklist operacyjny

### Dziś
- [ ] `rg -0 "\?( |$)" -l .` albo `find . -maxdepth 1 -type f -regex ".*[^A-Za-z0-9._-].*"` → usunięcie plików-artefaktów.
- [ ] `git status -sb` → przejrzeć i posprzątać zmiany w `usr/` oraz w dokumentacji.
- [ ] `npm prune` lub `rm -rf node_modules && npm install` (jeśli katalog jest potrzebny lokalnie).

### Ten tydzień
- [ ] `bats tests/` → dodać/uruchomić po uzupełnieniu testów.
- [ ] `shellcheck bin/* lib/**/*.sh` → wychwycić regresje po czyszczeniu.
- [ ] Przygotować opis konfiguracji hooków i workflowów w `docs/narzedzia-deweloperskie.md`.

### Ten miesiąc
- [ ] Zaplanować wydanie `0.0.0.5` (albo `0.1.0`) po potwierdzeniu, że czysta instalacja działa.
- [ ] Rozszerzyć testy o scenariusze init + upgrade (`tests/test_init*.bats`).
- [ ] Zdefiniować politykę backupów/logów (`archive/`, `logs/`) i dodać odpowiednie zadania do `Makefile`.

## Komendy pomocnicze
```bash
# Lista niepożądanych plików i katalogów w katalogu głównym
find . -maxdepth 1 -type f | grep -vE "^(\./(README|nextsteps|Makefile|VERSION|CHANGELOG|docs|bin|lib|scripts))"

# Instalacja lokalnych hooków (po opisaniu w dokumentacji)
rsync -a .githooks/ .git/hooks/

# Kompletny status zmian
git status -sb && git diff --stat
```

## Uwagi końcowe
- Każdą większą zmianę dokumentujemy w `CHANGELOG.md` oraz aktualizujemy `VERSION`.
- Po posprzątaniu repo warto utworzyć snapshot `git tag pre-cleanup/$(date +%Y%m%d)` na wypadek konieczności odtworzenia danych.
- Dokument aktualizujemy po zamknięciu każdego priorytetu, żeby utrzymać jedną listę zadań na repozytorium.