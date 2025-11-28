---
tags:
  - #automation
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21
author: jakubc
status: active






owner: jakubc
---

# 🎨 Graph Groups - Finalna Konfiguracja Kolorów

## 📊 TOP 15 GRUP TAGÓW (z kolorami)

### 🎯 Główne grupy repozytorium

| Nr | Tag | Kolor | Hex | Znaczenie | Pliki |
|----|-----|-------|-----|-----------|-------|
| 1 | `#eww` | 🟢 Neon Green | `#00ff00` | Core repo (docs, config, business, core) | ~337 |
| 2 | `#work` | 🔵 Electric Blue | `#00aaff` | Projekty zawodowe | ~481 |
| 3 | `#jakubc` | 🔴 Neon Red | `#ff0033` | Profile użytkownika jakubc | ~118 |
| 4 | `#karinam` | 💗 Candy Pink | `#ff66cc` | Profile użytkownika karinam | ~50 |
| 5 | `#project` | 🟣 Purple | `#9933ff` | Wszystkie projekty | ~368 |

### 📚 Grupy dokumentacji

| Nr | Tag | Kolor | Hex | Znaczenie | Pliki |
|----|-----|-------|-----|-----------|-------|
| 6 | `#docs` | 🟡 Yellow | `#ffcc00` | Dokumentacja techniczna | ~272 |
| 7 | `#knowledge` | 🟠 Orange | `#ff9900` | Baza wiedzy | ~340 |
| 8 | `#notes` | ⚪ Light Gray | `#cccccc` | Notatki ogólne | ~461 |
| 9 | `#documentation` | 🟤 Brown | `#996633` | Dokumenty formalne | ~271 |

### 🎭 Grupy specjalne

| Nr | Tag | Kolor | Hex | Znaczenie | Pliki |
|----|-----|-------|-----|-----------|-------|
| 10 | `#star-wars` | ⭐ Gold | `#ffd700` | Grupa Star Wars | ~49 |
| 11 | `#recycling` | 🟢 Dark Green | `#006600` | Projekty recykling | ~30 |
| 12 | `#lego` | 🟥 Red | `#cc0000` | Projekty LEGO | ~20 |
| 13 | `#avocado` | 🥑 Avocado | `#568203` | Projekty Avocado | ~15 |

### 🏢 Grupy organizacyjne

| Nr | Tag | Kolor | Hex | Znaczenie | Pliki |
|----|-----|-------|-----|-----------|-------|
| 14 | `#workspace` | 🔷 Cyan | `#00ffff` | Przestrzeń robocza | ~123 |
| 15 | `#personal` | 🟪 Magenta | `#ff00ff` | Projekty osobiste | ~123 |

---

## 🎨 Konfiguracja Graph.json

```json
{
  "colorGroups": [
    {
      "query": "tag:#eww",
      "color": {
        "a": 1,
        "rgb": 65280
      }
    },
    {
      "query": "tag:#work",
      "color": {
        "a": 1,
        "rgb": 43775
      }
    },
    {
      "query": "tag:#jakubc",
      "color": {
        "a": 1,
        "rgb": 16711731
      }
    },
    {
      "query": "tag:#karinam",
      "color": {
        "a": 1,
        "rgb": 16737484
      }
    },
    {
      "query": "tag:#project",
      "color": {
        "a": 1,
        "rgb": 10038271
      }
    },
    {
      "query": "tag:#docs",
      "color": {
        "a": 1,
        "rgb": 16764928
      }
    },
    {
      "query": "tag:#knowledge",
      "color": {
        "a": 1,
        "rgb": 16750848
      }
    },
    {
      "query": "tag:#notes",
      "color": {
        "a": 1,
        "rgb": 13421772
      }
    },
    {
      "query": "tag:#documentation",
      "color": {
        "a": 1,
        "rgb": 10052147
      }
    },
    {
      "query": "tag:#star-wars",
      "color": {
        "a": 1,
        "rgb": 16766720
      }
    },
    {
      "query": "tag:#recycling",
      "color": {
        "a": 1,
        "rgb": 26112
      }
    },
    {
      "query": "tag:#lego",
      "color": {
        "a": 1,
        "rgb": 13369344
      }
    },
    {
      "query": "tag:#avocado",
      "color": {
        "a": 1,
        "rgb": 5669379
      }
    },
    {
      "query": "tag:#workspace",
      "color": {
        "a": 1,
        "rgb": 65535
      }
    },
    {
      "query": "tag:#personal",
      "color": {
        "a": 1,
        "rgb": 16711935
      }
    }
  ]
}
```

---

## 🔧 Zastosowanie

### Automatyczne tagowanie
Każdy plik w repo otrzyma 7 tagów:
1. **Tag główny** - podstawowa kategoria (#eww, #work, #project)
2. **Tag użytkownika** - #jakubc lub #karinam (jeśli dotyczy)
3. **Tag typu** - #docs, #notes, #knowledge
4. **Tag projektu** - #star-wars, #recycling, #lego, #avocado
5. **Tag organizacyjny** - #workspace, #personal
6. **Tag statusu** - #active, #archived, #wip
7. **Tag dodatkowy** - specyficzny dla zawartości

### Priorytety kolorów
Graf wyświetla kolor według pierwszego pasującego tagu w kolejności:
1. Tagi specjalne (#star-wars, #recycling, #lego, #avocado)
2. Tagi użytkowników (#jakubc, #karinam)
3. Tagi główne (#eww, #work, #project)
4. Tagi dokumentacji (#docs, #knowledge, #notes)
5. Tagi organizacyjne (#workspace, #personal)

---

## 📈 Statystyki

- **Całkowita liczba plików MD**: 515
- **Pliki z 7 tagami**: 242 (47%)
- **Pliki do aktualizacji**: 273 (53%)
- **Grupy kolorów**: 15
- **Pokrycie tagami**: TOP 15 tagów = ~90% wszystkich plików

---

## ✅ Status
- [x] TOP 15 tagów zidentyfikowane
- [x] Kolory przypisane (neonowe, wyraziste)
- [x] Konfiguracja Graph.json przygotowana
- [ ] Zastosowanie na wszystkich plikach
- [ ] Test renderowania grafu

## 🔗 Powiązane
- [[graph.json]] - plik konfiguracji Obsidian
- [[GRAPH-TAG-GROUPS]] - poprzednia wersja grup
- [[OBSIDIAN-GIT-CONFIG]] - konfiguracja Git

## 📚 Źródła
- Analiza repo: `/tmp/top-tags-analysis.sh`
- Obsidian Graph View docs
- Custom color groups guide

---

*Wygenerowano: 2025-11-21 | Autor: jakubc | EWW Repo*
