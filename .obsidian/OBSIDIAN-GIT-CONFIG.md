---
title: Obsidian Git - Konfiguracja Auto-Commit
tags:
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

### Automatyczny commit przy zamykaniu:

```bash
# W terminalu przed zamknięciem Obsidiana:
~/.obsidian/scripts/auto-commit-on-close.sh
```

### Lub dodaj alias do `~/.bashrc`:

```bash
alias obsidian-commit='~/.obsidian/scripts/auto-commit-on-close.sh'
alias oc='~/.obsidian/scripts/auto-commit-on-close.sh'
```

### Lub użyj Command Palette w Obsidian:

`Ctrl+P` → "Obsidian Git: Commit all changes"

## 📊 Statystyki

- **Limit plików w jednym widoku grafu:** 18 (Extended Graph)
- **Max Waypoints:** 20 (limit pluginu)
- **Total Notes:** ~1200-1500
- **Strategia:** Małe częste commity przy zamykaniu sesji

## 🔗 Backlinks

- [[obsidian-git]]
- [[Extended Graph]]
- [[Waypoint]]
- [[Git Workflow]]

## 📚 Źródła

- [Obsidian Git Plugin](https://github.com/denolehov/obsidian-git)
- [Extended Graph](https://github.com/SkepticMystic/extended-graph)
