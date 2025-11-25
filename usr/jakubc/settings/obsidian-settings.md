---
title: Obsidian Settings - Konfiguracja
author: Jakub C.
created: 2025-11-24
updated: 2025-11-24
tags:
  - obsidian
  - settings
  - configuration
---

# Obsidian - Ustawienia i Konfiguracja

## 🎯 Aktualna konfiguracja

### Zoom i szerokość edytora

✅ **Zoom interfejsu:** 80% (`zoomLevel: 0.8`)  
✅ **Szerokość edytora:** 80% ekranu, wyśrodkowany  
✅ **Readable line length:** WYŁĄCZONE

## 📝 Jak skonfigurować szerokość edytora

### Krok 1: Wyłącz "Readable line length"

**Plik:** `.obsidian/app.json`

```json
{
  "zoomLevel": 0.8,
  "alwaysUpdateLinks": true,
  "readableLineLength": false
}
```

### Krok 2: Utwórz CSS snippet

**Plik:** `.obsidian/snippets/custom-width.css`

```css
/* Szerokość 80% ekranu z wyśrodkowaniem */
body {
  --file-line-width: 80vw !important;
  --line-width: 80vw !important;
  --line-width-adaptive: 80vw !important;
  --max-width: none !important;
}

/* Wszystkie kontenery markdown */
.markdown-source-view.mod-cm6.is-readable-line-width .cm-contentContainer.cm-contentContainer,
.markdown-source-view.mod-cm6 .cm-contentContainer {
  max-width: 80vw !important;
  width: 80vw !important;
  margin: 0 auto !important;
}

.markdown-preview-sizer.markdown-preview-sizer {
  max-width: 80vw !important;
  width: 80vw !important;
  min-width: 80vw !important;
  margin: 0 auto !important;
}

/* Nadpisz CSS variables */
:root {
  --file-line-width: 80vw !important;
  --line-width: 80vw !important;
}
```

### Krok 3: Aktywuj snippet

**Plik:** `.obsidian/appearance.json`

```json
{
  "enabledCssSnippets": [
    "custom-width"
  ],
  "cssTheme": "",
  "accentColor": "#f736c3",
  "baseFontSize": 25
}
```

### Krok 4: Przeładuj Obsidian

`Ctrl+R` lub Command Palette → "Reload app without saving"

## 🎨 Dostosowanie szerokości

Edytuj wartość `vw` (viewport width) w pliku CSS:

| Szerokość | Wartość CSS | Opis |
|-----------|-------------|------|
| 60% | `60vw` | Wąski, skupiony widok |
| 70% | `70vw` | Komfortowy dla czytania |
| 80% | `80vw` | **OBECNE** - szeroki, ale z marginesami |
| 90% | `90vw` | Bardzo szeroki |
| 100% | `100vw` | Pełna szerokość (bez marginesów) |

**Przykład:** Zmiana na 70%
```css
--file-line-width: 70vw !important;
--line-width: 70vw !important;
```

## 🔧 Zoom interfejsu

**Plik:** `.obsidian/app.json`

```json
{
  "zoomLevel": 0.8
}
```

| Wartość | Zoom | Opis |
|---------|------|------|
| `0.5` | 50% | Bardzo małe |
| `0.6` | 60% | Małe |
| `0.7` | 70% | Pomniejszone |
| `0.8` | 80% | **OBECNE** - komfortowe |
| `0.9` | 90% | Niemal standardowe |
| `1.0` | 100% | Domyślne |
| `1.2` | 120% | Powiększone |
| `1.5` | 150% | Bardzo duże |

## 📂 Struktura plików

```
.obsidian/
├── app.json              # Główne ustawienia (zoom, readable line length)
├── appearance.json       # Wygląd (theme, snippets, fonts)
├── snippets/
│   ├── custom-width.css  # Szerokość edytora (80vw)
│   └── full-width-editor.css  # Backup - pełna szerokość
└── workspace.json        # Layout okien (auto-generowany)
```

## 🚀 Quick Tips

### Przywróć domyślną szerokość Obsidian
1. Usuń snippet z `enabledCssSnippets: []`
2. Ustaw `"readableLineLength": true` w `app.json`
3. Przeładuj Obsidian

### Różna szerokość dla różnych typów plików
Możesz użyć selektorów CSS dla konkretnych folderów:

```css
/* Szersze dla dokumentacji */
.workspace-leaf-content[data-path*="docs/"] .cm-contentContainer {
  max-width: 90vw !important;
}

/* Węższe dla notatek */
.workspace-leaf-content[data-path*="notes/"] .cm-contentContainer {
  max-width: 60vw !important;
}
```

### Disable snippet tymczasowo
W `appearance.json` po prostu usuń nazwę snippeta z tablicy `enabledCssSnippets`.

## 🐛 Troubleshooting

### Snippet nie działa?
1. Sprawdź czy nazwa pliku w `enabledCssSnippets` zgadza się z nazwą pliku (bez `.css`)
2. Upewnij się że plik jest w `.obsidian/snippets/`
3. Przeładuj Obsidian (`Ctrl+R`)

### Edytor nadal ograniczony do ~700px?
- Sprawdź `Settings → Editor → Readable line length` - **MUSI być wyłączone**
- Sprawdź `app.json` - `"readableLineLength"` musi być `false`

### CSS nie nadpisuje motywu?
- Wyłącz motyw: ustaw `"cssTheme": ""` w `appearance.json`
- Użyj `!important` w CSS
- Upewnij się że snippet jest **po** motywie w `enabledCssSnippets`

## 📚 Przydatne linki

- [Obsidian CSS Variables](https://docs.obsidian.md/Reference/CSS+variables)
- [CSS Snippets Guide](https://help.obsidian.md/Extending+Obsidian/CSS+snippets)
- [Community Themes](https://obsidian.md/themes)

---

**Ostatnia aktualizacja:** 2025-11-24  
**Vault:** `/home/karinam/git/eww`
