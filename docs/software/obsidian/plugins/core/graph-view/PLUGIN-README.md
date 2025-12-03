---
version: 0.0.1
modified: 2025-11-28
title: Graph View - Oficjalna dokumentacja wtyczki
source: https://help.obsidian.md/Plugins/Graph+view
translated: true
language: pl
created: 2025-11-28
author: Obsidian (tłumaczenie: AI)
tags:
  - obsidian
  - plugin
  - core
  - graph-view
  - documentation
---

# Graph View - Wtyczka rdzenia Obsidian

Graph View (Widok Grafu) to wtyczka rdzenia (CORE) w Obsidian, która wizualizuje połączenia między notatkami w formie grafu sieciowego.

## 📋 Spis treści

1. [O wtyczce](#o-wtyczce)
2. [Funkcje](#funkcje)
3. [Interfejs użytkownika](#interfejs-użytkownika)
4. [Filtry](#filtry)
5. [Grupy kolorów](#grupy-kolorów)
6. [Siły fizyki](#siły-fizyki)
7. [Wyświetlanie](#wyświetlanie)
8. [Local Graph](#local-graph)
9. [Wydajność](#wydajność)
10. [Rozwiązywanie problemów](#rozwiązywanie-problemów)

---

## O wtyczce

**Graph View** to jedna z najpotężniejszych funkcji Obsidian, pozwalająca na wizualizację całego vault jako interaktywnego grafu węzłów i połączeń.

### Kluczowe cechy:

- **Wizualizacja połączeń** - każda notatka to węzeł (node), każdy link to krawędź (edge)
- **Interaktywność** - możliwość klikania, przeciągania, zoomowania
- **Filtry wyszukiwania** - pokazuj tylko wybrane części grafu
- **Grupy kolorów** - koloruj węzły według ścieżek, tagów, itp.
- **Silnik fizyki** - symulacja fizyczna dla automatycznego układania węzłów
- **Local Graph** - lokalny widok grafu dla pojedynczej notatki

---

## Funkcje

### 1. Global Graph

**Global Graph** pokazuje wszystkie notatki w vault i połączenia między nimi.

**Otwórz Global Graph:**
- Ikona w lewym pasku bocznym (graph icon)
- Command Palette: `Open graph view`
- Skrót: `Ctrl/Cmd + G` (może być różny w zależności od ustawień)

### 2. Local Graph

**Local Graph** pokazuje tylko notatki połączone z aktualnie otwartą notatką.

**Otwórz Local Graph:**
- Right-click na notatce → `Open local graph`
- Command Palette: `Open local graph`
- Przycisk w edytorze (jeśli włączony)

**Głębokość (Depth):**
- 1 level: tylko bezpośrednie połączenia
- 2 levels: połączenia + połączenia połączeń
- 3 levels: itd.

---

## Interfejs użytkownika

### Panel kontrolny

Po otwarciu Graph View, po prawej stronie znajduje się panel kontrolny z następującymi sekcjami:

1. **Filters** - filtrowanie węzłów
2. **Groups** - grupy kolorów
3. **Display** - opcje wyświetlania
4. **Forces** - siły fizyki

### Nawigacja

- **Scroll** - zoom in/out
- **Drag** - przeciągnij canvas
- **Click node** - otwórz notatkę
- **Drag node** - przesuń węzeł
- **Ctrl/Cmd + Click** - otwórz w nowym panelu

---

## Filtry

### Search

Pole wyszukiwania w górnej części panelu umożliwia filtrowanie węzłów:

**Podstawowe:**
```
# Pokaż tylko notatki zawierające "projekt"
projekt

# Pokaż notatki z tagiem #important
tag:#important

# Pokaż pliki w folderze docs
path:docs
```

**Zaawansowane:**
```
# AND (wszystkie warunki muszą być spełnione)
tag:#important path:projects

# OR (dowolny warunek)
tag:#important OR tag:#urgent

# NOT (wykluczenie)
-path:archive

# Kombinacje
(tag:#project OR tag:#idea) -path:archive
```

**Typy zapytań:**

| Operator | Opis | Przykład |
|----------|------|----------|
| `file:` | Nazwa pliku | `file:README` |
| `path:` | Ścieżka | `path:docs/projects` |
| `tag:` | Tag | `tag:#important` |
| `line:` | Zawartość linii | `line:"TODO"` |
| `-` | Negacja | `-path:archive` |
| `OR` | Alternatywa | `tag:#a OR tag:#b` |

### Filtry przełączalne

**Checkboxy w sekcji Filters:**

- **Files** - pokaż pliki (notatki .md)
- **Attachments** - pokaż załączniki (obrazy, PDF)
- **Existing files only** - ukryj nieistniejące linki (wikilinks bez pliku)
- **Orphans** - pokaż notatki bez żadnych połączeń
- **Tags** - pokaż tagi jako węzły

---

## Grupy kolorów

Grupy kolorów pozwalają na wizualne oznaczenie różnych typów węzłów.

### Dodawanie grupy

1. Kliknij **New group**
2. Wpisz query (np. `path:docs`)
3. Wybierz kolor

### Przykłady grup

**Według folderu:**
```
path:projects    # Wszystkie pliki w projects/
path:archive     # Wszystkie pliki w archive/
path:usr/karinam # Twoje pliki użytkownika
```

**Według tagu:**
```
tag:#important
tag:#todo
tag:#folder_note
```

**Według typu:**
```
file:README      # Wszystkie pliki README
file:INDEX       # Wszystkie pliki INDEX
```

**Kombinacje:**
```
path:docs OR tag:#documentation
(tag:#project OR tag:#idea) -path:archive
```

### Kolejność grup

Grupy są aplikowane **od góry do dołu**. Jeśli węzeł pasuje do wielu grup, zostanie użyty kolor z **pierwszej pasującej grupy**.

**Tip:** Umieszczaj bardziej specyficzne grupy na górze!

---

## Siły fizyki

Silnik fizyki automatycznie układa węzły, symulując siły przyciągania i odpychania.

### Parametry

| Parametr | Opis | Wartość domyślna | Zakres |
|----------|------|------------------|--------|
| **Center force** | Siła przyciągania do centrum | 0.3 | 0.0 - 1.0 |
| **Repel strength** | Siła odpychania między węzłami | 10 | 0 - 50 |
| **Link strength** | Siła przyciągania wzdłuż linków | 0.7 | 0.0 - 1.0 |
| **Link distance** | Docelowa odległość między połączonymi węzłami | 250 | 50 - 500 |

### Optymalizacja dla różnych rozmiarów vault

**Mały vault (<100 plików):**
```json
{
  "centerStrength": 0.5,
  "repelStrength": 8,
  "linkStrength": 0.8,
  "linkDistance": 200
}
```

**Średni vault (100-500 plików):**
```json
{
  "centerStrength": 0.3,
  "repelStrength": 12,
  "linkStrength": 0.6,
  "linkDistance": 250
}
```

**Duży vault (500-1000 plików):**
```json
{
  "centerStrength": 0.2,
  "repelStrength": 18,
  "linkStrength": 0.5,
  "linkDistance": 300
}
```

**Bardzo duży vault (>1000 plików):**
```json
{
  "centerStrength": 0.1,
  "repelStrength": 25,
  "linkStrength": 0.3,
  "linkDistance": 400
}
```

---

## Wyświetlanie

### Parametry wizualne

| Parametr | Opis | Efekt |
|----------|------|-------|
| **Node size** | Rozmiar węzłów | Większe = łatwiej klikać, ale większy clutter |
| **Line thickness** | Grubość linków | Cieńsze = mniej GPU load |
| **Arrows** | Strzałki kierunkowe | Wyłączone = lepsze FPS |
| **Text fade threshold** | Próg zanikania tekstu | Wyższy = mniej tekstu = lepsze FPS |
| **Text size** | Rozmiar czcionki | - |

### Optymalizacja wydajności

**Dla lepszego FPS:**
- ❌ Arrows: OFF
- 📉 Node size: 0.6 - 0.8
- 📉 Line thickness: 0.3 - 0.5
- 📈 Text fade threshold: 1 - 2

**Dla lepszej czytelności:**
- ✅ Arrows: ON
- 📈 Node size: 1.0 - 1.5
- 📈 Line thickness: 0.8 - 1.2
- 📉 Text fade threshold: -1 (zawsze widoczne)

---

## Local Graph

Local Graph to uproszczona wersja Global Graph, pokazująca tylko bezpośrednie sąsiedztwo aktualnej notatki.

### Ustawienia

**Depth (Głębokość):**
- 1: Tylko bezpośrednie linki
- 2: Linki + linki linków
- 3: Itd.

**Incoming links:** Pokaż linki przychodzące (backlinks)
**Outgoing links:** Pokaż linki wychodzące

### Zalety Local Graph

✅ **Szybki** - renderuje <100 węzłów
✅ **Kontekstowy** - pokazuje tylko istotne połączenia
✅ **Zawsze płynny** - nawet dla dużych vault

**Użyj Local Graph gdy:**
- Vault ma >1000 plików
- Global Graph laguje
- Potrzebujesz szczegółów konkretnego pliku

---

## Wydajność

### Limity techniczne

| Vault size | Nodes | Render time | FPS | Status |
|------------|-------|-------------|-----|--------|
| <100 | <100 | <1s | 60 | ✅ Doskonały |
| 100-500 | 100-500 | 1-3s | 30-60 | ✅ Bardzo dobry |
| 500-1000 | 500-1000 | 3-10s | 15-30 | ⚠️ Akceptowalny |
| 1000-2000 | 1000-2000 | 10-30s | 5-15 | ⚠️ Wolny |
| >2000 | >2000 | 30s+ | <5 | ❌ Nieużywalny |

### Bottlenecks

1. **Liczba węzłów** (nodes)
   - Każdy węzeł = obliczenia physics
   - Każdy węzeł = renderowanie GPU

2. **Liczba linków** (edges)
   - Każdy link = obliczenia przyciągania
   - Każdy link = renderowanie linii

3. **Color groups**
   - Każda grupa = dodatkowe query per node
   - 14 grup × 2000 nodes = 28,000 obliczeń per frame!

4. **Text rendering**
   - Tekst = heavy GPU load
   - `textFadeMultiplier` pomaga

### Optymalizacje

**1. Użyj filtrów:**
```
-path:archive -path:inbox -path:.trash
```

**2. Ukryj niepotrzebne:**
- Attachments: OFF
- Orphans: OFF
- Unresolved: OFF

**3. Zmniejsz physics:**
```json
{
  "linkStrength": 0.2,
  "centerStrength": 0.05,
  "repelStrength": 30
}
```

**4. Zmniejsz visual load:**
```json
{
  "showArrow": false,
  "textFadeMultiplier": 2,
  "nodeSizeMultiplier": 0.7,
  "lineSizeMultiplier": 0.4
}
```

**5. Collapse color groups:**
- Settings → collapse-color-groups: true

---

## Rozwiązywanie problemów

### Problem: Graf laguje / freeze

**Diagnoza:**
```bash
# Policz pliki .md w vault
find . -name "*.md" | wc -l

# Sprawdź filtry w graph.json
cat .obsidian/graph.json | jq '.search'
```

**Rozwiązania:**
1. Dodaj exclude filter dla inbox/archive
2. Użyj Local Graph zamiast Global
3. Zmniejsz `graphMaxFileCount` w `app.json`
4. Wyłącz color groups
5. Zmniejsz physics iterations

### Problem: Za dużo węzłów

**Strategie:**

1. **Multi-Graph Strategy** - wiele małych grafów zamiast jednego dużego:
   - Graf dla `core/`
   - Graf dla `docs/`
   - Graf dla `business/`
   - itp.

2. **Exclude paths:**
   ```
   -path:archive -path:inbox -path:.trash -path:.stversions
   ```

3. **Filter by tag:**
   ```
   tag:#active OR tag:#project
   ```

### Problem: Nieczytelny graf

**Rozwiązania:**
1. Zwiększ `linkDistance` (większy rozstaw)
2. Zwiększ `repelStrength` (większe separacje)
3. Zmniejsz `centerStrength` (bardziej rozrzucone)
4. Użyj grup kolorów dla orientacji

### Problem: Brak płynności (low FPS)

**Quick fixes:**
1. Arrows: OFF
2. `textFadeMultiplier: 2`
3. `nodeSizeMultiplier: 0.6`
4. `lineSizeMultiplier: 0.3`
5. Collapse color groups

---

## Konfiguracja plików

### graph.json

Lokalizacja: `.obsidian/graph.json`

**Struktura:**
```json
{
  "collapse-filter": false,
  "search": "",
  "showTags": true,
  "showAttachments": true,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "path:docs",
      "color": {
        "a": 1,
        "rgb": 16777215
      }
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1,
  "lineSizeMultiplier": 1,
  "collapse-forces": false,
  "centerStrength": 0.3,
  "repelStrength": 10,
  "linkStrength": 0.7,
  "linkDistance": 250,
  "scale": 1.0
}
```

### app.json

Lokalizacja: `.obsidian/app.json`

**Graph settings:**
```json
{
  "graphMaxFileCount": 5000
}
```

**Limity:**
- Teoretyczny max: 5000 nodes
- Praktyczny max: ~1200 nodes (zależy od hardware)
- Zalecany: <800 nodes dla płynności

---

## Zaawansowane użycie

### 1. Timeline visualization

Koloruj węzły według dat Git:

**CSS snippet:**
```css
/* Nowe pliki (0-7 dni) */
.graph-view.color-fill[data-age-days*="0"] {
  filter: brightness(1.5) drop-shadow(0 0 12px currentColor);
  animation: newNode 3s ease-in-out infinite;
}

/* Stare pliki */
.graph-view.color-fill[data-age-days*="30"] {
  opacity: 0.6;
}
```

### 2. Author borders

Koloruj borders według autora:

```css
/* Jakub - niebieski */
.graph-view.color-fill[data-author*="jakubc"] {
  stroke: #3b82f6 !important;
  stroke-width: 3px !important;
}

/* Karina - różowy */
.graph-view.color-fill[data-author*="karinam"] {
  stroke: #ec4899 !important;
  stroke-width: 3px !important;
}
```

### 3. Clustering

Grupuj węzły według typu:

**Color groups:**
1. Folder notes (README/INDEX) - białe
2. Business - zielone
3. Docs - niebieskie
4. Dev - granatowe
5. Archive - czarne

### 4. Multi-preset strategy

Przełączanie między różnymi widokami:

```bash
# Skrypt do zmiany presetów
#!/bin/bash
PRESET=$1

case $PRESET in
  "core")
    FILTER="path:core -path:core/inbox"
    ;;
  "docs")
    FILTER="path:docs -path:docs/archive"
    ;;
  "all")
    FILTER=""
    ;;
esac

jq --arg filter "$FILTER" '.search = $filter' .obsidian/graph.json > tmp.json
mv tmp.json .obsidian/graph.json
```

---

## Best Practices

### 1. Dla małych vault (<500 plików)

✅ Użyj Global Graph
✅ Włącz wszystkie features
✅ Piękne, szczegółowe kolory
✅ Animacje i efekty

### 2. Dla średnich vault (500-1000 plików)

✅ Użyj filtrów do fokusowania
✅ Collapse color groups
✅ Zmniejsz physics
⚠️ Wyłącz arrows

### 3. Dla dużych vault (>1000 plików)

✅ Multi-Graph Strategy (wiele małych grafów)
✅ Użyj Local Graph do szczegółów
✅ Extreme performance mode
❌ Unikaj Global Graph z wszystkimi nodes

### 4. Folder structure

Organizuj vault tak, aby można było łatwo filtrować:

```
vault/
├── core/          # Config, systemd, workflows
├── business/      # Business content
├── docs/          # Documentation
├── dev/           # Development
├── usr/           # User files
│   ├── karinam/
│   └── jakubc/
└── archive/       # Old files (wykluczony z grafu)
```

---

## FAQ

### Czy mogę mieć >5000 nodes?

Nie. `graphMaxFileCount` ma twardy limit 5000 w Obsidian.

### Dlaczego Local Graph jest szybszy?

Local Graph renderuje tylko 2-3 levels connections (~50-200 nodes), zamiast wszystkich nodes w vault.

### Czy mogę wyłączyć physics całkowicie?

Nie bezpośrednio, ale możesz ustawić siły na minimum:
```json
{
  "linkStrength": 0.01,
  "centerStrength": 0.01
}
```

### Jak przywrócić domyślne ustawienia?

Usuń `.obsidian/graph.json` - zostanie odtworzony przy następnym otwarciu.

### Czy graf jest interaktywny w Obsidian Publish?

Tak, ale tylko statyczny snapshot. Nie ma live physics.

---

## Zobacz też

- [graph-view-plan.md](graph-view-plan.md) - Plan zaawansowanych funkcji
- [graph-view-limits.md](graph-view-limits.md) - Limity techniczne i workarounds
- [graph-view-next.md](graph-view-next.md) - Przyszłe możliwości
- [installation-guide.md](installation-guide.md) - Instalacja custom grafów

---

**Źródło:** https://help.obsidian.md/Plugins/Graph+view  
**Tłumaczenie:** AI (2025-11-27)  
**Wersja Obsidian:** 1.5+  
**Status:** CORE plugin (zawsze dostępny)

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]