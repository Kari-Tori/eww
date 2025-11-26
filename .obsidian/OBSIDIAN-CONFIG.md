# Obsidian - Konfiguracja EWW Vault

## 📋 Obecne ustawienia

### Appearance (`appearance.json`)
```json
{
  "zoomLevel": 0.8,           // 80% zoom całego interfejsu
  "baseFontSize": 25,         // Rozmiar czcionki bazowej
  "cssTheme": "GitHub Theme", // Motyw
  "accentColor": "#f736c3",   // Kolor akcentu (różowy)
  "enabledCssSnippets": [
    "full-width-editor"       // Pełna szerokość edytora
  ]
}
```

### CSS Snippet - Full Width Editor
- 📁 Lokalizacja: `.obsidian/snippets/full-width-editor.css`
- ✅ Aktywny: tak
- 🎯 Funkcja: Rozciąga edytor na całą szerokość okna

## 🔧 Dodatkowe opcje konfiguracji

### 1. Zoom Level (`appearance.json`)
```json
"zoomLevel": 0.8  // Możliwe wartości: 0.5 - 2.0
```
- `0.5` = 50% (bardzo małe)
- `0.8` = 80% (obecne)
- `1.0` = 100% (domyślne)
- `1.2` = 120% (powiększone)

### 2. Font Sizes (`appearance.json`)
```json
"baseFontSize": 25,           // Podstawowy rozmiar (px)
"interfaceFontFamily": "",    // Czcionka interfejsu (puste = domyślna)
"textFontFamily": "",         // Czcionka tekstu
"monospaceFontFamily": ""     // Czcionka kodu
```

**Przykłady czcionek:**
```json
"textFontFamily": "Georgia, serif"
"monospaceFontFamily": "JetBrains Mono, monospace"
```

### 3. Translucency & Native Menus (`appearance.json`)
```json
"translucency": false,  // Przezroczystość okna (tylko Linux/Mac)
"nativeMenus": false    // Natywne menu systemowe
```

### 4. Dodatkowe CSS Snippety

**Przykład: Ciemniejsze tło kodu**
📁 `.obsidian/snippets/dark-code-blocks.css`
```css
/* Ciemniejsze bloki kodu */
.markdown-preview-view pre {
  background-color: #1e1e1e !important;
  border: 1px solid #333 !important;
}

code {
  background-color: #2d2d2d !important;
  color: #d4d4d4 !important;
}
```

**Przykład: Szersze panele boczne**
📁 `.obsidian/snippets/wider-sidebars.css`
```css
/* Szersze panele boczne */
.workspace-split.mod-left-split {
  min-width: 350px !important;  /* Domyślnie 250px */
}

.workspace-split.mod-right-split {
  min-width: 350px !important;
}
```

**Przykład: Większe nagłówki**
📁 `.obsidian/snippets/bigger-headers.css`
```css
/* Większe nagłówki */
.markdown-preview-view h1 { font-size: 2.5em !important; }
.markdown-preview-view h2 { font-size: 2.0em !important; }
.markdown-preview-view h3 { font-size: 1.7em !important; }
```

### 5. Workspace Layout (`workspace.json`)
Ten plik przechowuje layout okien, paneli i otwartych plików.
- Panele lewy/prawy (sidebar)
- Split editor (podział ekranu)
- Zakładki (tabs)
- Historia otwartych plików

**Uwaga:** Lepiej nie edytować ręcznie - używaj interfejsu Obsidian.

### 6. Core Plugins (`core-plugins.json`)
Włączone/wyłączone podstawowe wtyczki:
```json
[
  "file-explorer",      // Eksplorator plików
  "global-search",      // Wyszukiwanie
  "graph",              // Graf połączeń
  "backlink",           // Linki zwrotne
  "outgoing-link",      // Linki wychodzące
  "tag-pane",           // Panel tagów
  "page-preview",       // Podgląd stron
  "daily-notes",        // Notatki dzienne
  "templates",          // Szablony
  "note-composer",      // Kompozytor notatek
  "command-palette",    // Paleta komend
  "markdown-importer",  // Import markdown
  "word-count",         // Licznik słów
  "open-with-default-app", // Otwórz w domyślnej aplikacji
  "file-recovery"       // Odzyskiwanie plików
]
```

### 7. Community Plugins (`community-plugins.json`)
Lista zainstalowanych pluginów społecznościowych.

## 🎨 Motyw (Theme)

Obecny motyw: **GitHub Theme**

Zmiana motywu:
1. Settings → Appearance → Themes
2. Browse themes
3. Wybierz i zainstaluj nowy motyw

Popularne motywy:
- **Minimal** - minimalistyczny, świetna konfiguracja
- **Things** - inspirowany macOS Things
- **California Coast** - jasny, przyjemny
- **Nord** - ciemny, nordycki
- **Catppuccin** - pastelowy, ciemny

## 📝 Jak aktywować snippety CSS

1. Utwórz plik `.css` w `.obsidian/snippets/`
2. Dodaj nazwę (bez `.css`) do `appearance.json`:
   ```json
   "enabledCssSnippets": [
     "full-width-editor",
     "dark-code-blocks",
     "wider-sidebars"
   ]
   ```
3. Przeładuj Obsidian lub użyj "Reload app without saving"

## 🔄 Synchronizacja ustawień

Wszystkie pliki w `.obsidian/` są w git, więc:
- ✅ Ustawienia są wersjonowane
- ✅ Można cofnąć zmiany
- ✅ Można synchronizować między maszynami

**Uwaga:** `workspace.json` może się często zmieniać (każde otwarcie pliku).
Rozważ dodanie do `.gitignore` jeśli przeszkadza.

## 🚀 Quick Tips

### Powiększ tylko tekst (nie UI)
```json
"baseFontSize": 30,  // Zwiększ tylko rozmiar tekstu
"zoomLevel": 1.0     // Zoom UI zostaw domyślny
```

### Pełny width tylko dla notatek
Edytuj `full-width-editor.css` i ustaw:
```css
max-width: 1400px !important;  /* zamiast 100% */
margin: 0 auto !important;     /* wyśrodkowanie */
```

### Różne zoom dla różnych vaultów
Każdy vault ma własny `.obsidian/` folder, więc może mieć różne ustawienia!

---

**Ostatnia aktualizacja:** 24.11.2025  
**Edytor:** Karina M. + AI Assistant
