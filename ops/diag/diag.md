---
tags:
  - folder_note
  - ops
  - diagnostyka
  - diag
  - sop
created: 2025-11-28T20:00:00Z
modified: 2025-11-28T20:00:00Z
author: karinam
title: "Diag - Diagnostyka"
owner: karinam
---

# Diag - Diagnostyka

> Szybka diagnostyka sprzętu według standardowych procedur (SOP).

## Cel

Sprawna ocena stanu technicznego sprzętu po opracowaniu procedur w **research**.

## Proces diagnostyczny

```
RESEARCH (SOP) ───▶ DIAG (szybka ocena) ───▶ Decyzja
                                                │
                                    ┌───────────┼───────────┐
                                    │           │           │
                                    ▼           ▼           ▼
                                 REPAIR      PARTS      SELL AS-IS
```

## Wyjścia diagnostyki

1. **REPAIR** - Opłacalna naprawa
2. **PARTS** - Odzysk komponentów
3. **SELL AS-IS** - Sprzedaż w aktualnym stanie
4. **RECYCLE** - Utylizacja/recykling

## SOP (Standard Operating Procedures)

Procedury diagnostyczne tworzone są w `research/` dla każdego typu sprzętu:

- Laptopy
- Tablety
- Smartfony
- Monitory
- Inne elektronika

## Struktura

```
diag/
├── diag.md           # Ta notatka
├── pending/          # Urządzenia oczekujące na diagnostykę
├── reports/          # Raporty diagnostyczne
└── sop/              # Linki/kopie procedur z research
```

## Powiązania

- [[ops/research/research|Research]] - Źródło procedur SOP
- [[ops/repair/repair|Repair]] - Naprawy po diagnostyce
- [[ops/sales/sales|Sales]] - Sprzedaż po ocenie
