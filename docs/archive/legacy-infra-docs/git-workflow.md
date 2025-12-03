created: 2025-11-21T10:00:00Z
modified: 2025-11-24T22:31:13Z
author: jakubc
---
tags:
  - #automation
  - #docs
  - #eww
  - #git
  - #linux
  - #secondbrain
  - #workflow
title: "🔄 Git Workflow - Batch Commits dla EWW"






owner: jakubc
created: 2025-11-21T10:00:00Z
modified: 2025-11-24T22:31:13Z
author: jakubc
---

# 🔄 Git Workflow - Batch Commits dla EWW

## 📋 Problem

**Obsidian Graph** ma limit renderowania:
- **Extended Graph**: max 255 nodes
- **Standard Graph**: max ~1200 nodes (przy 20 waypoints × 30 sek)
- **Wydajność**: przy 3800+ plikach graph się wykrzacza

**Rozwiązanie**: Commituj małe porcje plików (max **18** na commit), aby:
- ✅ Uniknąć przeciążenia grafu
- ✅ Zachować czytelną historię Git
- ✅ Umożliwić łatwe rollbacki


## 🚀 Konfiguracja

### 1. Obsidian Git Plugin

**Lokalizacja**: `.obsidian/plugins/obsidian-git/data.json`

**Kluczowe ustawienia**:
```json
{
  "autoSaveInterval": 5,          // Auto-commit co 5 min
  "disablePush": true,             // Tylko local (bez remote)
  "autoPushInterval": 0,           // Wyłącz auto-push
  "autoPullInterval": 0,           // Wyłącz auto-pull
  "autoBackupAfterFileChange": true,
  "listChangedFilesInMessageBody": true,
  "changedFilesInStatusBar": true
}
```

### 2. Batch Commit Script

**Lokalizacja**: `scripts/git-commit-batch.sh`

**Użycie**:
```bash
# Standardowe batch commit (max 18 plików/commit)
./scripts/git-commit-batch.sh

# Z verbose output (pokaż pliki w każdym batchu)
VERBOSE=1 ./scripts/git-commit-batch.sh

# Z custom limitem plików
MAX_FILES=10 ./scripts/git-commit-batch.sh
```


## 📦 Jak to działa?

### Auto-commit flow

1. **Obsidian Git** wykrywa zmiany co 5 min
2. Jeśli zmian > 18:
   - Script dzieli na batche po 18 plików
   - Każdy batch → osobny commit
3. Commit message: `docs: batch 1/5 - 18 plików - 2025-11-21 14:30:00`

### Manual commit flow

```bash
# Sprawdź status
git status

# Batch commit wszystkich zmian
./scripts/git-commit-batch.sh

# Zobacz historię
git log --oneline -n 10
```


## 🎯 Zalety tego podejścia

| Feature | Korzyść |
|---------|---------|
| **Max 18 plików/commit** | Graph renderuje się płynnie |
| **Local-only** | Brak kosztów cloud, wszystko FREE |
| **Auto-backup** | Obsidian Git co 5 min |
| **Czytelna historia** | Każdy batch = osobny commit |
| **Easy rollback** | `git revert <commit>` dla konkretnego batcha |


## 🔧 Integracja z Makefile

**Dodaj do `Makefile`**:

```make
.PHONY: git-batch git-status git-history

## Batch commit (max 18 plików)
git-batch:
	@./scripts/git-commit-batch.sh

## Pokaż status Git
git-status:
	@git --no-pager status

## Pokaż ostatnie 20 commitów
git-history:
	@git --no-pager log --oneline -n 20 --color=always
```

**Użycie**:
```bash
make git-batch    # Batch commit
make git-status   # Status
make git-history  # Historia
```


## 📊 Limity i optymalizacja

### Graph Limits

| Plugin | Limit Nodes | Limit Waypoints | Rekomendacja |
|--------|-------------|-----------------|--------------|
| **Standard Graph** | ~1200 | 18-20 | ✅ Używaj tego |
| **Extended Graph** | 255 | - | ❌ Za mało |
| **Graph Analysis** | ~5000 | - | ⚠️ Wolne |

### Batch Strategy

```bash
# Przykład: 100 plików zmienionych
# → 6 commitów (18+18+18+18+18+10)

Batch 1/6: 18 plików - config/, docs/
Batch 2/6: 18 plików - business/
Batch 3/6: 18 plików - core/
Batch 4/6: 18 plików - usr/jakubc/
Batch 5/6: 18 plików - usr/karinam/
Batch 6/6: 10 plików - root files
```


## 🛠️ Troubleshooting

### Problem: "Too many to handle 1584"

**Przyczyna**: Za dużo plików w jednym commicie

**Rozwiązanie**:
```bash
# Reset ostatniego commita
git reset HEAD~1

# Batch commit ponownie
./scripts/git-commit-batch.sh
```

### Problem: Graph się wolno renderuje

**Przyczyna**: Za dużo nodes (3800+)

**Rozwiązanie**:
- Użyj **graph filters** (Settings → Graph → Filters)
- Ogranicz do konkretnych folderów: `path:docs/` lub `path:business/`
- Użyj **Search + Graph**: szukaj konkretnych tagów, potem "Open in Graph"

### Problem: Obsidian Git nie commituje auto

**Sprawdź**:
```bash
# 1. Plugin włączony?
cat .obsidian/community-plugins.json | grep obsidian-git

# 2. Konfiguracja OK?
cat .obsidian/plugins/obsidian-git/data.json | grep autoSaveInterval

# 3. Git repo zainicjowane?
git status
```


## 📚 Źródła i narzędzia

### Pluginy Obsidian

- [[obsidian-git]] - Auto-backup do Git
- [[waypoint]] - Folder notes + auto-index
- [[folder-notes]] - Folder notes support
- [[dataview]] - Queries dla folder notes

### Skrypty

- [[git-commit-batch.sh]] - Batch commit max 18 plików
- [[init-eww.sh]] - Inicjalizacja środowiska EWW

### Dokumentacja

- [[git-workflow]] - Ten dokument
- [[TAG-STRATEGY]] - Strategia tagowania
- [[docs]] - Główny index dokumentacji


## 🎨 Graph Configuration

**Rekomendowane ustawienia** (Settings → Graph):

```
Filters:
  - orphans: off
  - tags: on
  - attachments: off

Display:
  - arrows: on
  - text fade threshold: 0
  - node size: 3
  - link thickness: 1

Forces:
  - center force: 0.3
  - repel force: 200
  - link force: 0.5
  - link distance: 100
```


**Status**: ✅ Active  
**Maintainer**: [[jakubc]]  
**Last Update**: 2025-11-21

## 🔗 Backlinks

- [[docs/infra/legacy/legacy]]
- [[docs/docs]]
- [[INDEX]]
