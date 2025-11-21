---
title: Hardware
description: 🧱 Hardware
type: file
category: docs
filepath: docs/infra/hardware/hardware.md
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
  - docs/infra/hardware/hardware.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
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
