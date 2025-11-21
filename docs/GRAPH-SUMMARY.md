---
tags:
  - #automation
  - #docs
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T09:00:00Z
modified: 2025-11-21T09:00:00Z
author: jakubc
title: "🎨 Graph Summary - System Mapowania"






---

# 🎨 Graph Summary - System Mapowania

> **Kompletny system kolorowania i mapowania projektu EWW w Obsidian**

## ✅ Co Zostało Utworzone

### 🗺️ Główna Mapa
- **[[EWW-MAP]]** - Centralna mapa nawigacyjna całego projektu

### 📁 Folder Notes (8)
Każdy główny folder ma swój folder note:

1. **[[docs/docs]]** 🟣 - Dokumentacja (`#docs`)
2. **[[config/config]]** 🟠 - Konfiguracja (`#config`)
3. **[[tools/tools]]** 🔷 - Narzędzia (`#tools`)
4. **[[infra/infra]]** 🟡 - Infrastruktura (`#infra`)
5. **[[usr/usr]]** 👥 - Użytkownicy (`#users`)
6. **[[var/var]]** 💾 - Dane zmienne (`#var`)
7. **[[dev/dev]]** 🚧 - Development (`#dev`)
8. **[[scripts/scripts]]** 📜 - Skrypty (jeśli istnieje)

### 👥 Profile Użytkowników (2)
1. **[[usr/jakubc/jakubc]]** 🟢 - Jakub C (`#jakubc`)
2. **[[usr/karinam/karinam]]** 🩷 - Karina M (`#karinam` `#candy`)

### 📄 Dokumentacja Głównych Plików
1. **[[README]]** - Główny README z tagami
2. **[[CHANGELOG]]** - Historia zmian
3. **[[Makefile.md]]** - Dokumentacja Makefile

## 🎨 System Kolorów Grafu

### Konfiguracja (.obsidian/graph.json)

| Kolor | Tag | Obszar | Hex |
|-------|-----|--------|-----|
| 🩷 Różowy | `#candy` `#karinam` | Karina M | #FF69B4 |
| 🟢 Zielony | `#jakubc` | Jakub C | #00FF00 |
| 🔵 Niebieski | `#core` | Rdzeń | #0000FF |
| 🟡 Żółty | `#infra` | Infrastruktura | #FFFF00 |
| 🟣 Magenta | `#docs` | Dokumentacja | #FF00FF |
| 🔷 Cyan | `#tools` | Narzędzia | #00FFFF |
| 🟠 Pomarańczowy | `#config` | Konfiguracja | #FFA500 |

## 📊 Struktura Tagów

### Główne Tagi (7)
1. `#eww` - Wszystkie pliki projektu
2. `#core` - Rdzeń (README, CHANGELOG, Makefile)
3. `#docs` - Dokumentacja
4. `#tools` - Narzędzia
5. `#infra` - Infrastruktura
6. `#config` - Konfiguracja
7. `#jakubc` / `#karinam` `#candy` - Użytkownicy

### Dodatkowe Tagi
- `#map` - Mapy i indeksy
- `#index` - Pliki indeksujące
- `#folder-note` - Folder notes
- `#profile` - Profile użytkowników
- `#wip` - Work in progress
- `#dev` - Development

## 🔗 System Backlinks

Każdy plik ma backlinki do:
1. **[[EWW-MAP]]** - Główna mapa
2. **Folder note** - Odpowiedni folder
3. **Powiązane pliki** - Logicznie związane dokumenty

### Przykład (README):
```yaml


related:
  - docs/EWW-MAP.md
  - docs/OBSIDIAN-SETUP.md
  - docs/Makefile.md
  - docs/obsidian-troubleshooting.md
  - docs/docs.md
backlinks:
  - "[[EWW-MAP|🗺️ Repository Map]]"
  - "[[docs/INDEX|📑 Documentation Index]]"
  - "[[CHANGELOG|📝 Changelog]]"
  - "[[Makefile|⚙️ Makefile]]"
```

## 📁 Struktura Folder Notes

Każdy folder note zawiera:

### 1. YAML Frontmatter
- title z emoji
- type: `folder-note`
- status: `active`
- tags (max 7)
- author
- daty (created, updated)

### 2. Sekcje
- 📋 **Przeznaczenie** - Co zawiera folder
- 📑 **Zawartość** - Lista plików z linkami
- 🔗 **Powiązania** - Backlinki
- 📊 **Struktura** - Drzewo katalogów
- 🎨 **Oznaczenie Grafu** - Tag i kolor

## 🚀 Jak Używać Grafu

### 1. Otwórz Graph View
```
Ctrl+G lub Command Palette → "Open graph view"
```

### 2. Filtrowanie
W polu wyszukiwania grafu:
```
tag:#jakubc          → Pokaż tylko pliki Jakuba (zielone)
tag:#karinam         → Pokaż tylko pliki Kariny (różowe)
tag:#candy           → To samo co karinam
tag:#core            → Rdzeń projektu (niebieski)
tag:#docs            → Dokumentacja (magenta)
```

### 3. Kombinacje
```
tag:#jakubc OR tag:#karinam    → Obaj użytkownicy
tag:#docs AND tag:#core        → Dokumentacja rdzenia
-tag:#wip                      → Bez work-in-progress
```

## 📊 Statystyki

### Pliki Utworzone
- 🗺️ Mapa główna: 1
- 📁 Folder notes: 8
- 👥 Profile: 2
- 📄 Dokumentacja: 3
- **Razem: 14 nowych plików**

### Pliki Zaktualizowane
- README.md - nowy frontmatter
- CHANGELOG.md - nowy frontmatter
- **Razem: 2 zaktualizowane**

### Konfiguracja Obsidian
- graph.json - kolory
- appearance.json - wygląd
- workspace.json - layout
- **Razem: 3 pliki config**

## ✅ Checklist Wdrożenia

- [x] Konfiguracja kolorów grafu (.obsidian/graph.json)
- [x] Główna mapa (EWW-MAP.md)
- [x] Folder notes dla wszystkich folderów
- [x] Profile użytkowników (jakubc, karinam)
- [x] Aktualizacja README i CHANGELOG
- [x] Dokumentacja Makefile
- [x] System tagów (7 głównych)
- [x] System backlinks
- [x] Kolory dla użytkowników (zielony, różowy)

## 🎯 Następne Kroki

### Teraz Możesz:
1. **Otworzyć Obsidian** w folderze `/home/jakubc/git/eww`
2. **Włączyć Graph View** (Ctrl+G)
3. **Zobaczyć kolorowy graf** - każdy obszar innym kolorem
4. **Filtrować po tagach** - `#jakubc`, `#karinam`, `#core`, etc.
5. **Nawigować wizualnie** - klikać w węzły grafu

### Opcjonalnie Rozszerzyć:
- [ ] Dodać więcej folder notes w podfolderach
- [ ] Uzupełnić profile użytkowników o więcej szczegółów
- [ ] Utworzyć notatki dla poszczególnych skryptów
- [ ] Dodać diagramy Mermaid w kluczowych miejscach
- [ ] Rozbudować system tagów o tagi specyficzne

## 🔍 Przykłady Użycia

### Znalezienie wszystkich plików Kariny
1. Otwórz Graph View
2. Wpisz: `tag:#candy`
3. Zobacz tylko różowe węzły (pliki Kariny)

### Zobacz strukturę dokumentacji
1. Otwórz [[docs/docs]]
2. Sprawdź backlinks (prawy panel)
3. Kliknij "Show graph view"

### Nawigacja od centrum
1. Otwórz [[EWW-MAP]]
2. Kliknij dowolny link
3. Użyj Alt+← do powrotu

## 📚 Dokumentacja Pomocnicza

- [[docs/OBSIDIAN-SETUP|💎 Obsidian Setup]] - Pełna konfiguracja
- [[docs/yaml-frontmatter-spec|📝 YAML Spec]] - Specyfikacja frontmatter
- [[docs/INDEX|📑 INDEX]] - Główny indeks dokumentacji


**Utworzone**: 2025-11-21  
**Autor**: [[usr/jakubc/jakubc|Jakub C]]  
**Status**: ✅ **GOTOWE DO UŻYCIA!**

#eww #graph #obsidian #map #summary
