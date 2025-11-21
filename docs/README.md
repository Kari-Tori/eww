---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T15:00:00Z
modified: 2025-11-21T15:00:00Z
author: jakubc
title: "📚 docs/ — przewodnik dokumentacyjny"






---



# 📚 docs/ — przewodnik dokumentacyjny

> [!TIP] Szybkie skróty
> - [📑 docs/INDEX.md](INDEX.md) — tabela folderów i folder note’ów  
> - [🎨 ICON-SET](assets/icons.md) — kolory i emoji (Kubuntu, VS Code, Obsidian)  
> - [FULL-INDEX.md](FULL-INDEX.md) — pełne rozwinięcie dokumentacji

## 🎯 Cel katalogu
`docs/` przechowuje wszystkie materiały tekstowe projektu – od przewodników użytkowych, przez raporty i metodologie, aż po notatki zespołowe. Każdy podkatalog posiada własny folder note, który wyjaśnia jego zawartość.

## 🗂️ Jak się poruszać
1. **Zacznij od [docs/INDEX.md](INDEX.md)** – znajdziesz tam tabelę z linkami do folder note’ów.
2. **Używaj standardu ikon** z [assets/icons.md](assets/icons.md) przy tworzeniu nowych dokumentów (kolory + emoji).
3. **Dodaj źródła i backlinki** – każdy dokument powinien podawać, skąd czerpie informacje oraz gdzie ma zostać podlinkowany.

## ✅ Checklist do nowych dokumentów
- Front matter zawiera `tags` (≤7), `icon` oraz `sources`.
- W treści opisz **Zakres** / **Zawartość** lub wstaw tabelę elementów.
- Dodaj link zwrotny do nadrzędnego indeksu (np. `docs/INDEX.md` lub folder note’u).

> [!IMPORTANT]
> Dokumenty w `docs/` stanowią źródło prawdy dla całego repo. Przed wprowadzeniem większych zmian upewnij się, że są odnotowane w [CHANGELOG.md](../CHANGELOG.md) oraz w odpowiednim folder note.

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
