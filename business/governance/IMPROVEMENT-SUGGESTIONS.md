---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T09:00:00Z
modified: 2025-11-21T09:00:00Z
author: jakubc
title: "Sugestie Ulepszeń - E-Waste Workshop"






owner: jakubc
---

# Sugestie Ulepszeń - E-Waste Workshop

Raport z analizy repo przeprowadzonej 2025-11-21.

## ✅ Naprawiono (2025-11-21)

1. **Makefile przywrócony do root** - był błędnie w config/
2. **Usunięto 30 pustych pluginów Obsidian** - .obsidian/plugins/*
3. **Usunięto 10 pustych katalogów** - .smart-env, .space, Tags
4. **Usunięto backup** - .obsidian/workspace.json.bak

## 🎯 Problemy do rozważenia

### 1. 💾 Duże pliki (1.3 GB)

**usr/karinam/Archives/** - 1 GB zdjęć JPG:
```
1.8M - IMG_2810D.jpg
1.7M - IMG_2806D.jpg
1.8M - IMG_2805D.jpg
1.8M - IMG_2814D.jpg
```

**Rekomendacja:**
```bash
# Dodaj do .gitignore:
echo "usr/karinam/Archives/*.jpg" >> .gitignore
echo "usr/karinam/Archives/*.png" >> .gitignore

# Lub przenieś do external storage:
mv usr/karinam/Archives/*.jpg ~/Pictures/eww-archive/
```

### 2. 🎨 .obsidian duży (256 MB)

**Themes i plugins:**
```
1.7M - .obsidian/themes/Royal Velvet/theme.css
1.4M - .obsidian/themes/Faded/theme.css
5.4M - .obsidian/plugins/make-md/main.js
2.4M - .obsidian/plugins/obsidian-full-calendar/main.js
```

**Rekomendacja:**
```bash
# Dodaj do .gitignore:
echo ".obsidian/themes/" >> .gitignore
echo ".obsidian/plugins/*/main.js" >> .gitignore

# Zachowaj tylko manifests i configs
```

### 3. 🔄 Duplikaty nazw plików (14)

Pliki o tych samych nazwach w różnych lokalizacjach:

```
README.md (3 kopie)
INDEX.md (3 kopie)
00_asset-lifecycle-automation.md
00_DASHBOARD_FINAL.md
01_PLAN.md
02_ARCH.md
```

**Rekomendacja:**
- Zbadaj każdy duplikat
- Zachowaj najnowszy/najbardziej kompletny
- Usuń lub skonsoliduj pozostałe

### 4. 📂 Możliwa konsolidacja katalogów

**Zduplikowane struktury:**
```
dev/
  bin/
  cfg/
  scripts/
  
vs

bin/
config/
scripts/
```

**Rekomendacja:**
- Przenieś dev/bin/ → bin/dev/
- Przenieś dev/cfg/ → config/dev/
- Zachowaj dev/ tylko dla dokumentacji rozwoju

### 5. 🔧 Brakujące set -euo pipefail

**Skrypty bez error handling:**
- Sprawdź wszystkie .sh w scripts/
- Dodaj `set -euo pipefail` na początku

**Przykład:**
```bash
#!/usr/bin/env bash
set -euo pipefail  # ← Brakuje w niektórych

# Twój kod...
```

## �� Dalsze optymalizacje

### A. .gitignore rozszerzenie

Dodaj do `.gitignore`:
```gitignore
# Obsidian heavy files
.obsidian/themes/
.obsidian/plugins/*/main.js
.obsidian/workspace.json.bak
.makemd/*.mdc

# User archives
usr/*/Archives/*.jpg
usr/*/Archives/*.png
usr/*/.obsidian/themes/

# Temporary files
*.tmp
*.bak
*~
```

### B. Dokumentacja

**Brakujące/niekompletne:**
- [ ] docs/API.md - dokumentacja funkcji lib/
- [ ] docs/TESTING.md - przewodnik testowania
- [ ] docs/CONTRIBUTING.md - zasady kontrybuowania
- [ ] bin/README.md - opis wszystkich narzędzi

### C. Testy

**Brakujące testy dla:**
- scripts/eww-frontmatter.sh
- scripts/eww-auto-tag.sh
- scripts/eww-obsidian-fix.sh
- scripts/eww-vscode-fix.sh

**Dodaj:**
```bash
tests/
  test_frontmatter.bats
  test_auto_tag.bats
  test_obsidian_fix.bats
  test_vscode_fix.bats
```

### D. CI/CD

**GitHub Actions workflow:**
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Bats
        run: sudo apt-get install -y bats
      - name: Run tests
        run: make test
      - name: ShellCheck
        run: make lint
```

### E. Pre-commit hooks

**Aktywuj hooks:**
```bash
chmod +x .githooks/*
git config core.hooksPath .githooks
```

**Dodaj:**
- shellcheck automatyczny
- frontmatter validation
- TODO: list extractor

## 📊 Statystyka obecna

- **Pliki .md**: 1710
- **Pliki .sh**: 80
- **Katalogi**: 1012
- **Puste katalogi**: 0 ✅
- **Rozmiar .obsidian**: 256 MB
- **Rozmiar usr/karinam/Archives**: 1 GB

## 🎯 Priorytety

### Wysokie (do zrobienia teraz)
1. Dodaj .gitignore dla dużych plików
2. Napraw duplikaty nazw plików
3. Dodaj brakujące testy

### Średnie (w najbliższych dniach)
4. Rozszerz dokumentację (API, TESTING, CONTRIBUTING)
5. Konsoliduj strukturę katalogów dev/
6. Aktywuj pre-commit hooks

### Niskie (opcjonalnie)
7. CI/CD GitHub Actions
8. Archiwizuj stare themes Obsidian
9. Migracja config/ do oddzielnego repo

## 📝 Notatki

- Root jest już zoptymalizowany (56 KB, 5 plików)
- Makefile rozbudowany (50+ targetów)
- Frontmatter wygenerowany (313 .md + 59 .sh)
- ShellCheck clean (brak błędów w głównych skryptach)

## Historia

- **2025-11-21** - Analiza i identyfikacja problemów
  - Naprawiono Makefile location
  - Usunięto 40 pustych katalogów
  - Usunięto backup files
  - Zidentyfikowano 5 głównych problemów
  - Utworzono IMPROVEMENT-SUGGESTIONS.md
