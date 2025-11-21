---
title: Infra
description: 🏗️ Infra — katalog główny
type: file
category: docs
filepath: docs/infra/infra.md
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
related:
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/infra/infra.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# 🏗️ Infra — katalog główny

Folder `docs/infra/` jest jedynym źródłem prawdy dla dokumentacji infrastruktury E-Waste Workshop. Każda sekcja posiada własny podfolder i plik `README.md`, które można rozbudowywać o kolejne podpliki lub diagramy.

## 📁 Sekcje

| Folder | Zakres | Główne pliki |
| --- | --- | --- |
| `hardware/` | Hosty fizyczne, peryferia, identyfikatory assetów | [`hardware/README.md`](hardware/README.md) |
| `network/` | Topologia, VLAN, adresacja, ACL | [`network/README.md`](network/README.md) |
| `software/` | Systemy i usługi (OS, aplikacje, konfiguracje) | [`software/README.md`](software/README.md) |
| `vm/` | Hypervisory, maszyny wirtualne, kontenery | [`vm/README.md`](vm/README.md) |

## ✅ Jak pracować z katalogiem

1. Aktualizuj odpowiedni `README.md` lub dodaj nowy plik w danym folderze (np. `network/lan-plan.md`).
2. Utrzymuj spójny frontmatter (tytuł, opis, daty `created/updated`).
3. Po zmianach wykonaj `git status` i dodaj nowe pliki do repozytorium.

W razie potrzeby możesz rozszerzyć strukturę (`docs/infra/security/`, `docs/infra/backup/` itd.). Uzupełnij tabelę powyżej o nowe sekcje, by zachować przejrzysty indeks.
