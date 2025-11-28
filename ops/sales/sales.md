---
tags:
  - folder_note
  - sales
  - eww
  - ebay
  - marketplace
created: 2025-11-28T19:30:00Z
modified: 2025-11-28T19:30:00Z
author: karinam
title: "Sales - Sprzedaż"
owner: karinam
folder_color: 15158332
folder_stats:
  md_files: 1
  total_files: 1
  subdirs: 3
---

# Sales - Sprzedaż

> Moduł sprzedaży: przygotowanie listingów, aktywne ogłoszenia eBay, sprzedane przedmioty i archiwum.

## Cel folderu

- Zarządzanie procesem sprzedaży od przygotowania listingu do finalizacji transakcji
- Tracking aktywnych ogłoszeń na eBay i innych platformach
- Archiwizacja sprzedanych przedmiotów z historią transakcji
- Szablony i best practices dla listingów

## Struktura

- `active/` – Aktywne ogłoszenia (wystawione na eBay/marketplace)
- `sold/` – Sprzedane przedmioty z historią transakcji
- `archived/` – Wycofane/nieaktualne ogłoszenia
- `templates/` – Szablony listingów i opisów

## Minimalna karta sprzedaży

- Identyfikator przedmiotu (powiązany z intake/research/repair)
- Platforma (eBay, inne marketplace)
- Tytuł i opis listingu (SEO-optimized)
- Zdjęcia produktu
- Cena wystawienia i historia zmian cen
- Status (draft/active/sold/archived)
- Data wystawienia i sprzedaży
- Dane kupującego (po sprzedaży)
- Tracking wysyłki

## Przepływ (skrót)

1. **Intake** → przedmiot przyjęty do warsztatu
2. **Research/Repair** → diagnoza, naprawa, refabrykacja
3. **Sales prep** → przygotowanie zdjęć, opis, pricing research
4. **Active listing** → wystawienie na eBay (`active/`)
5. **Sold** → sprzedaż i wysyłka (`sold/`)
6. **Archive** → jeśli wycofane lub nieaktualne (`archived/`)

## Integracje

- **eBay API** – synchronizacja listingów i zamówień
- **Odoo** – zarządzanie inwentarzem i stanami magazynowymi
- **n8n** – automatyzacja workflow między platformami

## Powiązania

- [[intake/intake|intake]] – przyjęcia sprzętu do warsztatu
- [[research/research|research]] – badania i diagnostyka
- [[repair/repair|repair]] – naprawy i serwis
- [[business/processes/proces_operacyjny|proces operacyjny]] – pełny cykl życia sprzętu
- [[business/roadmap|roadmap]] – cele biznesowe i rozwój

## Best practices

- **Zdjęcia:** Minimum 6-8 zdjęć (przód, tył, etykiety, detale, defekty)
- **Tytuł:** SEO keywords + marka + model + stan + kluczowe cechy (max 80 znaków)
- **Opis:** Specyfikacja, stan, historia, polityka zwrotów EWW
- **Pricing:** Research eBay Sold Items, uwzględnij koszty (fees, shipping, packaging)
- **Wysyłka:** Tracked delivery, dokumentacja fotograficzna przed wysyłką
