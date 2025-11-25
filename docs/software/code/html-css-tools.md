---
title: Rozszerzenia VS Code dla HTML/CSS/Web Development
description: Narzędzia do pracy z HTML, CSS, JavaScript i web developmentu w VS Code
version: 1.0.0
created: 2025-11-24
updated: 2025-11-24
tags:
  - vscode
  - html
  - css
  - web-development
  - frontend
---

# Rozszerzenia VS Code dla HTML/CSS/Web Development

## 🎯 Cel

Zestawienie najlepszych rozszerzeń VS Code dla pracy z HTML, CSS, JavaScript i web developmentu.

---

## 📦 Kategorie rozszerzeń

### 1️⃣ HTML — Must-Have

#### HTML CSS Support
```vscode-extensions
ecmel.vscode-html-css
```
**Funkcje:**
- CSS IntelliSense w HTML
- Class/ID autocomplete
- Support dla external CSS

**Instalacja:**
```bash
code --install-extension ecmel.vscode-html-css
```

---

#### Auto Rename Tag
```vscode-extensions
formulahendry.auto-rename-tag
```
**Funkcje:**
- Automatyczna zmiana pary tagów HTML/XML
- Przykład: zmień `<div>` → `<section>`, zamykający tag zmieni się automatycznie

**Instalacja:**
```bash
code --install-extension formulahendry.auto-rename-tag
```

---

#### Auto Close Tag
```vscode-extensions
formulahendry.auto-close-tag
```
**Funkcje:**
- Automatyczne zamykanie tagów HTML/XML
- Działa z JSX, Vue, React

**Instalacja:**
```bash
code --install-extension formulahendry.auto-close-tag
```

---

#### HTML Snippets
```vscode-extensions
abusaidm.html-snippets
```
**Funkcje:**
- HTML5 snippets
- Skróty: `html5`, `div`, `form`, `table`
- IntelliSense dla HTML tags

**Instalacja:**
```bash
code --install-extension abusaidm.html-snippets
```

---

#### IntelliSense for CSS class names in HTML
```vscode-extensions
zignd.html-css-class-completion
```
**Funkcje:**
- Autocomplete CSS class names
- Skanuje workspace dla CSS files
- Support dla external stylesheets

**Instalacja:**
```bash
code --install-extension zignd.html-css-class-completion
```

---

### 2️⃣ CSS — Styling & Preprocessing

#### CSS Peek
```vscode-extensions
pranaygp.vscode-css-peek
```
**Funkcje:**
- Peek definition CSS class
- Go to definition
- Peek w inline styles

**Instalacja:**
```bash
code --install-extension pranaygp.vscode-css-peek
```

---

#### Tailwind CSS IntelliSense
```vscode-extensions
bradlc.vscode-tailwindcss
```
**Funkcje:**
- Autocomplete Tailwind CSS classes
- Syntax highlighting
- Linting
- Hover preview

**Instalacja:**
```bash
code --install-extension bradlc.vscode-tailwindcss
```

---

#### SCSS IntelliSense
```vscode-extensions
mrmlnc.vscode-scss
```
**Funkcje:**
- SCSS/Sass autocomplete
- Variables, mixins, functions
- Import path suggestions

**Instalacja:**
```bash
code --install-extension mrmlnc.vscode-scss
```

---

#### Stylelint
```vscode-extensions
stylelint.vscode-stylelint
```
**Funkcje:**
- CSS/SCSS/Less linting
- Auto-fix on save
- Configurable rules

**Instalacja:**
```bash
code --install-extension stylelint.vscode-stylelint
npm install -g stylelint stylelint-config-standard
```

---

### 3️⃣ Live Preview & Browser Tools

#### Live Server
```vscode-extensions
ritwickdey.liveserver
```
**Funkcje:**
- Live reload local server
- Auto-refresh browser
- Support dla dynamic pages
- Multi-root workspace

**Instalacja:**
```bash
code --install-extension ritwickdey.liveserver
```

**Użycie:**
- Prawy klik na HTML → **Open with Live Server**
- Lub: kliknij **Go Live** w status bar
- Serwer: `http://localhost:5500`

---

#### Live Preview
```vscode-extensions
ms-vscode.live-server
```
**Funkcje:**
- Oficjalny Microsoft Live Preview
- Embedded browser w VS Code
- Auto-refresh
- Console debugging

**Instalacja:**
```bash
code --install-extension ms-vscode.live-server
```

---

#### Browser Preview
```vscode-extensions
auchenberg.vscode-browser-preview
```
**Funkcje:**
- Chrome browser w VS Code
- Debugging support
- DevTools integration

**Instalacja:**
```bash
code --install-extension auchenberg.vscode-browser-preview
```

---

### 4️⃣ JavaScript & Frontend Frameworks

#### ESLint
```vscode-extensions
dbaeumer.vscode-eslint
```
**Funkcje:**
- JavaScript/TypeScript linting
- Auto-fix on save
- React/Vue support

**Instalacja:**
```bash
code --install-extension dbaeumer.vscode-eslint
npm install -g eslint
```

---

#### Prettier - Code formatter
```vscode-extensions
esbenp.prettier-vscode
```
**Funkcje:**
- Auto-format HTML/CSS/JS
- Support dla React, Vue, Angular
- EditorConfig support

**Instalacja:**
```bash
code --install-extension esbenp.prettier-vscode
npm install -g prettier
```

**Konfiguracja:**
```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

---

#### JavaScript (ES6) code snippets
```vscode-extensions
xabikos.javascriptsnippets
```
**Funkcje:**
- ES6 snippets
- Import/export
- Arrow functions
- Promises, async/await

**Instalacja:**
```bash
code --install-extension xabikos.javascriptsnippets
```

---

### 5️⃣ Emmet & Productivity

#### Emmet (wbudowane w VS Code)

**Funkcje:**
- HTML/CSS abbreviations
- Przykłady:
  - `div.container>ul>li*5` → pełna struktura
  - `lorem10` → 10 słów lorem ipsum
  - `table>tr*3>td*4` → tabela 3x4

**Konfiguracja:**
```json
{
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "vue-html": "html",
    "plaintext": "html"
  },
  "emmet.triggerExpansionOnTab": true
}
```

---

### 6️⃣ Accessibility & Validation

#### axe Accessibility Linter
```vscode-extensions
deque-systems.vscode-axe-linter
```
**Funkcje:**
- Accessibility linting (WCAG)
- A11y errors/warnings
- Best practices

**Instalacja:**
```bash
code --install-extension deque-systems.vscode-axe-linter
```

---

#### HTMLHint
```vscode-extensions
mkaufman.htmlhint
```
**Funkcje:**
- HTML validation
- Best practices
- Configurable rules

**Instalacja:**
```bash
code --install-extension mkaufman.htmlhint
npm install -g htmlhint
```

---

#### W3C Validation
```vscode-extensions
umoxfo.vscode-w3cvalidation
```
**Funkcje:**
- W3C HTML/CSS validation
- Real-time errors
- Standards compliance

**Instalacja:**
```bash
code --install-extension umoxfo.vscode-w3cvalidation
```

---

### 7️⃣ Color & Image Tools

#### Color Highlight
```vscode-extensions
naumovs.color-highlight
```
**Funkcje:**
- Podświetlanie kolorów CSS
- Hex, RGB, HSL
- Inline preview

**Instalacja:**
```bash
code --install-extension naumovs.color-highlight
```

---

#### Color Picker
```vscode-extensions
anseki.vscode-color
```
**Funkcje:**
- Color picker (GUI)
- Konwersja hex/rgb/hsl
- Palette generator

**Instalacja:**
```bash
code --install-extension anseki.vscode-color
```

---

#### Image preview
```vscode-extensions
kisstkondoros.vscode-gutter-preview
```
**Funkcje:**
- Preview obrazów w gutter
- Hover preview
- Support: PNG, JPG, SVG, GIF

**Instalacja:**
```bash
code --install-extension kisstkondoros.vscode-gutter-preview
```

---

### 8️⃣ Framework-Specific

#### Vetur (Vue.js)
```vscode-extensions
octref.vetur
```
**Funkcje:**
- Vue.js support
- Syntax highlighting
- IntelliSense
- Debugging

**Instalacja:**
```bash
code --install-extension octref.vetur
```

---

#### ES7+ React/Redux/React-Native snippets
```vscode-extensions
dsznajder.es7-react-js-snippets
```
**Funkcje:**
- React snippets
- Redux snippets
- Hooks support

**Instalacja:**
```bash
code --install-extension dsznajder.es7-react-js-snippets
```

---

## 🚀 Instalacja — Quick Setup

### Skrypt instalacyjny (podstawowe HTML/CSS tools)

```bash
#!/usr/bin/env bash
# Instalacja rozszerzeń VS Code dla HTML/CSS/Web Development
set -euo pipefail

readonly HTML_CSS_EXTENSIONS=(
  # HTML
  "ecmel.vscode-html-css"
  "formulahendry.auto-rename-tag"
  "formulahendry.auto-close-tag"
  "abusaidm.html-snippets"
  "zignd.html-css-class-completion"
  
  # CSS
  "pranaygp.vscode-css-peek"
  "bradlc.vscode-tailwindcss"
  "mrmlnc.vscode-scss"
  "stylelint.vscode-stylelint"
  
  # Live Preview
  "ritwickdey.liveserver"
  "ms-vscode.live-server"
  
  # JavaScript
  "dbaeumer.vscode-eslint"
  "esbenp.prettier-vscode"
  "xabikos.javascriptsnippets"
  
  # Productivity
  "naumovs.color-highlight"
  "anseki.vscode-color"
  "kisstkondoros.vscode-gutter-preview"
  
  # Validation
  "mkaufman.htmlhint"
  "deque-systems.vscode-axe-linter"
)

for ext in "${HTML_CSS_EXTENSIONS[@]}"; do
  echo "Installing $ext..."
  code --install-extension "$ext" || true
done

echo "✅ Instalacja zakończona!"
echo "📦 Zainstalowano ${#HTML_CSS_EXTENSIONS[@]} rozszerzeń"
```

**Uruchomienie:**
```bash
bash scripts/install-html-css-vscode-extensions.sh
```

---

## ⚙️ Konfiguracja VS Code dla HTML/CSS

### `.vscode/settings.json`

```json
{
  "// === HTML ===": "",
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.tabSize": 2,
    "editor.suggest.insertMode": "replace"
  },
  "html.format.wrapLineLength": 120,
  "html.format.indentInnerHtml": true,
  "html.autoClosingTags": true,
  "html.suggest.html5": true,
  
  "// === CSS ===": "",
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.tabSize": 2
  },
  "[scss]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "css.lint.unknownAtRules": "ignore",
  "css.validate": true,
  
  "// === JavaScript ===": "",
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "javascript.updateImportsOnFileMove.enabled": "always",
  
  "// === Emmet ===": "",
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "vue-html": "html"
  },
  "emmet.triggerExpansionOnTab": true,
  
  "// === Live Server ===": "",
  "liveServer.settings.donotShowInfoMsg": true,
  "liveServer.settings.port": 5500,
  "liveServer.settings.CustomBrowser": "chrome",
  
  "// === Prettier ===": "",
  "prettier.singleQuote": true,
  "prettier.semi": true,
  "prettier.printWidth": 100,
  "prettier.tabWidth": 2
}
```

---

## 🔧 Konfiguracja Prettier (`.prettierrc`)

```json
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "htmlWhitespaceSensitivity": "css",
  "endOfLine": "lf"
}
```

---

## 🔧 Konfiguracja ESLint (`.eslintrc.json`)

```json
{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": 12,
    "sourceType": "module"
  },
  "rules": {
    "indent": ["error", 2],
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
```

---

## 💡 Workflow HTML/CSS w VS Code

### 1. Nowy projekt HTML

```bash
# Struktura
mkdir my-project && cd my-project
touch index.html style.css script.js

# Otwórz w VS Code
code .
```

**index.html (Emmet: `!` + Tab):**
```html
<!DOCTYPE html>
<html lang="pl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Project</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="container">
    <h1>Hello World</h1>
  </div>
  <script src="script.js"></script>
</body>
</html>
```

### 2. Live Preview

- **Metoda 1:** Prawy klik na `index.html` → **Open with Live Server**
- **Metoda 2:** Kliknij **Go Live** w status bar
- **Metoda 3:** `Ctrl+P` → **Live Server: Open with Live Server**

**Browser:** `http://localhost:5500`

### 3. Emmet przykłady

```
div.container>header+main>section.hero>h1+p
```
Rozwinie się do:
```html
<div class="container">
  <header></header>
  <main>
    <section class="hero">
      <h1></h1>
      <p></p>
    </section>
  </main>
</div>
```

```
ul>li.item$*5>a{Link $}
```
Rozwinie się do:
```html
<ul>
  <li class="item1"><a href="">Link 1</a></li>
  <li class="item2"><a href="">Link 2</a></li>
  <li class="item3"><a href="">Link 3</a></li>
  <li class="item4"><a href="">Link 4</a></li>
  <li class="item5"><a href="">Link 5</a></li>
</ul>
```

---

## 🐛 Troubleshooting

### Live Server nie działa
- Sprawdź czy port 5500 jest wolny: `lsof -i :5500`
- Zmień port: Settings → Live Server → Port: 5501
- Restart VS Code

### Prettier nie formatuje HTML
- Sprawdź: `"editor.defaultFormatter": "esbenp.prettier-vscode"`
- Sprawdź: `"editor.formatOnSave": true`
- Ręcznie: `Shift+Alt+F`

### CSS IntelliSense nie działa
- Zainstaluj: HTML CSS Support
- Restart VS Code
- Sprawdź czy CSS files są w workspace

---

## 📚 Dokumentacja

- **HTML:** https://developer.mozilla.org/en-US/docs/Web/HTML
- **CSS:** https://developer.mozilla.org/en-US/docs/Web/CSS
- **Emmet:** https://docs.emmet.io/
- **Prettier:** https://prettier.io/docs/
- **ESLint:** https://eslint.org/docs/

---

## 📦 Podsumowanie

**Must-Have dla HTML/CSS (11 rozszerzeń):**
1. HTML CSS Support
2. Auto Rename Tag
3. Auto Close Tag
4. HTML Snippets
5. CSS class completion
6. CSS Peek
7. Live Server
8. Prettier
9. ESLint
10. Color Highlight
11. Emmet (wbudowane)

**Zaawansowane (8 rozszerzeń):**
- Tailwind CSS IntelliSense
- SCSS IntelliSense
- Stylelint
- Browser Preview
- axe Accessibility Linter
- HTMLHint
- Color Picker
- Image preview

**Framework-specific:**
- Vetur (Vue.js)
- React snippets

---

## 🔗 Powiązane dokumenty

- [code-plugins.md](./code-plugins.md) — Rozszerzenia Markdown/Obsidian
- [README.md](./README.md) — Główna dokumentacja VS Code

---

## ✨ Następne kroki

1. Zainstaluj podstawowe rozszerzenia (skrypt)
2. Skonfiguruj Prettier i ESLint
3. Utwórz przykładowy projekt HTML/CSS
4. Przetestuj Live Server
5. Przetestuj Emmet abbreviations
