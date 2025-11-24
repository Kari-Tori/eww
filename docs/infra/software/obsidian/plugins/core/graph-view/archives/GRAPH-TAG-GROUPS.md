---
tags:
  - #automation
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
title: Graph Tag Groups - Konfiguracja Kolorów
created: 2025-11-21
updated: 2025-11-21
author: jakubc






owner: jakubc
---

# 🎨 Graph Tag Groups - Konfiguracja Kolorów

## 📊 Przegląd 12 Grup Tagowych

Vault **eww** używa 12 głównych grup tagowych do wizualizacji grafu:

### 1️⃣ **#eww** - 🟢 Neonowy Zielony
- **Kolor**: `#00FF41` (RGB: 65345)
- **Zakres**: Core repo - docs/, config/, business/, core/
- **Pliki**: ~50 plików głównych
- **Cel**: Fundament repozytorium

### 2️⃣ **#jakubc** - 🔴 Neonowy Czerwony
- **Kolor**: `#FF0040` (RGB: 16711744)
- **Zakres**: usr/jakubc/ + wszystkie podfoldery
- **Pliki**: ~119 plików
- **Cel**: Osobiste notatki użytkownika jakubc

### 3️⃣ **#karinam** - 💕 Candy Pink
- **Kolor**: `#FF69B4` (RGB: 16738740)
- **Zakres**: usr/karinam/ + wszystkie podfoldery
- **Pliki**: ~6 plików
- **Cel**: Osobiste notatki użytkownika karinam

### 4️⃣ **#star-wars** - ⭐ Żółty
- **Kolor**: `#FFD700` (RGB: 16766720)
- **Zakres**: usr/jakubc/star_wars/ + lego star wars
- **Pliki**: ~30+ plików
- **Cel**: Projekty Star Wars (vehicles, races, ships, droids, fractions)

### 5️⃣ **#recycling** - 🟢 Ciemny Zielony
- **Kolor**: `#228B22` (RGB: 2263842)
- **Zakres**: Projekty e-waste, WEEE, recycling
- **Pliki**: ~15 plików
- **Cel**: Projekty związane z recyklingiem elektroniki

### 6️⃣ **#avocado** - 🥑 Avocado Green
- **Kolor**: `#568203` (RGB: 5669379)
- **Zakres**: docs/archive/avocado/, projekty avocado
- **Pliki**: ~5 plików
- **Cel**: Projekty związane z awokado (SOP, hodowla)

### 7️⃣ **#ai-study** - 🔵 Niebieski Neon
- **Kolor**: `#00BFFF` (RGB: 49407)
- **Zakres**: usr/jakubc/Study/AI/, chipset, soc, mobile
- **Pliki**: ~20 plików
- **Cel**: Studia AI, architektura procesorów, PKM

### 8️⃣ **#obsidian-tools** - 🟣 Fioletowy
- **Kolor**: `#9370DB` (RGB: 9662683)
- **Zakres**: obsidian-plugins/, git, workflow, automation
- **Pliki**: ~10 plików
- **Cel**: Narzędzia Obsidian, workflow, konfiguracja

### 9️⃣ **#dev** - 🟠 Pomarańczowy
- **Kolor**: `#FF8C00` (RGB: 16747520)
- **Zakres**: dev/ (ansible, playbooks, bash, systemd)
- **Pliki**: ~80 plików
- **Cel**: Development, DevOps, skrypty, automatyzacja

### 🔟 **#health** - 💚 Miętowy
- **Kolor**: `#00FA9A` (RGB: 64154)
- **Zakres**: usr/jakubc/health/, digestion
- **Pliki**: ~5 plików
- **Cel**: Zdrowie, dieta, well-being

### 1️⃣1️⃣ **#lego** - 🟡 Jasny Żółty
- **Kolor**: `#FFFF00` (RGB: 16776960)
- **Zakres**: LEGO MOC, builds, BOM, roadmaps
- **Pliki**: ~10 plików
- **Cel**: Projekty LEGO (overlap z #star-wars dla SW sets)

### 1️⃣2️⃣ **#business** - 💼 Granatowy
- **Kolor**: `#1E90FF` (RGB: 2003199)
- **Zakres**: business/, finanse, ecommerce, workflow
- **Pliki**: ~25 plików
- **Cel**: Biznes, finanse, integracje (Odoo, eBay)

---

## 🎯 Zasady Tagowania

### Auto-tagowanie
- **Maksymalnie 7 tagów** na plik
- **Hierarchia**: Najpierw grupa główna (#eww, #jakubc, #karinam)
- **Tematyka**: Następnie tagi tematyczne (#star-wars, #ai-study, #lego)
- **Narzędzia**: Na końcu tagi narzędziowe (#obsidian-tools, #dev)

### Przykłady:
```yaml
# Plik core repo
tags: [eww, docs, graph, config]

# Plik użytkownika jakubc
tags: [jakubc, star-wars, lego, moc, set-7680]

# Plik użytkownika karinam
tags: [karinam, health, digestion]

# Plik development
tags: [eww, dev, ansible, playbooks, bash]
```

---

## 🔧 Konfiguracja Techniczna

### Konwersja Kolory

Kolory w `graph.json` używają RGB w formacie dziesiętnym:

| Grupa | Hex | RGB Decimal | Zastosowanie |
|-------|-----|-------------|--------------|
| #eww | #00FF41 | 65345 | Core repo |
| #jakubc | #FF0040 | 16711744 | Użytkownik jakubc |
| #karinam | #FF69B4 | 16738740 | Użytkownik karinam |
| #star-wars | #FFD700 | 16766720 | Star Wars projekty |
| #recycling | #228B22 | 2263842 | E-waste |
| #avocado | #568203 | 5669379 | Avocado projekty |
| #ai-study | #00BFFF | 49407 | AI & Chipset |
| #obsidian-tools | #9370DB | 9662683 | Obsidian tools |
| #dev | #FF8C00 | 16747520 | Development |
| #health | #00FA9A | 64154 | Zdrowie |
| #lego | #FFFF00 | 16776960 | LEGO builds |
| #business | #1E90FF | 2003199 | Biznes |

### Formuła konwersji:
```
RGB Decimal = (R * 65536) + (G * 256) + B
Przykład #FF69B4:
(255 * 65536) + (105 * 256) + 180 = 16738740
```

---

## 📈 Statystyki Tagowania

| Grupa | Pliki | % z całości (490) |
|-------|-------|-------------------|
| #eww | ~50 | 10% |
| #jakubc | ~119 | 24% |
| #karinam | ~6 | 1% |
| #star-wars | ~30 | 6% |
| #recycling | ~15 | 3% |
| #avocado | ~5 | 1% |
| #ai-study | ~20 | 4% |
| #obsidian-tools | ~10 | 2% |
| #dev | ~80 | 16% |
| #health | ~5 | 1% |
| #lego | ~10 | 2% |
| #business | ~25 | 5% |
| **Inne** | ~115 | 23% |

---

## 🚀 Next Steps

1. **Auto-tagowanie**: Skrypt do automatycznego dodawania tagów bazując na ścieżce
2. **Walidacja**: Sprawdzenie czy wszystkie pliki mają odpowiednie tagi
3. **Deduplikacja**: Usunięcie tagów nadmiarowych (>7)
4. **Graph Performance**: Optymalizacja dla 490 plików

---

## 📚 Źródła

- [[graph.json]] - Główna konfiguracja grafu
- [[GRAPH-FIX-INSTRUCTIONS.md]] - Instrukcje optymalizacji
- [[TAG-STRATEGY.md]] - Strategia tagowania (jeśli istnieje)

## 🔗 Backlinks

- [[eww.md]] - Główny vault note
- [[FULL-INDEX.md]] - Kompletny indeks
- [[docs.md]] - Dokumentacja

---

**Autor**: jakubc  
**Created**: 2025-11-21  
**Updated**: 2025-11-21  
**Status**: ✅ Active
