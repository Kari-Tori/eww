---
title: AGENTS.md - Kontekst dla AI Coding Agents
description: Instrukcja dla AI – misja Zero Waste, struktura repo, zasady pracy i wersjonowanie
modified: 2025-11-28
version: 0.0.6
audience: AI coding agents
type: ai-context
category: documentation
tags:
  - ai
  - context
  - architecture
  - workflow
  - conventions
language: pl
created: 2025-11-09
updated: 2025-11-29
---

# AGENTS.md - Kontekst dla AI Coding Agents

## 📌 Krótko o projekcie
- **E-Waste Workshop (EWW):** centrum recyklingu/refabrykacji elektroniki z automatyzacją.
- **Misja:** Zero Waste – wszystko jest surowcem dla nas (odzysk, refabrykacja, edukacja).
- **Lokalizacja:** 77C Church Lane, N9 9PZ (outbuilding za domem Gary’ego).
- **Cel finansowy:** ≥ £1500/mies. na pokrycie czynszu.

## 🗂️ Architektura repo (skrót)
```
eww/
├── bin/                # CLI użytkownika
├── business/           # Biznes, governance, roadmapy, polityki
├── core/               # Config/runtime/workflow
├── dev/                # Narzędzia dev, skrypty, init, testy
├── lib/                # Biblioteki wspólne
├── docs/               # Dokumentacja (areas/workshop/location, network, hardware)
├── archive/            # Archiwum
└── Makefile            # Automatyzacja (make help)
```

## 🧰 Stack / narzędzia
- Kubuntu 24.04 LTS
- VS Code, Obsidian
- Codex, GitHub Copilot
- Odoo ERP (inwentaryzacja – plan/rozwój)
- Make, systemd, GitHub Actions
- GitHub (repo, tagi `vX.Y.Z` obowiązkowe; `VERSION` + frontmatter muszą być zgodne; `make check-versions`)

## 🔧 Workflow (dla AI)
1. Branch: `git checkout -b feat/...`
2. Kod + lint/test tam, gdzie ma sens (bez zbędnych zależności).
3. `make comment-add FILE=...` jeśli trzeba komentarzy.
4. `make bump-version BUMP=X.Y.Z` + `make check-versions` (tag/VERSION/frontmatter).
5. Commit (Conventional Commits); tag `vX.Y.Z` wymagany do spójności.
6. `make changelog` jeśli generujesz changelog.

## ✅ Zasady dla AI
- Język: po polsku.
- Nie usuwaj cudzych zmian; brak destrukcyjnych komend.
- Komentarze tylko gdy realnie poprawiają czytelność.
- Wersjonowanie: trzymaj `VERSION` + frontmatter w zgodzie z tagiem Git.
- Ścieżki w odpowiedziach: `path/to/file:line` (bez URI).

## Kontekst techniczny

### Zmienne i init
- `EWW_ROOT=/git/eww`, `EWW_CD_ROOT=1`, `EWW_BANNER_ENABLE=1`, `EWW_INIT_OK=1`.
- Inicjalizacja: source `dev/projects/init-eww.sh`.

### Kluczowe pliki
- `VERSION` – numer wersji (zgodny z tagiem Git).
- `Makefile` – `make help`, `make check-versions`, `make bump-version`.
- `dev/scripts/check-version-consistency.sh` – walidacja tag/VERSION/frontmatter.
- `business/story.md`, `business/roadmap.md`, `ZERO-WASTE-POLICY.md` – misja, cele, polityka zero waste.
- `docs/infra/areas/workshop/location.md`, `docs/infra/hardware/network/garynet.md`, `docs/infra/hardware/hardware.md` – miejsce, łączność, sprzęt.

## Planowane rozszerzenia
- [ ] Migracja wg `docs/governance/RESTRUCTURE-MAP.md` (dev→development, usr→users)
- [ ] Więcej testów coverage (BATS dla lib/init)
- [ ] Dokumentacja (MkDocs / indeksy)
- [ ] Integracje CI/CD, pluginy, inne dystrybucje

## 🔗 Backlinks

- [[EWW-MAP]]
- [[INDEX]]
- [[README]]
