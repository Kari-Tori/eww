---
title: GOALS
description: Cele E-Waste Workshop – centrum recyklingu i refabrykacji elektroniki
tags:
  - goals
  - roadmap
  - business
version: 0.0.0.5
language: pl
created: 2025-11-29
updated: 2025-11-29
owner: jakubc
---

# 🎯 GOALS

## Misja
- E-Waste Workshop to centrum recyklingu i refabrykacji elektroniki; łączymy automatyzację, AI i warsztat w jednym repo, żeby skrócić czas odzysku i refabrykacji.
- Działamy z zasady Zero Waste (wszystko ma być „surowcem dla nas”) — patrz `ZERO-WASTE-POLICY.md`.

## Horyzont 30 dni (M1)
- Quick Start: `make install-local` + `eww-doctor` <10 minut onboarding.
- Systemd runbook w `core/systemd/README.md` (eww-autocommit, eww-status, watch-obsidian-plugins).
- Dokumentacja: uzupełniony `lib/README.md` (sygnatury funkcji) + sekcja „10-min setup” w `README.md`.
- Opis historii i modelu działania (Jakub R&D/eksperymenty, Karina stable produkt, Odoo+AI inventaryzacja) w `README.md`.

## Horyzont 90 dni (Q1)
- Migracja wg `docs/infra/RESTRUCTURE-MAP.md`: rename `dev/`→`development/`, `usr/`→`users/`, uporządkowane indeksy.
- `business/roadmap.md` (OKR/KPI, kamienie, właściciele) podlinkowane z `business/README.md`.
- Autoreports: stabilny `core/reports/repo-stats.md` + `docs/infra/reports/CLEANUP-LOG.md` utrzymywany.
- Ramy monetizacji: kanał YouTube (serie mobilne, pato-naprawy) + sprzedaż FCGH; polityka zero waste wdrożona operacyjnie.

## Horyzont 365 dni (Rocznie)
- Wydanie 0.1: instalator + monitoring pluginów Obsidian + baner init jako domyślne doświadczenie użytkownika.
- Dokumentacja: pełny indeks `docs/infra/` i `business/` (GOALS → roadmap → szczegóły).
- System inwentaryzacji Odoo + AI gotowy do użytku warsztatowego (pozyskanie sprzętu ze złomu).

## KPI (mierzalne)
- Onboarding (clone → init → doctor): ≤10 minut.
- MRR: ≥ £1500/mies. na pokrycie czynszu.
- Stabilność operacyjna: brak zatorów z powodu braku internetu (monitoring i procedura obejścia Gary Net).
- Aktualność dokumentacji: `GOALS.md` i `business/roadmap.md` aktualizowane co 30 dni.

## Linki referencyjne
- `business/README.md`
- `docs/infra/RESTRUCTURE-MAP.md`
- `README.md`
