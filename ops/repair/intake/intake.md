---
tags:
  - #folder_note
  - #intake
  - #repair
  - #eww
created: 2025-11-27T17:26:43Z
modified: 2025-11-27T17:30:19Z
author: karinam
title: "Przyjęcia (naprawy)"
owner: karinam
folder_color: 8421504
folder_stats:
  md_files: 1
  total_files: 1
  subdirs: 1
---

# Przyjęcia (naprawy)

> Karty przyjęć wyłącznie dla zleceń serwisowych kierowanych do modułu napraw (Odoo).

## Cel folderu

- Rejestrować naprawy od razu spięte z Odoo (ID/STATUS/KOSZT).
- Uporządkować intake dla serwisu osobno od intake ogólnego.

## Minimalna karta

- Identyfikator sprzętu i data przyjęcia.
- Zleceniodawca, uzgodniony koszt, opis usterki.
- `handoff: moduł napraw (Odoo)` + `odoo_repair_id` (gdy znany).
- Folder przyjęcia zawiera `asset/` na zdjęcia/manuale.

## Struktura

- `records/` – karty przyjęć serwisowych (np. `ipad-2025-11-27.md`).

## Powiązania

- [[repair/repair|Naprawy]] – moduł nadrzędny.
- [[intake/intake|Przyjęcia (global)]] – intake ogólne.
- Odoo (moduł napraw) – status i rozliczenia.
