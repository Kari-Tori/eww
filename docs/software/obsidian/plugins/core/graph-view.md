---
tags:
  - #obsidian
  - #graph
  - #plugin
  - #core
  - #docs
created: 2025-11-22T19:40:00Z
modified: 2025-11-22T19:40:00Z
author: jakubc
title: "Graph View - Core Plugin"
plugin_type: core
plugin_name: "Graph view"
owner: jakubc
---

# Graph View - Core Plugin

Graf wiedzy (Graph View) to jeden z kluczowych **core plugins** w Obsidian, który wizualizuje połączenia między notatkami jako interaktywny graf.

## 📋 Informacje podstawowe

- **Typ:** Core Plugin (wbudowany)
- **ID:** `graph`
- **Nazwa:** Graph view
- **Status:** Aktywny domyślnie
- **Wymaga:** Obsidian v0.9.0+

## ✨ Funkcje

### 🎨 Wizualizacja
- **Interaktywny graf 2D** - wszystkie notatki jako węzły (nodes)
- **Linki jako krawędzie** - połączenia między notatkami
- **Zoom i pan** - nawigacja myszką/touchpad
- **Hover info** - podgląd nazwy notatki
- **Click to open** - kliknięcie otwiera notatkę

### 🎯 Filtry
- **Search** - filtrowanie po tytule/treści
- **Tags** - pokazuj/ukryj tagi
- **Attachments** - pokazuj/ukryj załączniki
- **Orphans** - pokazuj/ukryj sieroty (bez linków)
- **Path filter** - filtruj po ścieżce (folder)

### 🎨 Color Groups
Kolorowanie węzłów według:
- **Tagów** - `tag:#nazwa`
- **Ścieżek** - `path:folder/`
- **Kombinacji** - `tag:#foo OR path:bar/`

Szczegóły: [[graph/graph-rules]]

### ⚙️ Forces (Fizyka grafu)
- **Center Strength** - siła przyciągania do centrum
- **Repel Strength** - siła odpychania węzłów
- **Link Strength** - siła przyciągania połączonych węzłów
- **Link Distance** - odległość między węzłami

### 🎭 Display Options
- **Arrows** - pokazuj kierunek linków
- **Text fade threshold** - próg przezroczystości tekstu
- **Node size** - rozmiar węzłów
- **Line thickness** - grubość linii

## 🚀 Użycie

### Otwieranie Graph View

**Metoda 1: Ribbon**
- Kliknij ikonę grafu w lewym panelu

**Metoda 2: Command Palette**
- `Ctrl+P` → wpisz "graph" → Enter

**Metoda 3: Hotkey**
- Domyślnie: `Ctrl+G` (można zmienić w Settings → Hotkeys)

### Typy grafów

#### Global Graph
Pokazuje **wszystkie** notatki w vaulcie.
- Otwórz: Ribbon icon lub `Ctrl+G`

#### Local Graph
Pokazuje **tylko bieżącą** notatkę i jej sąsiedztwo.
- Otwórz: Command Palette → "Open local graph"
- Lub: kliknij `...` w Graph View → "Open local graph"

## ⚙️ Konfiguracja

### Lokalizacja ustawień
1. Settings (Ctrl+,)
2. Core plugins → Graph view
3. LUB: Kliknij ⚙️ w Graph View

### Główne ustawienia

```json
{
  "collapse-filter": false,       // Zwiń panel filtrów
  "search": "",                   // Wyszukiwanie
  "showTags": true,               // Pokazuj tagi
  "showAttachments": false,       // Pokazuj załączniki
  "hideUnresolved": true,         // Ukryj nierozwiązane linki
  "showOrphans": false,          // Pokazuj sieroty
  "showArrow": true,             // Pokazuj strzałki
  "textFadeMultiplier": 0,       // Fade tekstu
  "nodeSizeMultiplier": 1.2,     // Rozmiar węzłów
  "lineSizeMultiplier": 1,       // Grubość linii
  "centerStrength": 0.1,         // Siła centrum
  "repelStrength": 20,           // Siła odpychania
  "linkStrength": 0.3,           // Siła linków
  "linkDistance": 500            // Odległość linków
}
```

### Color Groups

Plik: `.obsidian/graph.json`

Przykład:
```json
{
  "colorGroups": [
    {
      "query": "tag:#important",
      "color": {
        "a": 1,
        "rgb": 16711680
      }
    }
  ]
}
```

Pełna dokumentacja: [[graph/graph-rules]]

## 🎨 Stylowanie (CSS)

### Lokalizacja
`.obsidian/snippets/graph-style.css`

### Główne klasy CSS
- `.graph-view.color-fill` - węzły (nodes)
- `.graph-view.color-line` - linie (edges)
- `.graph-view.color-arrow` - strzałki

### Przykłady

#### Większe węzły dla MOC
```css
.graph-view.color-fill[data-tag*="moc"] {
  r: 8 !important;
  stroke-width: 2 !important;
}
```

#### Kolorowe strzałki
```css
.graph-view.color-arrow {
  stroke: #888888 !important;
  fill: #888888 !important;
}
```

Pełna dokumentacja CSS: [[graph/graph-rules#kolory-strzałek]]

## 📊 Performance

### Optymalizacja dla dużych vaultów

**Problem:** Graf zwalnia przy >1000 notatek

**Rozwiązania:**
1. **Ukryj orphans** - `showOrphans: false`
2. **Ukryj attachments** - `showAttachments: false`
3. **Użyj filtrów** - ogranicz zakres wyświetlania
4. **Zmniejsz node size** - `nodeSizeMultiplier: 0.8`
5. **Zwiększ repel strength** - `repelStrength: 30`

Szczegóły: [[graph/workspace-graph-optimization]]

## 🔍 Use Cases

### 1. Odkrywanie powiązań
- Zobacz jak notatki są połączone
- Znajdź niepowiązane klastry
- Identyfikuj huby (dużo połączeń)

### 2. Nawigacja
- Szybki przegląd struktury vault
- Jump między powiązanymi notatkami
- Eksploracja tematów

### 3. Analiza struktury
- Znajdź sieroty (orphans)
- Zidentyfikuj MOCs (Maps of Content)
- Zobacz gęstość połączeń

### 4. Prezentacje
- Pokaż strukturę wiedzy
- Demonstracja vault
- Visual storytelling

## 🐛 Troubleshooting

### Graf się nie ładuje
1. Sprawdź Console (Ctrl+Shift+I)
2. Wyłącz community plugins
3. Restart Obsidian
4. Usuń `.obsidian/graph.json` i zrestartuj

### Graf jest wolny
1. Zmniejsz `nodeSizeMultiplier`
2. Zwiększ `repelStrength`
3. Ukryj orphans i attachments
4. Użyj filtrów

### Brak kolorów grup
1. Sprawdź `.obsidian/graph.json`
2. Zweryfikuj składnię queries
3. Restart widoku grafu

Więcej: [[graph/GRAPH-FIX-INSTRUCTIONS]]

## 🔗 Powiązane

- [[graph/graph-rules]] - Zasady konfiguracji grafu
- [[graph/README]] - Dokumentacja grafu
- [[plugins/core/backlinks]] - Backlinks plugin
- [[plugins/core/outgoing-links]] - Outgoing links plugin

## 📚 Linki zewnętrzne

- [Obsidian Help: Graph View](https://help.obsidian.md/Plugins/Graph+view)
- [Forum: Graph View Tips](https://forum.obsidian.md/t/graph-view-tips)
- [CSS Snippets for Graph](https://github.com/obsidian-community/obsidian-hub)

## 📝 Historia zmian

| Data | Zmiana |
|------|--------|
| 2025-11-22 | Utworzono dokumentację Graph View jako core plugin |
| 2025-11-22 | Dodano color groups i CSS styling |
