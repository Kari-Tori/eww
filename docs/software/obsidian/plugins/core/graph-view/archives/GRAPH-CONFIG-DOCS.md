---
version: 0.0.4
tags:
  - #automation
  - #docs
  - #eww
  - #graph
  - #obsidian
  - #reference
created: 2025-11-21
modified: 2025-12-01
author: jakubc
title: "📊 Graph Config - Dokumentacja kolorów i grup"
owner: jakubc
---

# 📊 Graph Config - Dokumentacja kolorów i grup

> Konfiguracja grup kolorystycznych dla grafu Obsidian w E-Waste Workshop

## 🎨 Paleta kolorów (RGB → HEX)

### Obszary strukturalne

| Grupa | RGB | HEX | Opis |
|-------|-----|-----|------|
| `#folder_note` | 16777215 | `#FFFFFF` | Folder notes - białe (najważniejsze) |
| `#core` | 65331 | `#00FF33` | Core - zielony neon |
| `#config` | 5526612 | `#545454` | Config - szary |
| `#business` | 2664719 | `#28A30F` | Business - zielony |
| `#docs` | 1334271 | `#145CFF` | Docs - niebieski |
| `#infra` | 16737792 | `#FF5000` | Infra - pomarańczowy |
| `#scripts` | 10944256 | `#A70000` | Scripts - bordowy |
| `#tools` | 6287 | `#00188F` | Tools - granatowy |

### Użytkownicy

| Grupa | RGB | HEX | Opis |
|-------|-----|-----|------|
| `#jakubc` | 16711680 | `#FF0000` | Jakub - czerwony |
| `#karinam` | 16711935 | `#FF00FF` | Karina - magenta |

### Projekty użytkowników

| Grupa | RGB | HEX | Opis |
|-------|-----|-----|------|
| `#star-wars` | 65484 | `#00FFCC` | Star Wars - cyan jasny |
| `#lego` | 16771584 | `#FFEA00` | Lego - żółty |
| `#avocado` | 5664799 | `#567A1F` | Avocado - oliwkowy |
| `#secondbrain` | 9394928 | `#8F5AF0` | Second Brain - fioletowy |

### Hardware

| Grupa | RGB | HEX | Opis |
|-------|-----|-----|------|
| `#GERC` | 870305 | `#0D47A1` | GERC - niebieski ciemny |
| `#Asus_Z77` | 12604881 | `#C055D1` | Asus Z77 - fiolet |

## 🔧 Konfiguracja graph.json

### Optymalne ustawienia wydajności

```json
{
  "linkDistance": 314,      // Dystans między węzłami (250-350)
  "repelStrength": 20,      // Siła odpychania (15-25)
  "centerStrength": 0.125,  // Siła przyciągania do centrum (0.1-0.5)
  "linkStrength": 0.734,    // Siła połączeń (0.5-1.0)
  "nodeSizeMultiplier": 1.63,
  "lineSizeMultiplier": 1.12,
  "textFadeMultiplier": 0.2
}
```

### Wykluczenia (graph-exclude.json)

**Foldery**:
- `archive/` - stare dane
- `var/` - runtime data
- `usr/` - vaults użytkowników
- `Tags/` - taksonomia
- `.obsidian/plugins/`, `.obsidian/themes/`
- `.git/`, `node_modules/`, `.venv/`

**Wzorce**:
- `*/archive/*`, `*/backup/*`, `*/old/*`
- `*-conflict-*`, `*.backup.*`, `*-OLD.*`
- `FULL-INDEX.md`, `INDEX.md`

## 📋 Grupy kolorystyczne (query)

### Priorytet 1: Folder Notes (biały)
```
tag:#folder_note
```

### Priorytet 2: Obszary strukturalne
```
tag:#core OR path:core/
tag:#config OR path:config/
tag:#business OR path:business/
tag:#docs OR path:docs/
tag:#infra OR path:infra/
tag:#scripts OR path:scripts/
tag:#tools OR path:tools/
```

### Priorytet 3: Użytkownicy
```
tag:#jakubc OR path:usr/jakubc/
tag:#karinam OR path:usr/karinam/
```

### Priorytet 4: Projekty
```
tag:#star-wars OR path:usr/jakubc/hobby/star_wars/
tag:#lego OR path:usr/jakubc/hobby/lego/
tag:#avocado OR path:docs/archive/avocado/
tag:#secondbrain OR path:dev/Projects/Secondbrain/
```

## 🎯 Użycie

### Global Graph (Ctrl+G)
1. Filtr: `-path:archive -path:var -path:usr -path:Tags`
2. Rendering: ~30s dla 490 plików
3. Użyj do: Ogólny przegląd

### Local Graph (prawy panel)
1. Otwórz folder note → kliknij "Open local graph"
2. Depth: 2 levels
3. Rendering: <1s
4. Użyj do: Szczegółowa nawigacja

### Tematyczne grafy
- [[GRAPH-CORE]] - tylko `path:core/`
- [[GRAPH-BUSINESS]] - tylko `path:business/`
- [[GRAPH-CONFIG]] - tylko `path:config/ OR path:infra/`
- [[GRAPH-USERS]] - tylko `path:usr/`

## 🔗 Powiązania

- [graph.json](graph.json) - główna konfiguracja
- [graph-colors.json](graph-colors.json) - paleta kolorów (legacy)
- [graph-exclude.json](graph-exclude.json) - wykluczenia
- [[GRAPH-SETUP]] - instrukcja konfiguracji
- [[GRAPH-OPTIMIZATION]] - strategie optymalizacji

## 📝 Notatki

- **RGB to HEX**: `#RRGGBB` gdzie każdy komponent to `00-FF`
- **Konwersja**: `RGB = (R << 16) | (G << 8) | B`
- **Priorytet**: Pierwsza pasująca grupa wygrywa
- **Performance**: <500 nodes = płynny, >1000 = wolny

---

> [!TIP] Pro Tip
> Używaj Local Graph dla codziennej pracy, Global Graph tylko dla overview.

*Ostatnia aktualizacja*: 2025-11-21T20:20:00Z

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]