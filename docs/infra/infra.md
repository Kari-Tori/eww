---
tags:
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "🏗️ Infra — katalog główny"






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

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

- [architecture/](architecture/architecture.md)
- [hardware/](hardware/hardware.md)
- [network/](network/network.md)
- [software/](software/software.md)
- [vm/](vm/vm.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

