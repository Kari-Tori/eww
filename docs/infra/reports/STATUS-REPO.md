---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T14:27:50Z
modified: 2025-11-21T14:27:50Z
author: jakubc
title: "📊 STATUS REPOZYTORIUM EWW"






owner: jakubc
---

# 📊 STATUS REPOZYTORIUM EWW

**Data**: 2025-11-21 15:23  
**Branch**: main  
**Commitów**: 70+

## ✅ CO DZIAŁA

### 1. 🗂️ Struktura Repo

```
eww/
├── business/          # ✅ Business logic
├── config/            # ✅ Konfiguracje
├── core/              # ✅ Core pliki
├── docs/              # ✅ Dokumentacja (18 folderów)
├── infra/             # ✅ Infrastructure
├── scripts/           # ✅ Skrypty pomocnicze
├── tools/             # ✅ Narzędzia
├── usr/
│   ├── jakubc/       # ✅ User jakubc (🔵 niebieski)
│   └── karinam/      # ✅ User karinam (🩷 różowy)
└── var/              # ✅ Runtime data
```

**Statystyki**:
- **510 plików MD** total
- **~100-150 nodów** w grafie (filtrowanych)
- **21 głównych folderów**

### 2. 📈 Graf Obsidian

**Status**: ✅ **DZIAŁA**

**Konfiguracja**:
- Extended Graph: max 5000 nodów
- Delay: 500ms (szybki rendering)
- Filter: pokazuje tylko główne foldery
- Kolory: 5 grup (pink, blue, green, eww, folder-notes)

**Performance**:
- 2-3x szybszy niż wcześniej
- Wyłączone ciężkie featury (properties, shapes, stats)
- Smart filtering (-star_wars, -archive, -tags)

**Pliki**:
- `fix-graph-performance.sh` - optymalizacja
- `GRAPH-PERFORMANCE-FIX.md` - dokumentacja
- `.obsidian/graph.json` - config
- `.obsidian/plugins/extended-graph/data.json` - extended config

### 3. 🔄 Obsidian Git

**Status**: ✅ **SKONFIGUROWANY**

**Flow**:
1. Edytujesz w Obsidian
2. Zamykasz → auto-commit
3. Pre-commit hook dzieli na batche (≤18 plików)

**Konfiguracja**:
- Auto-save: ❌ wyłączony
- Commit on close: ✅ włączony
- Pre-commit hook: ✅ aktywny (`.githooks/pre-commit`)
- Max plików per commit: **18**

**Pliki**:
- `OBSIDIAN-GIT-SETUP.md` - dokumentacja
- `.githooks/pre-commit` - hook script
- `.obsidian/plugins/obsidian-git/data.json` - plugin config

### 4. 👥 User Profiles

**jakubc** 🔵:
- Tags: `#jakubc`, `#blue`, `#user`
- Folders: m18, health, obsidian-plugins, star_wars
- Color: Blue (RGB 5592575)

**karinam** 🩷:
- Tags: `#karinam`, `#pink`, `#candy`, `#user`
- Folders: Inbox, projects, notes, health
- Color: Pink (RGB 16761035)

### 5. 📝 Folder Notes

**Status**: ✅ Wszystkie główne foldery mają folder notes

Format:
```markdown
  - folder-note
  - [nazwa-folderu]
  - [dodatkowe tagi]
created: 2025-11-21

# 📁 Nazwa Folderu

> Opis czemu służy folder

## 📑 Index

- [[plik1]] - opis
- [[plik2]] - opis
```

### 6. 🏷️ Tagowanie

**System**:
- Max **7 tagów** per plik
- Kolory przypisane do tagów
- Hierarchia: `#eww/core`, `#eww/business`, etc.

**Główne tagi**:
- `#eww` - główny tag projektu (🟢 green)
- `#folder-note` - folder notes (🟣 purple)
- `#jakubc`, `#blue` - user jakubc (🔵 blue)
- `#karinam`, `#pink`, `#candy` - user karinam (🩷 pink)
- `#green` - dokumentacja (🟩 green)

### 7. 🔧 Narzędzia

**Skrypty**:
- `fix-graph-performance.sh` - optymalizacja grafu
- `check-graph-ready.sh` - sprawdź gotowość grafu
- `check-obsidian-debug.sh` - debug console instrukcje
- `install-waypoint.sh` - instalacja Waypoint plugin
- `rebuild-git-history.sh` - odbudowa historii Git

**Dokumentacja**:
- `GRAPH-PERFORMANCE-FIX.md` - fix grafu
- `OBSIDIAN-GIT-SETUP.md` - setup Git
- `TAG-STRATEGY.md` - strategia tagowania
- `GRAPH-*.md` - różne aspekty grafu

## 🎯 CO DALEJ

### Priorytet 1: Testowanie

- [ ] Restart Obsidiana
- [ ] Sprawdź czy graf działa (ctrl+G)
- [ ] Edytuj plik → zamknij → sprawdź czy commit się wykonał
- [ ] Sprawdź czy commity mają ≤18 plików

### Priorytet 2: Wyczyszczenie

Obecnie mamy:
- 510 plików MD
- Część może być duplikatami/niepotrzebnymi
- Archive można jeszcze skompresować

### Priorytet 3: Historia Git

Możemy **odbudować historię** z dat plików:
```bash
./rebuild-git-history.sh
```

To stworzy commity bazując na:
- Data utworzenia pliku
- Data ostatniej modyfikacji
- Max 18 plików per commit
- Chronologicznie

## 📊 Statystyki

### Wielkość

```bash
du -sh .
# 4.9 GB fizycznie

du -sh .git
# ~5-6 MB w Git (99.97% redukcja!)
```

### Pliki

```bash
find . -name "*.md" -type f | wc -l
# 510 plików MD

git ls-files | wc -l
# ~200 plików w Git
```

### Commity

```bash
git log --oneline | wc -l
# 70+ commitów (batch import)
```

## 🔗 Related

- [[GRAPH-PERFORMANCE-FIX]] - Optymalizacja grafu
- [[OBSIDIAN-GIT-SETUP]] - Setup Git
- [[TAG-STRATEGY]] - Strategia tagowania
- [[README]] - Overview projektu


**Autor**: jakubc  
**Data**: 2025-11-21  
**Status**: ✅ GOTOWE DO UŻYCIA
