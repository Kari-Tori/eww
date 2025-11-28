---
title: Roadmapa biznesowa
description: Cele E-Waste Workshop (30/90/365), kanały i KPI
tags:
  - roadmap
  - goals
  - business
version: 0.0.0.5
language: pl
created: 2025-11-29
updated: 2025-11-29
owner: jakubc
---

# Roadmapa biznesowa

## Misja
- E-Waste Workshop to centrum recyklingu i refabrykacji elektroniki; pracujemy w modelu Zero Waste („wszystko jest surowcem dla nas”).

## Role i podział pracy
- **Jakub (R&D, eksperymenty)**: pozyskiwanie złomu, refabrykacja całych urządzeń, komponentów i odzysk surowców (PCB, złącza, plastik → granulat/odlewy, druk 3D).
- **Karina (stabilny produkt/sprzedaż)**: serwis/refabrykacja mobilna (start: iPhone 11), produkty FCGH, sprzedaż na eBay i online.

## Kanały i monetyzacja
- **Sprzedaż**: eBay (Karina), sprzedaż produktów eksperymentalnych (Jakub), komponenty/urządzenia refabrykowane.
- **Media**: YouTube (serie napraw, mobilne urządzenia, „pato-naprawy”), strona www (oferta, kontakt).
- **Repo/narzędzia**: automatyzacja, system inwentaryzacji Odoo + AI dla warsztatu.
- **Cel finansowy**: min. **£1500/mies.** na pokrycie czynszu.

## Horyzont 30 dni (M1)
- Quick Start w `README.md` + `make install-local`/`eww-doctor` <10 minut onboarding.
- Runbook systemd (`core/systemd/README.md`) i ujednolicone README narzędzi.
- Uporządkowana historia/model w `business/story.md` + linki w README.
- Polityka Zero Waste widoczna i stosowana (`ZERO-WASTE-POLICY.md`).

## Horyzont 90 dni (Q1)
- Migracja wg `docs/infra/RESTRUCTURE-MAP.md` (rename `dev/`→`development/`, `usr/`→`users/`).
- Kanały sprzedaży + media: plan serii YT (mobilne/pato-naprawy), produkt FCGH.
- Szkic inwentaryzacji Odoo + AI (przyjęcie → test → refabrykacja → magazyn → sprzedaż).
- Stabilne operacje mimo ograniczonego internetu (Gary Net) — procedura obejścia w `docs/infra/network/garynet.md`.

## Horyzont 365 dni
- Wydanie 0.1 warsztatowego toolsetu (instalator, monitoring pluginów, baner init).
- Działający system inwentaryzacji Odoo + AI dla części i urządzeń.
- Utrzymane kanały: regularne publikacje YT, sprzedaż FCGH/eBay, spójna oferta na WWW.

## KPI
- MRR: ≥ **£1500/mies.**.
- Onboarding: repo + init w ≤10 minut.
- Dostępność operacyjna: brak blokad przez słabe łącze (procedury offline/fallback działają).
- Regularność mediów: min. 2 materiały YT/mies. po Q1.
- Aktualność dokumentacji: `GOALS.md` i `business/roadmap.md` aktualizowane co 30 dni.

## Linki referencyjne
- `GOALS.md`
- `business/story.md`
- `ZERO-WASTE-POLICY.md`
- `docs/infra/location.md`
- `docs/infra/network/garynet.md`
- `docs/infra/RESTRUCTURE-MAP.md`
