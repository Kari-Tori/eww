---
tags:
  - #automation
  - #eww
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
  - #workflow
title: Obsidian Git - Workflow Commitowania
created: 2025-11-21
author: jakubc

---

# 🎯 Obsidian Git - Workflow Commitowania

## ✅ KONFIGURACJA GOTOWA!

**Status:** Obsidian Git skonfigurowany do commitowania TYLKO przy zamykaniu sesji.

## 🚀 Jak commitować zmiany:

### 1️⃣ Przez Terminal (POLECANE)
```bash
cd /home/jakubc/git/eww
oc  # alias dla obsidian-commit
```

lub pełna komenda:
```bash
/home/jakubc/git/eww/.obsidian/scripts/auto-commit-on-close.sh
```

### 2️⃣ Przez Obsidian Command Palette
- `Ctrl+P` → wpisz "Commit all changes" → Enter

### 3️⃣ Przez Hotkey (opcjonalnie)
Settings → Hotkeys → "Obsidian Git: Commit all changes" → ustaw `Ctrl+Shift+G`

## 📋 Co robi auto-commit:

```bash
✅ Dodaje wszystkie zmiany (git add)
✅ Tworzy commit z timestampem
✅ Pokazuje liczbę zmienionych plików
✅ Pomija submoduł infra/core
✅ Format: "docs(obsidian): X plików - 2025-11-21 13:16:41"
```

## 🔧 Ustawienia pluginu:

| Parametr | Wartość | Opis |
|----------|---------|------|
| `autoSaveInterval` | `0` | WYŁĄCZONY auto-commit |
| `autoBackupAfterFileChange` | `false` | Brak auto-backup |
| `disablePush` | `true` | Tylko lokalne commity |
| `showStatusBar` | `true` | Status bar widoczny |
| `changedFilesInStatusBar` | `true` | Liczba zmian w pasku |

## 📊 Limity i optymalizacja:

- **Max nodes w Extended Graph:** 20 (dla wydajności)
- **Max Waypoints:** 20 (limit pluginu)
- **Total notes:** ~1200-1500
- **Strategia:** Małe, częste commity przy zamykaniu

## 🔗 Backlinks:

- [[OBSIDIAN-GIT-CONFIG]]
- [[Extended Graph]]
- [[Waypoint]]
- [[Git Workflow]]

## 📚 Źródła:

- [Obsidian Git](https://github.com/denolehov/obsidian-git)
- [EWW Repository](file:///home/jakubc/git/eww)

---

**Ostatnia aktualizacja:** 2025-11-21  
**Autor:** jakubc
