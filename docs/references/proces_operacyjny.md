---
title: Proces Operacyjny
description: E-Waste Workshop – Proces operacyjny pojedynczego sprzętu
type: file
category: docs
filepath: docs/references/proces operacyjny.md
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
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
  - docs/neovim-guide.md
  - docs/narzedzia-deweloperskie.md
dependencies:
sources:
  - docs/references/proces operacyjny.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# E-Waste Workshop – Proces operacyjny pojedynczego sprzętu

## Faza 1 – Identyfikacja
- [ ] Zrób zdjęcia urządzenia
- [ ] Prześlij do ChatGPT do identyfikacji
- [ ] Zanotuj nazwę + typ w `Asset.md`

## Faza 2 – Diagnoza techniczna
- [ ] Test działania
- [ ] Opis zauważonych usterek
- [ ] Wstępna decyzja o stanie: [Sprawny / Uszkodzony / Częściowo sprawny]

## Faza 3 – Analiza rynku
- [ ] Wejdź na eBay > Sold Items
- [ ] Zanotuj średnią cenę / trendy
- [ ] Oceń: czy sprzęt jest poszukiwany?

## Faza 4 – Decyzja
- [ ] Oznacz decyzję w `Asset.md`:
  - [ ] Sprzedaż
  - [ ] Naprawa (wpisz notatkę)
  - [ ] Rozbiórka

## Faza 5 – Przygotowanie do sprzedaży
- [ ] Przenieś zdjęcia z iCloud do `Sales/{{ID}}/`
- [ ] Stwórz plik ogłoszenia `Sales/{{ID}}/listing.md`
- [ ] Uzupełnij:
  - Specyfikację
  - Historię przedmiotu
  - Tytuł (z SEO słowami kluczowymi)
  - Regulamin EWW (np. brak zwrotów, wyjątki itd.)

## Faza 6 – Wystawienie + zysk
- [ ] Karina wystawia przedmiot
- [ ] Po sprzedaży aktualizuje `Profit.md`
- [ ] Status w `Asset.md`: Sprzedane