---
title: 📝 CHANGELOG - E-Waste Workshop
description: Historia zmian projektu w formacie Keep a Changelog
version: 0.0.0.4
type: changelog
status: active
tags:
  - main
  - eww
  - core
  - changelog
  - history
  - releases
  - semver
author: jakubc
created: 2025-11-21
updated: 2025-11-21
format: Keep a Changelog
versioning: Semantic Versioning
backlinks:
  - "[[EWW-MAP|🗺️ Repository Map]]"
  - "[[README|📘 README]]"
  - "[[Makefile|⚙️ Makefile]]"
---

# Changelog

Wszystkie istotne zmiany w projekcie będą dokumentowane w tym pliku.

Format oparty na [Keep a Changelog](https://keepachangelog.com/pl/1.0.0/),
projekt używa [Semantic Versioning](https://semver.org/lang/pl/).

## [Unreleased]

## [0.0.0.3] - 2025-11-08

### Added
- MVP release

## [0.0.0.2] - 2025-11-08

### Changed
- Aktualizacja wersji

## [0.0.0.1] - 2025-11-08

### Added
- Skrypt `projects/init/init-eww.sh` (funkcja `eww::init`) — ustawia `EWW_ROOT`, opcjonalnie przechodzi do katalogu projektu, ładuje baner
- `README.md` z instrukcją pobrania i sourcowania skryptu
- Plik `VERSION` ustawiony na `0.0.0.1`
- Podstawowa struktura projektu

## [0.0.0.1-pre] - 2025-11-08

### Added
- Pre-MVP: przygotowanie do pierwszego wydania

## [0.1.0] - 2025-11-07

### Added
- Narzędzia do wersjonowania SemVer
- Podpisane commity GPG
- Bootstrap projektu
- Wiki projektu
- Podstawowy layout Ansible

---

## Zasady wersjonowania

- Plik `VERSION` zawiera aktualny numer wersji w formacie `major.minor.patch.build`
- Używamy [Conventional Commits](https://www.conventionalcommits.org/) w commitach
- Kategorie zmian: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`

## Workflow wydania nowej wersji

```bash
# Wygeneruj changelog z commitów
make changelog

# Zmień wersję w pliku VERSION (np. 0.0.0.4)
echo "0.0.0.4" > VERSION

# Scommituj zmiany
git add VERSION CHANGELOG.md
git commit -m "chore(release): 0.0.0.4"
git tag -a v0.0.0.4 -m "Release 0.0.0.4"
git push origin main --tags
```
