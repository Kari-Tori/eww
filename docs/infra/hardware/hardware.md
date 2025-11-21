---
tags:
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #secondbrain
  - #star-wars
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "🧱 Hardware"






---



# 🧱 Hardware

Folder `docs/infra/hardware/` zawiera katalogi per asset oraz ten indeks. Każde urządzenie otrzymuje własny folder z notką indeksową (`folder note`) i plikami komponentów (np. `cpu-intel-i7-3770k.md`, `gpu-nvidia-gtx1660ti.md`, `ram-corsair-vengeance-16gb.md`).

## 📋 Zasady
- Jeden folder = jeden asset (np. `asus_z77/`), w środku plik `asus_z77.md` jako indeks.
- Standardowy frontmatter: `title`, `role`, `location`, `created`, `updated`.
- Komponenty opisujemy w osobnych plikach nazwanych po modelu (`cpu-intel-…`, `gpu-nvidia-…`, `storage-…` itd.).
- [ ] @karinam sprawdzić, czy każda karta sprzętu ma aktualne dane (daty, numery seryjne, logi serwisowe).

## 🖥️ Workstations

| ID | Nazwa | Rola | Plik |
| --- | --- | --- | --- |
| `asus_z77` | Asus Z77 workstation | Jednostka główna Kariny | [asus_z77/asus_z77.md](asus_z77/asus_z77.md) |
| `gerc` | Asus X99 Pro (GERC) | Węzeł obliczeniowy / workstation | [gerc/gerc.md](gerc/gerc.md) |

Dodając nowe urządzenia, utwórz folder `ID/`, plik indeksowy `ID/ID.md` oraz podnotki komponentów; następnie dopisz wpis do powyższej tabeli.

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

- [asus_z77/](asus_z77/asus_z77.md)
- [gerc/](gerc/gerc.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

