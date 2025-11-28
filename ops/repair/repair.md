---
tags:
  - #folder_note
  - #repair
  - #eww
created: 2025-11-27T17:26:43Z
modified: 2025-11-27T17:30:19Z
author: karinam
title: "Naprawy"
owner: karinam
folder_color: 8421504
folder_stats:
  md_files: 1
  total_files: 1
  subdirs: 1
---

# Naprawy

> Moduł napraw EWW (spięty z Odoo): przyjęcia serwisowe, statusy i koszty.

## Cel folderu

- Rejestrowanie zleceń napraw (wejście z Intake → moduł napraw).
- Powiązanie z Odoo (`odoo_repair_id`) i kosztami ustalonymi z klientem.
- Historia diagnoz/napraw i aktualny status.

## Przepływ (skrót)

- Przyjęcie: [[repair/intake/intake|intake (naprawy)]] – karty w `records/`.
- Realizacja: diagnostyka i naprawa w Odoo (statusy, części, koszt).
- Zakończenie: aktualizacja karty i zamknięcie w Odoo.

## Struktura

- `intake/` – przyjęcia do napraw (z kartami w `records/`).
- `templates/` – opcjonalne szablony kart napraw/diagnoz.
- `logs/` – opcjonalne logi z napraw (testy, pomiary, części).

## Powiązania

- [[intake/intake|Przyjęcia (global)]] – punkt startowy dla całego sprzętu.
- [[research/research|Research]] – gdy potrzebna diagnostyka przed decyzją.
- Odoo (moduł napraw) – źródło prawdy o statusach i kosztach.
