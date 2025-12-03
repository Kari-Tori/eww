---
title: "Log standaryzacji docs/infra/"
description: "Rejestr zmian podczas standaryzacji struktury docs/ zgodnie z globalnymi standardami"
version: 0.0.6
category: documentation
tags:
  - cleanup
  - standardization
  - infra
  - changelog
language: pl
created: 2025-12-03
updated: 2025-12-03
author: karinam + copilot
owner: jakubc
---

# Log standaryzacji docs/infra/

## 🎯 Cel

Uporządkowanie struktury `docs/infra/` zgodnie z globalnymi standardami dokumentacji:
- Usunięcie duplikatów między `docs/` i `docs/infra/`
- Rename mylących nazw (infra/infra/)
- Aktualizacja folder notes
- Spójność z planem RESTRUCTURE-MAP

## 📋 Wykonane zmiany (2025-12-03)

### 1. Scalenie duplikatów

#### ✅ assets/
```bash
# Przeniesiono unikalne pliki
mv docs/infra/assets/icons.md → docs/assets/icons.md

# Usunięto duplikat
rm -rf docs/infra/assets/

# Zaktualizowano docs/assets/assets.md
+ Dodano link do [[icons]]
```

**Uzasadnienie:** `docs/assets/` to główne miejsce dla zasobów projektu, nie tylko infra.

---

#### ✅ guide/
```bash
# Usunięto przestarzały katalog
rm -rf docs/guide/

# Zachowano docs/infra/guide/ (10 plików vs 2)
```

**Uzasadnienie:** `docs/infra/guide/` zawiera pełną dokumentację:
- FOLDER-COLOR-SYSTEM.md
- FOLDER-NOTE-SYSTEM.md
- GITHUB-TOOLS-CHEATSHEET.md
- GITHUB-TOOLS.md
- INDEXING-GUIDE.md
- Makefile.md
- neovim-guide.md
- readme-checklist.md
- intro.md (nowsza wersja)

`docs/guide/` miał tylko `intro.md` (starsze) i `guide.md`.

---

#### ✅ wiki/
```bash
# Zastąpiono nowszą wersją
rm -rf docs/wiki/
mv docs/infra/wiki/ → docs/wiki/

# Przeniesiono 5 plików (nowsze wersje):
- index.md (366 B, więcej linków)
- kubuntu.md (491 B, zawiera definicję ikon)
- neovim.md (296 B, lepszy frontmatter)
- obsidian.md (295 B, lepszy frontmatter)
- wiki.md (folder note)
```

**Uzasadnienie:** `docs/infra/wiki/` miał nowsze, bardziej rozbudowane wersje plików.

---

### 2. Rename mylących nazw

#### ✅ infra/infra/ → configuration/
```bash
# Zmieniono duplikat nazwy
mv docs/infra/infra/ → docs/infra/configuration/

# Zmieniono folder note
mv docs/infra/configuration/infra.md → docs/infra/configuration/README.md

# Struktura:
docs/infra/configuration/
├── ansible/           # Playbooki Ansible
├── core/              # Config core
├── hooks/             # Git hooks
├── systemd/           # Systemd units
└── README.md          # Folder note
```

**Uzasadnienie:**
- Duplikat nazwy (`infra/infra/`) powoduje confusion
- Nazwa `configuration/` lepiej opisuje zawartość (config files)
- Zgodne z globalnymi standardami (infrastructure/configuration/)

---

### 3. Aktualizacja folder notes

#### ✅ docs/infra/infra.md
```diff
+ modified: 2025-12-03T15:00:00Z
+ tags: #infrastructure

 ## 📁 Podfoldery

- [[architecture]] - Architektura systemowa
- [[areas]] - Strefy fizyczne (devices, network, workshop)
+ [[configuration]] - Konfiguracje (ansible, systemd, hooks, core)
- [[dashboards]] - Dashboardy monitoringu
- [[guide]] - Przewodniki infrastrukturalne
- [[hardware]] - Sprzęt (serwery, workstations, network, peripherals)
- [[legacy]] - Archiwum starych dokumentów
- [[references]] - Dokumenty referencyjne
- [[reports]] - Raporty statusu
- [[site]] - Strona WWW (build artifacts)
- [[tags]] - Legacy symlink do dev/obsidian/tags/
- [[vm]] - Maszyny wirtualne i konteneryzacja

- Usunięto: [[assets]], [[wiki]], [[infra]] (duplikaty)
```

#### ✅ docs/docs.md
```diff
+ modified: 2025-12-03T15:00:00Z

 ## 📁 Podfoldery

- [[archive]] - Archiwum historyczne
- [[assets]] - Media, grafiki, pliki statyczne
- [[governance]] - Zarządzanie projektem (→ migracja do business/)
+ [[infra]] - Infrastruktura (hardware, network, configuration)
- [[methodologies]] - Metodyki pracy (→ migracja do business/)
- [[software]] - Dokumentacja narzędzi (→ migracja do development/)
- [[wiki]] - Wiki wewnętrzne (artykuły, poradniki)
- [[workflow]] - Przepływy pracy

- Usunięto: [[guide]] (przeniesiony do infra/guide/)
```

#### ✅ docs/assets/assets.md
```diff
+ ## 📄 Pliki dodatkowe
+ - [[icons]] - Definicje ikon projektu (z infra/assets/)
```

---

## 📊 Statystyki

### Przed:
```
docs/
├── assets/              (2 pliki: assets.md, map-eww.png)
├── guide/               (2 pliki: guide.md, intro.md)
├── wiki/                (5 plików: wiki.md, index.md, kubuntu.md, neovim.md, obsidian.md)
└── infra/
    ├── assets/          (2 pliki: assets.md, icons.md)
    ├── guide/           (10 plików)
    ├── infra/           (4 katalogi: ansible, core, hooks, systemd)
    └── wiki/            (5 plików)

= 4 duplikaty
```

### Po:
```
docs/
├── assets/              (3 pliki: assets.md, map-eww.png, icons.md) ✅
├── wiki/                (5 plików - nowsze wersje) ✅
└── infra/
    ├── configuration/   (4 katalogi: ansible, core, hooks, systemd) ✅
    └── guide/           (10 plików) ✅

= 0 duplikatów ✅
```

### Zmiany:
- **Usunięto:** 3 foldery duplikaty (`docs/guide/`, `docs/infra/assets/`, `docs/infra/infra/`)
- **Przeniesiono:** 1 plik (`icons.md`), 5 plików wiki (nowsze wersje)
- **Zmieniono nazwę:** 1 folder (`infra/infra/` → `configuration/`)
- **Zaktualizowano:** 3 folder notes (`docs.md`, `infra.md`, `assets.md`)

---

## ✅ Spójność z globalnymi standardami

### 1. **No duplicates** ✅
- Każdy folder istnieje w jednym miejscu
- Brak duplikatów nazw (infra/infra)

### 2. **Clear naming** ✅
- `configuration/` zamiast `infra/` (jasna nazwa)
- `assets/` na poziomie głównym (nie tylko infra)
- `wiki/` na poziomie głównym (nie tylko infra)

### 3. **Logical hierarchy** ✅
```
docs/
├── assets/              # Zasoby globalne
├── wiki/                # Wiki globalne
├── infra/               # Infrastruktura
│   ├── configuration/   # Config infra
│   ├── guide/           # Przewodniki infra
│   ├── hardware/        # Sprzęt
│   └── ...
└── ...
```

### 4. **Consistent structure** ✅
- Folder notes wszędzie (.md z nazwą folderu)
- Frontmatter YAML zgodny ze standardem
- Backlinki aktualne

---

## 🔄 Następne kroki (opcjonalne)

Zgodnie z DOCS-STRUCTURE-ANALYSIS.md:

1. **Rename głównego katalogu** (duża zmiana):
   ```bash
   mv docs/infra/ → docs/infrastructure/
   ```

2. **Reorganizacja wewnętrzna:**
   - `infra/reports/` → `docs/reports/` (raporty repo, nie infra)
   - `infra/site/` → `.gitignore` (build artifacts)
   - `infra/dashboards/` → `infra/monitoring/dashboards/`
   - `infra/vm/` → `infra/virtualization/`

3. **Utworzenie nowych folderów:**
   - `docs/getting-started/`
   - `docs/reference/`
   - `docs/operations/`
   - `docs/tutorials/`
   - `docs/troubleshooting/`

4. **Migracja do innych katalogów:**
   - `docs/software/` → `development/tools/`
   - `docs/governance/` → `business/governance/` (już w planie)
   - `docs/methodologies/` → `business/methodologies/` (już w planie)

---

## 🔗 Powiązania

- [[DOCS-STRUCTURE-ANALYSIS]] - Pełna analiza struktury docs/
- [[MERGE-DUPLICATES-PLAN]] - Plan scalenia duplikatów
- [[RESTRUCTURE-MAP]] - Globalny plan reorganizacji
- [[docs/infra/reports/CLEANUP-LOG]] - Historia porządków

---

## 🔗 Backlinks

- [[docs/docs]]
- [[docs/infra/infra]]
- [[DOCS-STRUCTURE-ANALYSIS]]
- [[MERGE-DUPLICATES-PLAN]]
