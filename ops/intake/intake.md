---
tags:
  - #folder_note
  - #intake
  - #eww
created: 2025-11-27T17:03:23Z
modified: 2025-11-27T17:26:43Z
author: karinam
title: "Przyjęcia"
owner: karinam
folder_color: 8421504
folder_stats:
  md_files: 1
  total_files: 1
  subdirs: 1
---

# Przyjęcia

> Bramki przyjęć: rejestrujemy każdy sprzęt i materiał wchodzący do EWW (E‑Waste Workshop) oraz decyzję startową dla dalszego cyklu.

## Cel folderu

- Karty przyjęcia z datą, źródłem, stanem i wstępną decyzją (research/refab/części/recykling).
- Powiązanie z inwentarzem (ID/Odoo) i osobą przyjmującą.
- Checklista przyjęcia, zdjęcia startowe i dane kontaktowe źródła.

## Minimalna karta przyjęcia

- Identyfikator (lokalny lub z Odoo) i typ przedmiotu.
- Data przyjęcia, źródło (darowizna/zakup/zwrot) i kompletność.
- Ocena stanu (sprawny/naprawa/na części) oraz decyzja startowa.
- Następny krok: moduł napraw (jeśli to serwis) lub [[research/research|research]] / refab / parts / recycle.

## Przepływ (skrót)

- Intake = przyjęcia ogólne i rejestracja (z kartą w `records/`).
- Dla zleceń serwisowych sprzęt trafia od razu do modułu napraw (Odoo).
- Dla niejasnych przypadków kierunek: [[research/research|research]] na diagnostykę, potem decyzja (naprawa/refab/parts/recycle).

## Sugestia struktury

- `records/` – karty przyjęcia w Markdown/YAML (serwisowe → `repair/intake/records/`).
- `templates/` – szablony formularzy intake.
- `inbox/` – szybkie wrzutki do opracowania.

## Powiązania

- [[research/research|research]] – analizy i wnioski techniczne.
- [[docs/infra/hardware/hardware|hardware]] – katalog sprzętu i per-model notatki.
- [[business/roadmap|roadmap]] – ścieżki rozwoju i priorytety.
