---
title: Obsidian Git - Auto-Commit z limitem 18 plików
tags: [obsidian, git, automation, eww, config, workflow, tools]
created: 2025-11-21
author: jakubc
---

# 🔧 Obsidian Git - Auto-Commit (max 18 plików/commit)

**Rozwiązuje:** "too many to handle" w graph rendering (limit 20 commitów × 18 plików = 360 w grafie)

---

## ✅ Skonfigurowano

- ✅ **Skrypt:** `/home/jakubc/git/eww/scripts/obsidian-commit-split.sh`
- ✅ **Hook:** `.git/hooks/obsidian-shutdown` (auto przy zamknięciu)
- ✅ **Plugin:** Obsidian Git (bez auto-save, tylko shutdown)

## 📋 Jak działa

- **≤18 plików:** 1 commit  
- **>18 plików:** Dzieli na batche (np. 50 → 3 commity: 18+18+14)

## 🎯 Użycie

```bash
# Manual test
./scripts/obsidian-commit-split.sh

# Auto przy zamknięciu Obsidiana (Ctrl+Q)
```

## 🔍 Weryfikacja

```bash
git log --oneline -10        # Ostatnie commity
git show --stat              # Pliki w ostatnim
```

## ⚙️ Konfiguracja

**Zmień limit:**
```bash
# Edytuj scripts/obsidian-commit-split.sh
readonly MAX_FILES_PER_COMMIT=18  # ← zmień wartość
```

---

**Linki:** [[eww.md]] · [[git-workflow.md]] · [[obsidian-plugins.md]]
