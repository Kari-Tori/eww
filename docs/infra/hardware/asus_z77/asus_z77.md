---
title: Asus Z77
description: asus_z77 — karta główna
type: file
category: docs
filepath: docs/infra/hardware/asus_z77/asus_z77.md
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
  - docs/infra/hardware/asus_z77/asus_z77.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# asus_z77 — karta główna

Jednostka robocza Kariny oparta o płytę Asus Z77. Poniższe sekcje opisują jej zastosowanie, parametry, zadania i historię operacyjną.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki  
> - 💻 **Rola:** Workstation Kariny (desktop kreatywny / AI) z GPU GTX 1660 Ti i zestawem 2 monitorów + TV.  
> - 📸 **Workflow:** zgrywanie zdjęć z telefonu przez WhatsApp (iCloud tymczasowo wyłączony), research przedmiotów, przygotowanie opisów i upload listingów eBay.  
> - 📺 **Tryb TV:** obecnie Jakub pracuje na tej maszynie podpiętej do telewizora Samsung 65", więc pełni ona też rolę centrum multimedialnego.  
> - 🧩 **Infrastruktura:** wpięta ok. Q4 2024, po modernizacji GPU i wymianie dysków; regularnie serwisowana (ostatnio chłodzenie, sprzedaż GTX 1030).

## ⚙️ Specyfikacja (Dataview)
```dataview
TABLE icon AS " ", model AS "Model", specs AS "Specyfikacja", value AS "Wartość"
FROM "docs/infra/hardware/asus_z77"
WHERE component
SORT file.name
```

## 🗂️ Indeks folderu
- `motherboard-asus-p8z77-v-deluxe.md`, `cpu-intel-i7-3770k.md`, `ram-corsair-vengeance-16gb.md`, `gpu-nvidia-gtx1660ti.md`, `psu-tbd.md`, `pcie-wifi-go.md`, `storage/`
- `case/` (np. `case-index.md`, `case-chassis.md`, `case-fans.md`, `case-cpu-cooler.md`, `case-cpu-fans.md`)
- `ops/` – oś czasu operacji i serwisów

## ✅ Zadania @karinam (folder asus_z77)
```dataview
TASK
FROM "docs/infra/hardware/asus_z77"
```

## ✅ Zadania globalne (wszystkie pliki)
```dataview
TASK
FROM ""
WHERE contains(text, "asus_z77")
```

## 📝 Notatki operacyjne = Ops timeline
> [!abstract] 2022-05-01 · [Zakup](ops/2022-05-01~zakup.md)
> - Jednostka kupiona na eBayu za ~£80 (sprzedawca odmówił oddania dysku, po eskalacji otrzymaliśmy zwrot). Stała bez dysku ~2 lata.  
> - TODO: podlinkować transakcję i potwierdzić dokładny dzień zakupu.

> [!info] 2024-02-01 · [Pierwszy dysk + reinstalacje](ops/2024-02-01~pierwszy-dysk.md)
> - Tymczasowy SSD → wielokrotne reinstalli Kubuntu → awaria nośnika.  
> - TODO: dodać logi reinstalli (daty, wersje, nośniki ISO).

> [!success] 2024-06-01 · [Modernizacja GPU](ops/2024-06-01~modernizacja-gpu.md)
> - GTX 1660 Ti Windsurf w miejsce EVGA GTX 1030; stara karta leżała w zapasie i została sprzedana ok. 2 tyg. temu za £32.  
> - TODO: podlinkować aukcję i datę sprzedaży/montażu.

> [!important] 2024-10-01 · [Wdrożenie do infrastruktury](ops/2024-10-01~wdrozenie.md)
> - Formalne wpięcie do środowiska operacyjnego (GTX 1660 Ti + pierwszy dysk).  
> - TODO: dodać wpis z rejestru assetów.

> [!info] 2025-03-01 · [Drugi dysk – SK hynix](ops/2025-03-01~drugi-dysk.md)
> - Instalacja docelowego SSD SK hynix 512 GB (obecny dysk systemowy).  
> - TODO: dopisać datę instalacji, SMART i powiązane reinstallacje.

> [!note] 2025-05-01 · [Serwis chłodzenia](ops/2025-05-01~serwis-chlodzenia.md)
> - Karina serwisowała wentylatory, by ustabilizować temperaturę.  
> - TODO: wpisać temperatury odniesienia i profil wentylatorów.

> [!tip] 📔 Log reinstalli (ciągły)
> - Każda wymiana/awaria dysku → reinstall Kubuntu.  
> - TODO: spiąć timeline (`data`, `wersja`, `powód`) z kartą dysku i notatkami serwisowymi.

- [ ] @karinam dopisać numery seryjne obudowy/zasilacza i świeży stan konserwacji.

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-19 | Utworzono strukturę folderu i linki do komponentów. |
