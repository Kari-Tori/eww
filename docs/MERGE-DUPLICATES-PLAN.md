---
title: "Plan scalenia duplikatów docs/ i docs/infra/"
description: "Szczegółowy plan usunięcia duplikatów między docs/ i docs/infra/"
version: 0.0.6
category: documentation
tags:
  - cleanup
  - merge
  - duplicates
  - planning
language: pl
created: 2025-12-03
updated: 2025-12-03
author: karinam + copilot
owner: jakubc
---

# Plan scalenia duplikatów docs/ ↔ docs/infra/

## 🎯 Cel

Usunąć duplikaty folderów między `docs/` a `docs/infra/`, zachowując pełną zawartość.

## 📊 Zidentyfikowane duplikaty

### 1. **assets/** (DUPLIKAT)

**docs/assets/**
```
assets.md          (folder note, starszy)
map-eww.png        (91 KB - MAPA PROJEKTU!) ⭐
```

**docs/infra/assets/**
```
assets.md          (folder note, nowszy)
icons.md           (3 KB)
```

**DECYZJA:**
- ✅ Zachować: `docs/assets/` (główne miejsce dla assetów projektu)
- 📦 Przenieś z `docs/infra/assets/`:
  - `icons.md` → `docs/assets/icons.md`
- 🔄 Scalić `assets.md` (backlinki z obu)
- 🗑️ Usunąć: `docs/infra/assets/` (po przeniesieniu)

---

### 2. **guide/** (DUPLIKAT + różna zawartość!)

**docs/guide/** (2 pliki)
```
guide.md           (folder note, starszy, mniej backlinków)
intro.md           (481 B - ogólne intro)
```

**docs/infra/guide/** (10 plików!) ⭐
```
guide.md                      (folder note, nowszy, więcej backlinków)
intro.md                      (425 B - podobne do docs/guide/intro.md)
FOLDER-COLOR-SYSTEM.md        (4.1 KB)
FOLDER-NOTE-SYSTEM.md         (4.2 KB)
GITHUB-TOOLS-CHEATSHEET.md    (5.5 KB)
GITHUB-TOOLS.md               (7.7 KB)
INDEXING-GUIDE.md             (7.8 KB)
Makefile.md                   (1.6 KB)
neovim-guide.md               (7.8 KB)
readme-checklist.md           (2.2 KB)
```

**DECYZJA:**
- ✅ Zachować: `docs/infra/guide/` (więcej zawartości, lepiej rozwinięte)
- 📦 Przenieś z `docs/guide/`:
  - Porównaj `intro.md` - jeśli różne, zachować oba z sufiksem
- 🗑️ Usunąć: `docs/guide/` (po weryfikacji intro.md)
- 🔗 Utworzyć przekierowanie: `docs/guide.md` → link do `docs/infra/guide/`

---

### 3. **wiki/** (DUPLIKAT + podobna zawartość)

**docs/wiki/** (5 plików)
```
wiki.md            (folder note)
index.md           (432 B)
kubuntu.md         (248 B)
neovim.md          (247 B)
obsidian.md        (249 B)
```

**docs/infra/wiki/** (5 plików)
```
wiki.md            (folder note)
index.md           (366 B - RÓŻNY rozmiar!)
kubuntu.md         (491 B - RÓŻNY rozmiar!)
neovim.md          (296 B - RÓŻNY rozmiar!)
obsidian.md        (295 B - RÓŻNY rozmiar!)
```

**DECYZJA:**
- ⚠️ UWAGA: Rozmiary się różnią - mogą być różne treści!
- 📋 Najpierw porównać każdy plik (diff)
- ✅ Zachować: `docs/wiki/` (główne wiki projektu, nie tylko infra)
- 📦 Scalić różnice z `docs/infra/wiki/` (jeśli są unikalne informacje)
- 🗑️ Usunąć: `docs/infra/wiki/` (po scaleniu)

---

### 4. **infra/infra/** (DUPLIKAT NAZWY - confusion!)

**docs/infra/infra/** (podwójna nazwa)
```
ansible/           (katalog - playbooki?)
core/              (katalog - config core?)
hooks/             (katalog - git hooks?)
systemd/           (katalog - systemd units?)
infra.md           (folder note)
```

**DECYZJA:**
- 🚨 To NIE jest duplikat z `docs/`, ale duplikat NAZWY (infra/infra)
- ✅ Przenieś do: `docs/infra/configuration/` (lepiej opisuje zawartość)
- Struktura docelowa:
  ```
  docs/infra/configuration/
  ├── ansible/
  ├── core/
  ├── hooks/
  ├── systemd/
  └── README.md (z infra.md)
  ```

---

## 📋 Plan działania (krok po kroku)

### Krok 1: Backup
```bash
# Utwórz branch
git checkout -b feat/merge-docs-duplicates

# Backup
cp -r docs/ /tmp/docs-backup-$(date +%Y%m%d-%H%M%S)
```

### Krok 2: Scalenie **assets/**

```bash
# Przenieś unikalne pliki
mv docs/infra/assets/icons.md docs/assets/

# Scalij folder notes (ręcznie w edytorze)
# - Dodaj backlinka [[icons]] do docs/assets/assets.md
# - Zaktualizuj datę modified

# Usuń pusty folder
rm -rf docs/infra/assets/
```

### Krok 3: Scalenie **guide/**

```bash
# Porównaj intro.md
diff -u docs/guide/intro.md docs/infra/guide/intro.md

# Jeśli identyczne lub infra/guide/intro.md lepszy:
# Usuń docs/guide/
rm -rf docs/guide/

# Utwórz przekierowanie
cat > docs/guide.md <<'EOF'
---
title: "Guide - przekierowanie"
created: 2025-12-03
tags: [redirect]
---

# Guide

Dokumentacja przewodników znajduje się w [[infra/guide]].

## 🔗 Backlinks
- [[docs]]
EOF
```

### Krok 4: Scalenie **wiki/**

```bash
# Porównaj wszystkie pliki wiki
for file in docs/wiki/*.md; do
    basename=$(basename "$file")
    if [ -f "docs/infra/wiki/$basename" ]; then
        echo "=== Comparing $basename ==="
        diff -u "$file" "docs/infra/wiki/$basename"
    fi
done

# JEŚLI docs/wiki/ ma więcej/lepsze informacje:
# Przenieś unikalne z infra/wiki/ do wiki/
# Usuń docs/infra/wiki/

# JEŚLI docs/infra/wiki/ ma więcej:
# Przenieś docs/infra/wiki/ → docs/wiki/ (overwrite)
# Usuń docs/infra/wiki/
```

### Krok 5: Rename **infra/infra/** → **infra/configuration/**

```bash
# Przenieś
mv docs/infra/infra/ docs/infra/configuration/

# Rename folder note
mv docs/infra/configuration/infra.md docs/infra/configuration/README.md

# Zaktualizuj README.md
sed -i 's|docs/infra/infra|docs/infra/configuration|g' docs/infra/configuration/README.md
```

### Krok 6: Aktualizacja linków

```bash
# Znajdź wszystkie odniesienia do starych ścieżek
rg -l "docs/infra/assets" docs/
rg -l "docs/guide\b" docs/  # \b = word boundary
rg -l "docs/infra/wiki" docs/
rg -l "docs/infra/infra" docs/

# Zamień (przykład dla assets)
find docs/ -type f -name "*.md" -exec sed -i 's|docs/infra/assets|docs/assets|g' {} +
```

### Krok 7: Aktualizacja docs/infra/infra.md

```bash
# Usuń linki do usuniętych folderów z docs/infra/infra.md
# - [[assets]] (przeniesione do docs/assets)
# - [[guide]] (przeniesione/usunięte)
# - [[wiki]] (przeniesione/usunięte)
# - [[infra]] → [[configuration]]
```

### Krok 8: Walidacja

```bash
# Sprawdź czy nie zostały puste foldery
find docs/ -type d -empty

# Sprawdź czy nie ma martwych linków (Obsidian)
# Lub użyj: make check-links (jeśli istnieje)

# Sprawdź rozmiar
du -sh docs/infra/
```

### Krok 9: Commit

```bash
git add -A
git commit -m "fix(docs): merge duplicates between docs/ and docs/infra/

- Merged docs/assets/ ← docs/infra/assets/ (icons.md)
- Removed docs/guide/ (content in docs/infra/guide/)
- Merged docs/wiki/ ↔ docs/infra/wiki/
- Renamed docs/infra/infra/ → docs/infra/configuration/
- Updated all internal links
- Updated folder notes

Closes #XXX"
```

---

## ⚠️ Przed wykonaniem - TODO

- [ ] Porównać `docs/guide/intro.md` vs `docs/infra/guide/intro.md` (diff)
- [ ] Porównać WSZYSTKIE pliki w `docs/wiki/` vs `docs/infra/wiki/` (diff)
- [ ] Sprawdzić czy `docs/infra/infra/ansible/` zawiera ważne pliki
- [ ] Sprawdzić backlinki w Obsidian (Graph View)
- [ ] Utworzyć branch `feat/merge-docs-duplicates`
- [ ] Backup do `/tmp/`

---

## 📊 Podsumowanie zmian

| Folder | Akcja | Uzasadnienie |
|--------|-------|--------------|
| `docs/assets/` | ✅ Zachować + dodać `icons.md` | Główne miejsce assetów projektu |
| `docs/infra/assets/` | 🗑️ Usunąć | Duplikat, mniej zawartości |
| `docs/guide/` | 🗑️ Usunąć + przekierowanie | Mniej zawartości niż infra/guide/ |
| `docs/infra/guide/` | ✅ Zachować | Więcej przewodników (10 plików) |
| `docs/wiki/` | ✅ Zachować (po scaleniu) | Główne wiki projektu |
| `docs/infra/wiki/` | 📦 Scalić → `docs/wiki/` | Duplikat, potencjalnie różne treści |
| `docs/infra/infra/` | 🔄 Rename → `configuration/` | Duplikat nazwy (confusion) |

---

## 🔗 Powiązania

- [[DOCS-STRUCTURE-ANALYSIS]] - Pełna analiza struktury
- [[RESTRUCTURE-MAP]] - Globalny plan reorganizacji
- [[docs/infra/reports/CLEANUP-LOG]] - Log porządków

---

## 🔗 Backlinks

- [[docs/docs]]
- [[docs/infra/infra]]
- [[DOCS-STRUCTURE-ANALYSIS]]
