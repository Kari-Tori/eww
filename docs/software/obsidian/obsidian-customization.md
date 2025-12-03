---
version: 0.0.2
title: "obsidian-customization"
created: 2025-11-25
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
title: Obsidian — Customization Guide (Themes, CSS Snippets, Appearance)
description: Kompletny przewodnik po customizacji Obsidian — motywy, CSS snippets, konfiguracja wyglądu, czcionki, kolory i UI tweaks
version: 1.0.0
updated: 2025-11-24
tags:
  - obsidian
  - customization
  - css
  - themes
  - snippets
  - appearance
  - ui
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# Obsidian — Customization Guide 🎨

## 🎯 Cel dokumentu

Kompletny przewodnik po customizacji wyglądu Obsidian:
- Instalacja i konfiguracja motywów (themes)
- Tworzenie CSS snippets
- Konfiguracja appearance settings
- Czcionki, kolory, layout
- Best practices i przykłady

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📦 Struktura konfiguracji Obsidian

```
.obsidian/
├── appearance.json        # Ustawienia wyglądu
├── app.json              # Ustawienia aplikacji
├── community-plugins.json # Lista pluginów
├── themes/               # Zainstalowane motywy
│   └── GitHub Theme/
│       └── theme.css
├── snippets/             # CSS snippets użytkownika
│   ├── full-width-editor.css
│   ├── eww-journal.css
│   ├── lego-snippet.css
│   └── test-full-width.css
└── workspace.json        # Layout i stan workspace
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎨 Themes — Motywy Obsidian

### Zainstalowane motywy

#### GitHub Theme ✅
**Status:** Aktywny motyw  
**Autor:** krios2146  
**GitHub:** https://github.com/krios2146/obsidian-github-theme  
**Rating:** ⭐ 4.8/5

**Funkcje:**
- Styl GitHub Markdown
- Light/Dark mode
- Syntax highlighting dla kodu
- Clean, minimalistyczny design
- Świetna czytelność

**Instalacja:**
```
Settings → Appearance → Themes → Manage → Search "GitHub Theme" → Install
```

**Aktywacja:**
```
Settings → Appearance → Themes → GitHub Theme
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Top 10 Community Themes

#### 1. **Minimal** (najpopularniejszy)
```
Instalacje: 500K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Ultra minimalistyczny
- Konfigurowalne kolory (via Style Settings plugin)
- Focus mode
- Obsługuje Mobile

**Instalacja:**
- Settings → Appearance → Themes → Manage → **Minimal** → Install

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 2. **Things**
```
Instalacje: 300K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Inspirowany macOS Things app
- Piękna typografia
- Dostępne light/dark
- Clean UI

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 3. **California Coast**
```
Instalacje: 200K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Naturalne, ciepłe kolory
- Świetna czytelność
- Minimalistyczny

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 4. **AnuPpuccin**
```
Instalacje: 150K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Catppuccin color scheme
- Pastelowe kolory
- 4 warianty (Latte, Frappe, Macchiato, Mocha)
- Duża customizacja

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 5. **ITS Theme**
```
Instalacje: 120K+
Rating: ⭐⭐⭐⭐☆
```
**Funkcje:**
- "In the Shadows" motyw
- Dark mode ekspert
- Świetne kontrasty

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 6. **Dracula Official**
```
Instalacje: 100K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Oficjalny Dracula theme
- Dark purple/pink kolory
- Konsystentny z Dracula w innych edytorach

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 7. **Obsidian Nord**
```
Instalacje: 90K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Nord color palette
- Zimne, spokojne kolory
- Świetna czytelność

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 8. **Primary**
```
Instalacje: 80K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Prosty, klasyczny design
- Focus na content

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 9. **Everforest**
```
Instalacje: 70K+
Rating: ⭐⭐⭐⭐⭐
```
**Funkcje:**
- Inspirowany lasem
- Zielone, naturalne kolory
- Komfortowy dla oczu

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 10. **Sanctum**
```
Instalacje: 60K+
Rating: ⭐⭐⭐⭐☆
```
**Funkcje:**
- Elegancki dark theme
- Wysoki kontrast
- Professional look

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎨 Appearance Settings

### Obecna konfiguracja (`appearance.json`)

```json
{
  "zoomLevel": 0.8,
  "baseFontSize": 25,
  "cssTheme": "GitHub Theme",
  "accentColor": "#f736c3",
  "enabledCssSnippets": [
    "full-width-editor"
  ]
}
```

### Kluczowe ustawienia

#### 1. Zoom Level
```json
"zoomLevel": 0.8  // 80% UI
```
**Możliwe wartości:** 0.5 - 2.0
- `0.5` = 50% (bardzo małe)
- `0.8` = 80% ✅ obecne
- `1.0` = 100% (domyślne)
- `1.2` = 120%
- `1.5` = 150% (bardzo duże)

**Zmiana:** Settings → Appearance → Advanced → Zoom level

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 2. Base Font Size
```json
"baseFontSize": 25  // 25px
```
**Zakres:** 10-30px  
**Obecne:** 25px (duża czcionka dla lepszej czytelności)

**Zmiana:** Settings → Appearance → Font size

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 3. Accent Color
```json
"accentColor": "#f736c3"  // Różowy
```
**Funkcja:** Kolor linków, przycisków, highlightów

**Zmiana:** Settings → Appearance → Accent color → Color picker

**Popularne kolory:**
- `#f736c3` — Różowy ✅ obecny
- `#7c3aed` — Fioletowy
- `#2563eb` — Niebieski
- `#10b981` — Zielony
- `#f59e0b` — Pomarańczowy
- `#ef4444` — Czerwony

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 4. Fonts

```json
{
  "interfaceFontFamily": "",           // Interfejs (puste = domyślne)
  "textFontFamily": "",                // Treść notatek
  "monospaceFontFamily": "JetBrains Mono"  // Kod
}
```

**Rekomendowane czcionki:**

**Interface:**
- System default (puste)
- Inter
- Roboto
- Open Sans

**Text (content):**
- Georgia, serif
- Merriweather
- iA Writer Quattro
- Literata

**Monospace (code):**
- JetBrains Mono ✅ polecane
- Fira Code
- Cascadia Code
- Source Code Pro

**Instalacja czcionek:**
```bash
# JetBrains Mono
sudo apt install fonts-jetbrains-mono

# Fira Code
sudo apt install fonts-firacode

# System fonts
fc-list | grep -i "jetbrains"
```

**Konfiguracja:**
```json
{
  "textFontFamily": "Georgia, serif",
  "monospaceFontFamily": "JetBrains Mono, Fira Code, monospace"
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📝 CSS Snippets — Customowe style

### Co to są CSS snippets?

CSS snippets to małe pliki `.css` w `.obsidian/snippets/`, które nadpisują domyślne style Obsidian.

**Zalety:**
- Nie modyfikują theme (można zmieniać motywy)
- Można włączać/wyłączać
- Łatwo sharować między vaultami
- Hot reload (zmiany na żywo)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Zainstalowane snippets (4)

#### 1. `full-width-editor.css` ✅ AKTYWNY

**Funkcja:** Rozciąga edytor na 100% szerokości okna

**Kod (skrócony):**
```css
body {
  --file-line-width: 100% !important;
  --line-width: 100% !important;
  --max-width: 100% !important;
}

.workspace-leaf-content {
  max-width: none !important;
  width: 100% !important;
}

.markdown-preview-view,
.markdown-source-view {
  max-width: 100% !important;
  width: 100% !important;
  padding: 1rem 2rem !important;
}
```

**Aktywacja:**
```
Settings → Appearance → CSS snippets → full-width-editor (toggle ON)
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 2. `eww-journal.css` ⚪ NIEAKTYWNY

**Funkcja:** Lepsze odstępy dla dziennika + callouts

**Kod:**
```css
/* Więcej przestrzeni między sekcjami */
.markdown-preview-view h1 {
  margin-top: 1.2em;
  margin-bottom: 0.4em;
}
.markdown-preview-view h2 {
  margin-top: 1em;
  margin-bottom: 0.35em;
}

/* Callout styling */
.callout {
  border-left: 4px solid var(--interactive-accent);
  padding: 0.6em 0.8em;
  background: var(--background-modifier-1);
  border-radius: 6px;
}

/* Większe checkboxy */
.task-list-item {
  padding: 0.15em 0.25em;
}

/* Subtelny frontmatter */
.cm-s-obsidian .frontmatter {
  opacity: 0.9;
  font-size: 0.95em;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 3. `lego-snippet.css` ⚪ NIEAKTYWNY

**Funkcja:** Custom status strip dla projektów LEGO (kolorowe kropki statusu)

**Kod:**
```css
.status-strip {
  display: inline-flex;
  gap: 4px;
  align-items: center;
}

.status-strip span {
  width: 14px;
  height: 14px;
  border-radius: 3px;
  display: inline-block;
  border: 1px solid rgba(0, 0, 0, 0.2);
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.15);
}

.status-strip span.active {
  background: #FF0000;  /* Czerwony - aktywny */
}

.status-strip span.pending {
  background: #FFD700;  /* Złoty - pending */
}

.status-strip span.future {
  background: #0055A4;  /* Niebieski - przyszły */
}

.status-strip span.goal {
  background: #00933B;  /* Zielony - cel */
}
```

**Użycie w notatce:**
```html
<div class="status-strip">
  <span class="active"></span>
  <span class="pending"></span>
  <span class="future"></span>
  <span class="goal"></span>
</div>
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

#### 4. `test-full-width.css` ⚪ NIEAKTYWNY

**Funkcja:** Test full width (podobne do #1)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Tworzenie nowego CSS snippet

#### Krok 1: Utwórz plik
```bash
touch .obsidian/snippets/my-custom-style.css
```

#### Krok 2: Edytuj CSS
```css
/* my-custom-style.css */

/* Większe heading h1 */
.markdown-preview-view h1 {
  font-size: 2.5em;
  color: var(--text-accent);
  border-bottom: 2px solid var(--interactive-accent);
  padding-bottom: 0.3em;
}

/* Kolorowe callouts */
.callout[data-callout="success"] {
  background-color: rgba(16, 185, 129, 0.1);
  border-left-color: #10b981;
}

.callout[data-callout="warning"] {
  background-color: rgba(245, 158, 11, 0.1);
  border-left-color: #f59e0b;
}

.callout[data-callout="error"] {
  background-color: rgba(239, 68, 68, 0.1);
  border-left-color: #ef4444;
}

/* Ładniejsze checkboxy */
input[type="checkbox"] {
  width: 18px;
  height: 18px;
  border-radius: 4px;
  border: 2px solid var(--interactive-accent);
}

input[type="checkbox"]:checked {
  background-color: var(--interactive-accent);
}
```

#### Krok 3: Aktywuj snippet
```
Settings → Appearance → CSS snippets → Reload snippets → Toggle ON
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎨 Przykłady customizacji

### 1. Dark mode z wysokim kontrastem

**Snippet:** `high-contrast-dark.css`
```css
/* Ciemne tło, jasny tekst */
body {
  --background-primary: #0d1117;
  --background-secondary: #161b22;
  --text-normal: #f0f6fc;
  --text-muted: #8b949e;
  --interactive-accent: #58a6ff;
}

/* Większy kontrast dla linków */
a {
  color: #58a6ff;
  font-weight: 500;
}

/* Czytelniejsze callouts */
.callout {
  border-width: 3px;
  background: rgba(255, 255, 255, 0.05);
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 2. Compact mode — więcej treści na ekranie

**Snippet:** `compact-mode.css`
```css
/* Mniejsze marginesy */
.markdown-preview-view {
  padding: 0.5rem 1rem !important;
}

.markdown-preview-view h1 {
  margin-top: 0.8em;
  margin-bottom: 0.2em;
  font-size: 1.8em;
}

.markdown-preview-view h2 {
  margin-top: 0.6em;
  margin-bottom: 0.15em;
  font-size: 1.5em;
}

.markdown-preview-view p {
  margin-bottom: 0.6em;
}

/* Mniejsze line-height */
body {
  --line-height-normal: 1.4;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 3. Ładniejsze tabele

**Snippet:** `pretty-tables.css`
```css
/* Zebra striping */
.markdown-preview-view table tr:nth-child(even) {
  background-color: rgba(0, 0, 0, 0.02);
}

/* Rounded corners */
.markdown-preview-view table {
  border-radius: 8px;
  overflow: hidden;
  border: 1px solid var(--background-modifier-border);
}

/* Header styling */
.markdown-preview-view table thead {
  background-color: var(--interactive-accent);
  color: white;
  font-weight: 600;
}

.markdown-preview-view table th {
  padding: 0.8em 1em;
}

.markdown-preview-view table td {
  padding: 0.6em 1em;
  border-top: 1px solid var(--background-modifier-border);
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 4. Custom tag colors

**Snippet:** `colored-tags.css`
```css
/* Tag styling */
.tag {
  border-radius: 12px;
  padding: 2px 10px;
  font-size: 0.9em;
  font-weight: 500;
}

/* Kolory dla tagów tematycznych */
.tag[href="#obsidian"] {
  background-color: rgba(147, 51, 234, 0.2);
  color: #9333ea;
}

.tag[href="#code"] {
  background-color: rgba(37, 99, 235, 0.2);
  color: #2563eb;
}

.tag[href="#documentation"] {
  background-color: rgba(16, 185, 129, 0.2);
  color: #10b981;
}

.tag[href="#todo"] {
  background-color: rgba(245, 158, 11, 0.2);
  color: #f59e0b;
}

.tag[href="#important"] {
  background-color: rgba(239, 68, 68, 0.2);
  color: #ef4444;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 5. Większe emoji

**Snippet:** `big-emoji.css`
```css
/* Większe emoji w tekście */
.markdown-preview-view img[alt*="emoji"],
.markdown-preview-view .emoji {
  font-size: 1.5em;
  vertical-align: middle;
}

/* Jeszcze większe w tytułach */
.markdown-preview-view h1 img[alt*="emoji"],
.markdown-preview-view h1 .emoji {
  font-size: 1.8em;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔧 Advanced Customization

### Style Settings Plugin (polecane)

**Plugin:** Style Settings  
**ID:** `obsidian-style-settings`

**Funkcje:**
- GUI do customizacji CSS variables
- Konfigurowalne motywy (jeśli theme wspiera)
- Bez edycji kodu CSS
- Export/import ustawień

**Instalacja:**
```
Settings → Community plugins → Browse → "Style Settings" → Install → Enable
```

**Użycie:**
1. Zainstaluj motyw wspierający Style Settings (np. Minimal, AnuPpuccin)
2. Settings → Style Settings
3. Customizuj kolory, czcionki, spacing via GUI

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### CSS Variables — najważniejsze

```css
/* Kolory */
--background-primary: #ffffff;
--background-secondary: #f3f4f6;
--text-normal: #1f2937;
--text-muted: #6b7280;
--text-accent: #7c3aed;
--interactive-accent: #2563eb;

/* Czcionki */
--font-text: 'Georgia', serif;
--font-interface: 'Inter', sans-serif;
--font-monospace: 'JetBrains Mono', monospace;

/* Rozmiary */
--font-text-size: 16px;
--line-height-normal: 1.5;
--file-line-width: 700px;

/* Spacing */
--size-4-1: 4px;
--size-4-2: 8px;
--size-4-3: 12px;
--size-4-4: 16px;

/* Border radius */
--radius-s: 4px;
--radius-m: 8px;
--radius-l: 12px;
```

**Użycie w snippet:**
```css
body {
  --interactive-accent: #f736c3;
  --font-text: 'Georgia', serif;
  --file-line-width: 100%;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📚 Zasoby i społeczność

### Oficjalne

- **Forum:** https://forum.obsidian.md/
- **Discord:** https://discord.gg/obsidianmd
- **Docs:** https://help.obsidian.md/

### CSS Snippets Collections

- **Obsidian CSS Snippets** (GitHub): https://github.com/Dmytro-Shulha/obsidian-css-snippets
- **Forum CSS Section:** https://forum.obsidian.md/c/share-showcase/css-themes/9
- **r/ObsidianMD Reddit:** https://reddit.com/r/ObsidianMD

### Narzędzia

- **Obsidian CSS Inspector:** Developer Tools (Ctrl+Shift+I)
- **Style Settings Plugin:** GUI dla CSS variables
- **Theme Dev Vault:** https://github.com/obsidian-community/obsidian-theme-dev

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎯 Best Practices

### 1. Używaj snippets zamiast edycji theme.css
✅ **Dobrze:** `.obsidian/snippets/my-tweaks.css`  
❌ **Źle:** Edycja `.obsidian/themes/ThemeName/theme.css`

**Powód:** Theme updates nadpiszą zmiany.

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 2. Testuj na małych snippetach
```css
/* test-feature.css */
.markdown-preview-view h1 {
  color: red;  /* Test czy działa */
}
```
Najpierw test, potem full implementation.

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 3. Używaj `!important` tylko gdy konieczne
```css
/* Lepiej */
body {
  --file-line-width: 100%;
}

/* Tylko jeśli nie działa */
.markdown-preview-view {
  max-width: 100% !important;
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 4. Komentuj CSS
```css
/* === HEADINGS === */
.markdown-preview-view h1 {
  font-size: 2.5em;  /* Większy h1 dla lepszej hierarchii */
  border-bottom: 2px solid var(--interactive-accent);
}

/* === CALLOUTS === */
.callout {
  border-radius: 8px;  /* Zaokrąglone rogi */
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 5. Backup konfiguracji
```bash
# Backup snippets
cp -r .obsidian/snippets ~/backups/obsidian-snippets-$(date +%Y%m%d)

# Backup appearance.json
cp .obsidian/appearance.json ~/backups/appearance-$(date +%Y%m%d).json
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🐛 Troubleshooting

### Snippet nie działa

1. **Reload snippets:**
   ```
   Settings → Appearance → CSS snippets → Reload snippets button
   ```

2. **Sprawdź czy włączony:**
   ```
   Toggle powinien być ON (niebieski)
   ```

3. **Sprawdź błędy CSS:**
   ```
   Ctrl+Shift+I → Console → Szukaj błędów
   ```

4. **Test z `!important`:**
   ```css
   .element {
     property: value !important;
   }
   ```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Theme conflict

```
Settings → Appearance → Themes → None (użyj default)
```
Jeśli snippet działa bez theme, to konflikt. Zgłoś bug theme authorowi.

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Czcionka nie działa

1. **Sprawdź czy zainstalowana:**
   ```bash
   fc-list | grep -i "JetBrains"
   ```

2. **Fallback fonts:**
   ```json
   {
     "monospaceFontFamily": "JetBrains Mono, Fira Code, Consolas, monospace"
   }
   ```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔗 Powiązane dokumenty

- **[obsidian-plugins.md](./obsidian-plugins.md)** — Community plugins (24 pluginów)
- **[installed_pluggins.md](./installed_pluggins.md)** — Zainstalowane pluginy (13)
- **[plugins-status.md](./plugins-status.md)** — Audit pluginów
- **[obsidian.md](./obsidian.md)** — Główna dokumentacja Obsidian

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ✨ Następne kroki

1. ✅ Zainstaluj motyw (np. Minimal, AnuPpuccin)
2. ✅ Włącz full-width-editor.css snippet
3. ✅ Dostosuj czcionki (JetBrains Mono dla kodu)
4. ✅ Ustaw accent color
5. ✅ Zainstaluj Style Settings plugin
6. ✅ Utwórz custom snippet dla swojego workflow
7. ✅ Backup `.obsidian/snippets/` i `appearance.json`

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📊 Podsumowanie obecnej konfiguracji

**Theme:** GitHub Theme  
**Zoom:** 80%  
**Font Size:** 25px  
**Accent Color:** #f736c3 (różowy)  
**Active Snippets:** 1 (full-width-editor)  
**Inactive Snippets:** 3 (eww-journal, lego-snippet, test-full-width)

**Rekomendacje:**
- ✅ Włącz eww-journal.css dla lepszych odstępów
- ✅ Wypróbuj motyw Minimal lub AnuPpuccin
- ✅ Zainstaluj Style Settings plugin
- ✅ Dodaj kolorowe tagi (colored-tags.css snippet)
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🧱 LEGO snippet – stylizacja modułu LEGO

- Snippet `lego-snippet` z folderu `usr/jakubc/hobby/lego/snippets/lego-snippet.css` nadaje dedykowany zestaw barw i strukturę (status strip, build card, roadmapa) projektowi Delta-7.
- Aby go użyć, skopiuj plik do `~/.config/obsidian/<vault>/.obsidian/snippets/lego-snippet.css`, otwórz `Settings → Appearance → CSS snippets`, kliknij „Reload snippets” i włącz `lego-snippet`.
- Notatka `obi-wan-kenobi.md` ma we front matterze `obsidian_snippet: lego-snippet`, więc po włączeniu snippet od razu styluje cały dokument.

## 🔗 Backlinks

- [[docs/software/obsidian/obsidian]]
- [[docs/docs]]
- [[INDEX]]