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






owner: jakubc
---



# 🏗️ Infra — katalog główny

Folder `docs/infra/` jest jedynym źródłem prawdy dla dokumentacji infrastruktury E-Waste Workshop. Każda sekcja posiada własny podfolder i plik `README.md`, które można rozbudowywać o kolejne podpliki lub diagramy.

## 📁 Sekcje

| Folder | Zakres | Główne pliki |
| --- | --- | --- |
| `hardware/` | Hosty fizyczne, peryferia, identyfikatory assetów | [`hardware/README.md`](hardware/README.md) |
| `network/` | Topologia, VLAN, adresacja, ACL | [`network/README.md`](network/README.md) |
| `software/` | Systemy i usługi (OS, aplikacje, konfiguracje) | [`software/software.md`](software/software.md) |
| `graphs/` | Konfiguracje grafu Obsidian, kolory i automatyzacje | [`graphs/graph-setup-guide.md`](graphs/graph-setup-guide.md) |
| `assets/` | Ikony, emoji, standardy oznaczeń | [`assets/assets.md`](assets/assets.md) |
| `dashboards/` | Widoki monitoringu i kokpity operacyjne | README w podfolderach |
| `guide/` | Przewodniki i instrukcje repozytorium | [`guide/guide.md`](guide/guide.md) |
| `references/` | Specyfikacje i materiały referencyjne | [`references/references.md`](references/references.md) |
| `reports/` | Raporty stanu, indeksy i logi czyszczenia | [`reports/INDEX.md`](reports/INDEX.md) |
| `site/` | Artefakty generatora strony docs | README w podfolderach |
| `tags/` | Folder notes dla tagów vaulta | [`tags/tags.md`](tags/tags.md) |
| `wiki/` | Artykuły techniczne (Kubuntu, Neovim, Obsidian) | [`wiki/wiki.md`](wiki/wiki.md) |
| `legacy/` | Stare indeksy (docs.md, README, makefile guide) | pliki przeniesione z `docs/` |
| `vm/` | Hypervisory, maszyny wirtualne, kontenery | [`vm/vm.md`](vm/vm.md) |

## ✅ Jak pracować z katalogiem

1. Aktualizuj odpowiedni `README.md` lub dodaj nowy plik w danym folderze (np. `network/lan-plan.md`).
2. Utrzymuj spójny frontmatter (tytuł, opis, daty `created/updated`).
3. Po zmianach wykonaj `git status` i dodaj nowe pliki do repozytorium.

W razie potrzeby możesz rozszerzyć strukturę (`docs/infra/security/`, `docs/infra/backup/` itd.). Uzupełnij tabelę powyżej o nowe sekcje, by zachować przejrzysty indeks.

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

- [architecture/](architecture/architecture.md)
- [areas/](areas/README.md)
- [assets/](assets/assets.md)
- [dashboards/](dashboards/README.md)
- [graphs/](graphs/graph-setup-guide.md)
- [guide/](guide/guide.md)
- [hardware/](hardware/hardware.md)
- [legacy/](legacy/README.md)
- [network/](network/network.md)
- [references/](references/references.md)
- [reports/](reports/INDEX.md)
- [site/](site/README.md)
- [software/](software/software.md)
- [status_sieci.md](status_sieci.md)
- [tags/](tags/tags.md)
- [vm/](vm/vm.md)
- [wiki/](wiki/wiki.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]
