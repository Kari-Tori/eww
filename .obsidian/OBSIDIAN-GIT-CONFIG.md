---
tags:
  - #automation
  - #config
  - #eww
  - #git
  - #linux
  - #obsidian
  - #secondbrain
title: Obsidian Git - Konfiguracja Auto-Commit
  - config/obsidian
  - git/automation
  - workflow
created: 2025-11-21
author: jakubc






---

# 🔧 Obsidian Git - Auto-Commit przy zamykaniu

## 📋 Konfiguracja

**Plugin:** `obsidian-git` (zainstalowany)

**Tryb działania:**
- ❌ **NIE** auto-commit co 5 minut
- ✅ **Commit TYLKO przy zamykaniu** Obsidiana
- ✅ Lokalnie w `/home/jakubc/git/eww`
- ✅ Bez auto-push (tylko local)

## 🚀 Użycie

### ✅ Automatyczny commit przy zamykaniu Obsidiana

**Skonfigurowano:**
- Plugin Obsidian Git z `commitOnClose: true`
- Pre-commit hook dzieli commity na max **18 plików**
- Backup tworzony automatycznie przy zamykaniu vaulta

### 🔄 Git Hook - Automatyczne dzielenie

**Lokalizacja:** `.githooks/pre-commit`

**Działanie:**
```bash
# Jeśli staged > 18 plików:
# → Automatycznie dzieli na chunki po ~18 plików
# → Tworzy osobne commity dla każdego chunka
# → Zapobiega przeciążeniu grafu (limit 255/20 nodes)

# Przykład:
git add .                 # 50 plików
git commit -m "update"    # → 3 commity po 17-18 plików
```

### 📝 Ręczny commit (Command Palette):

`Ctrl+P` → "Obsidian Git: Commit all changes"

### 🛠️ Skrypt pomocniczy:

```bash
# Manualnie uruchom dzielenie commitów:
.obsidian/scripts/commit-split.sh
```

## 📊 Statystyki i Limity

- **Max plików/commit:** 18 (git pre-commit hook)
- **Extended Graph nodes:** 255/500 (max 500)
- **Graph view limit:** 20 (Obsidian core)
- **Max Waypoints:** 20 (limit pluginu)
- **Total Notes:** ~1500-2000
- **Strategia:** Auto-commit przy zamykaniu + dzielenie na chunki

## 🎯 Cel

**Stabilny graf** bez przeciążenia:
- Małe commity = lepszy performance grafu
- Limit 18 plików = ~18 nodes/commit
- Historia commitów = ładna wizualizacja w Extended Graph

## 🔗 Backlinks

- [[obsidian-git]]
- [[Extended Graph]]
- [[Waypoint]]
- [[Git Workflow]]

## 📚 Źródła

- [Obsidian Git Plugin](https://github.com/denolehov/obsidian-git)
- [Extended Graph](https://github.com/SkepticMystic/extended-graph)
