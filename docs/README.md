---
title: docs/ - Dokumentacja projektu
description: Kompletna dokumentacja projektu
version: 0.0.0.4
author: Nairecth
repository: https://github.com/Nairecth/eww
type: readme
category: documentation
audience: developers
language: pl
platform: Kubuntu 24.04 LTS
requires:
  - bash >= 5.1
  - git
tags:
  - bash
  - documentation
created: 2025-11-09
updated: 2025-11-09
license: MIT
status: stable
---

# docs/ - Dokumentacja projektu

Dokumentacja E-Waste Workshop.

## Struktura

### `index.md` - Strona główna dokumentacji
Punkt wejścia do dokumentacji projektu.

### `wiki/` - Wiki projektu
Artykuły i poradniki:
- `kubuntu.md` - konfiguracja Kubuntu
- `neovim.md` - setup Neovim
- `obsidian.md` - integracja z Obsidian

### `guide/` - Przewodniki
Szczegółowe instrukcje:
- `intro.md` - wprowadzenie do projektu

### Pliki dokumentacyjne
- `ENDPOINTS.md` - dokumentacja API/endpointów
- `readme-checklist.md` - checklist dla README
- `release-0.0.0.1.md` - notatki z wydania
- `vendor.md` - informacje o zależnościach

## Generowanie dokumentacji

Projekt może używać MkDocs do generowania strony dokumentacji:

```bash
# Instalacja MkDocs
pip install mkdocs mkdocs-material

# Podgląd lokalny
mkdocs serve

# Generowanie strony
mkdocs build
```

## Aktualizacja

Przy dodawaniu nowych funkcji, aktualizuj odpowiednią sekcję dokumentacji:

1. Dodajopis w `index.md`
2. Stwórz dedykowany przewodnik w `guide/`
3. Dodaj wpis do wiki jeśli potrzeba
4. Zaktualizuj README.md w katalogu głównym
