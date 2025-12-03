---
version: 0.0.3
tags:
  - #automation
  - #docs
  - #eww
  - #graph
  - #knowledge
  - #obsidian
created: 2025-11-23
modified: 2025-11-28
author: jakubc
title: "🤖 Automatyczne Generowanie Grafu Obsidian"
owner: jakubc
---

# 🤖 Automatyczne Generowanie Grafu Obsidian

> **System automatycznego generowania i commitowania konfiguracji grafu**

## 📋 Zasady Stacka

### 🎯 Limity Techniczne

| Parametr | Wartość | Opis |
|----------|---------|------|
| **Max nodes total** | 5000 | Hard limit Obsidian |
| **Max nodes per render** | 18 | Dla daily auto-commit |
| **Max waypoint folders** | 20 | Top folderów z folder_note |

### 🔄 Automatyzacja

1. **Generowanie konfiguracji** - top 20 folder_note
2. **Auto-commit** - max 18 nodes per commit
3. **Podział na batche** - jeśli zmian > 18, dzieli na porcje

---

## 🛠️ Narzędzia

### 1️⃣ `generate-graph-config.sh`

Generuje konfigurację grafu na podstawie folder notes.

**Algorytm**:
1. Znajdź wszystkie folder notes (z tagiem `#folder_note` lub `type: folder-note`)
2. Policz pliki w każdym folderze
3. Sortuj według liczby plików
4. Weź top 20
5. Wygeneruj `graph.json` z kolorami
6. Zaktualizuj `waypoint/data.json`

**Użycie**:
```bash
./scripts/generate-graph-config.sh
```

**Output**:
- `.obsidian/graph.json` - konfiguracja grafu
- `.obsidian/plugins/waypoint/data.json` - config waypoint
- Raport top 20 folder notes

**Kolory**: Każdy folder_note otrzymuje unikalny kolor z palety 20 kolorów.

---

### 2️⃣ `daily-graph-commit.sh`

Daily auto-commit zmian w grafie z limitem 18 nodes per commit.

**Algorytm**:
1. Znajdź zmienione pliki:
   - `.obsidian/graph*.json`
   - `.obsidian/plugins/waypoint/data.json`
   - Folder notes (z tagiem)
2. Policz zmiany
3. **Jeśli ≤ 18**: jeden commit
4. **Jeśli > 18**: podziel na batche i commituj w pętli

**Użycie**:
```bash
./scripts/daily-graph-commit.sh
```

**Przykład** (50 zmian):
```
Zmian (50) > 18
Dzielę na 3 batchy...
✓ Batch 1/3 committed (18 plików)
✓ Batch 2/3 committed (18 plików)
✓ Batch 3/3 committed (14 plików)
```

---

## 📊 Waypoint Integration

### Konfiguracja Waypoint

**Lokalizacja**: `.obsidian/plugins/waypoint/data.json`

```json
{
%% Error: Cannot create a waypoint in a note that's not the folder note. For more information, check the instructions [here](https://github.com/IdreesInc/Waypoint) %%
  "stopScanAtFolderNotes": true,
  "showFolderNotes": true,
  "maxFiles": 20,
  "maxDepth": 2
}
```

### Funkcje Waypoint

- **Top 20 folder_note** według liczby plików
- **Automatyczne kolory** zgodne z folder note
- **Limit 20 plików** per folder note
- **Max 2 poziomy** głębokości

---

## 🎨 System Kolorów

### Paleta 20 Kolorów

| Index | Kolor | RGB | Hex |
|-------|-------|-----|-----|
| 0 | 🟢 Jasny zielony | 65331 | #00FF33 |
| 1 | 🔴 Czerwony | 16711680 | #FF0000 |
| 2 | 🔵 Niebieski | 255 | #0000FF |
| 3 | 🟡 Żółty | 16776960 | #FFFF00 |
| 4 | 🟣 Magenta | 16711935 | #FF00FF |
| 5 | 🔷 Cyan | 65535 | #00FFFF |
| 6 | 🟠 Pomarańczowy | 16744448 | #FF8C00 |
| 7 | 🟣 Fioletowy | 9109504 | #8B00FF |
| 8 | 🔵 Jasny niebieski | 52479 | #00CCFF |
| 9 | 🟪 Purpurowy | 11141290 | #AA00AA |
| 10 | 🔷 Błękit | 43775 | #00AAFF |
| 11 | 🟡 Złoty | 16753920 | #FFA500 |
| 12 | 🟢 Zielony las | 2664719 | #28AA0F |
| 13 | 🟠 Pomarańcz | 16724736 | #FF6600 |
| 14 | 🟣 Indygo | 5570815 | #5500FF |
| 15 | 🔵 Lodowy | 13434879 | #CCFFFF |
| 16 | 🩷 Różowy | 16744319 | #FF007F |
| 17 | 🔷 Turkusowy | 8388863 | #7FFFFF |
| 18 | 🟡 Jasnożółty | 16777088 | #FFFF80 |
| 19 | 🔴 Ciemnoczerwony | 12582912 | #C00000 |

**Algorytm**: Kolor przypisywany przez `index % 20`

---

## 🔄 Workflow

### 1. Generacja konfiguracji

```bash
# Wygeneruj graph.json i waypoint config
./scripts/generate-graph-config.sh
```

**Output**:
```
[INFO] Szukam folder notes...
[INFO] Walidacja liczby nodes...
  core/: 43 plików
  docs/: 423 plików
  usr/: 266 plików
  ...
[INFO] Łączna liczba nodes: 789
[OK] Walidacja OK: 789 nodes
[OK] Wygenerowano: .obsidian/graph.json
[OK] Zaktualizowano: .obsidian/plugins/waypoint/data.json

📊 Top 20 folder notes:
 1. docs/ (423 plików) - kolor: #00FF33
 2. usr/ (266 plików) - kolor: #FF0000
 3. core/ (43 plików) - kolor: #0000FF
 ...
```

### 2. Daily auto-commit

```bash
# Daily commit zmian (max 18 per commit)
./scripts/daily-graph-commit.sh
```

**Scenariusze**:

#### A) Mało zmian (≤18)
```
[INFO] Znaleziono 12 zmienionych plików
[INFO] Commit wszystkich zmian (≤18)...
[OK] Batch 1/1 committed
```

#### B) Dużo zmian (>18)
```
[INFO] Znaleziono 50 zmienionych plików
[WARN] Zmian (50) > 18
[WARN] Dzielę na 3 batchy...
[INFO] Commit batch 1/3 (18 plików)...
[OK] Batch 1/3 committed
[INFO] Commit batch 2/3 (18 plików)...
[OK] Batch 2/3 committed
[INFO] Commit batch 3/3 (14 plików)...
[OK] Batch 3/3 committed
```

### 3. Restart Obsidian

```
Ctrl+R w Obsidian
```

---

## 📁 Folder Notes

### Wymagania

Plik jest **folder note** jeśli zawiera:

**YAML frontmatter**:
```yaml
---
type: folder-note
---
```

**LUB tag**:
```markdown
#folder_note
#folder.note
```

### Przykład folder note

```markdown
---
type: folder-note
tags:
  - #folder_note
  - #docs
title: "📚 Dokumentacja"
---

# 📚 Dokumentacja

%% Error: Cannot create a waypoint in a note that's not the folder note. For more information, check the instructions [here](https://github.com/IdreesInc/Waypoint) %%
- [[file1]]
- [[file2]]
%% Error: Cannot create a waypoint in a note that's not the folder note. For more information, check the instructions [here](https://github.com/IdreesInc/Waypoint) %%
```

---

## 🔧 Konfiguracja Makefile

Dodaj do `Makefile`:

```makefile
##@ Graph

.PHONY: graph-generate
graph-generate: ## Generuj konfigurację grafu
	./scripts/generate-graph-config.sh

.PHONY: graph-commit
graph-commit: ## Daily commit grafu (max 18 nodes)
	./scripts/daily-graph-commit.sh

.PHONY: graph-full
graph-full: graph-generate graph-commit ## Pełny workflow grafu
	@echo "Graf wygenerowany i zacommitowany!"
```

**Użycie**:
```bash
make graph-generate  # Wygeneruj config
make graph-commit    # Commit zmian
make graph-full      # Oba kroki
```

---

## ⚙️ Automatyzacja Cron

### Daily auto-commit (codziennie o 23:00)

```bash
# Edytuj crontab
crontab -e

# Dodaj linię
0 23 * * * cd /home/jakubc/git/eww && ./scripts/daily-graph-commit.sh >> /tmp/eww-graph-commit.log 2>&1
```

### Weekly regeneracja (niedziela o 02:00)

```bash
# Regeneruj config co tydzień
0 2 * * 0 cd /home/jakubc/git/eww && ./scripts/generate-graph-config.sh >> /tmp/eww-graph-regen.log 2>&1
```

---

## 📈 Monitoring

### Sprawdź status

```bash
# Ile nodes obecnie
grep -c "path:" .obsidian/graph.json

# Top folder notes
./scripts/generate-graph-config.sh | grep "^[0-9]"

# Zmiany do commitowania
git diff --name-only | wc -l
```

### Logi

- **Generate**: `/tmp/eww-graph-regen.log`
- **Commit**: `/tmp/eww-graph-commit.log`

---

## 🚨 Troubleshooting

### Problem: "Łączna liczba nodes przekracza 5000"

**Rozwiązanie**: Zmniejsz `MAX_WAYPOINT_FOLDERS` w skrypcie:
```bash
readonly MAX_WAYPOINT_FOLDERS=15  # Zamiast 20
```

### Problem: "Too many commits"

**Rozwiązanie**: Zwiększ `MAX_NODES_PER_COMMIT`:
```bash
readonly MAX_NODES_PER_COMMIT=25  # Zamiast 18
```

### Problem: "Folder note nie jest wykrywany"

**Sprawdź**:
1. Czy plik ma tag `#folder_note`?
2. Czy YAML ma `type: folder-note`?
3. Czy plik nie jest w `.gitignore`?

---

## 📚 Powiązane

- [[GRAPH-OPTIMIZATION]] - Optymalizacja grafu
- [[GRAPH-TUNING]] - Tuning parametrów
- [[FOLDER-NOTE-SYSTEM]] - System folder notes
- [[OBSIDIAN-SETUP]] - Setup Obsidian

---

**Status**: ✅ AKTYWNE
**Ostatnia aktualizacja**: 2025-11-23
**Autor**: jakubc

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]