---
tags:
  - #automation
  - #docs
  - #eww
  - #git
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "🔄 Obsidian Git - Konfiguracja Auto-Commit"






---

# 🔄 Obsidian Git - Konfiguracja Auto-Commit

## 📋 Opis

Automatyczne commitowanie zmian w vault przy **zamykaniu Obsidiana**, z inteligentnym podziałem na batche po **18 plików** (limit renderingu graph).

## ⚙️ Konfiguracja

### Pliki

```bash
/home/jakubc/git/eww/
├── .obsidian/plugins/obsidian-git/
│   └── data.json                      # Config pluginu
├── scripts/
│   ├── obsidian-commit-split.sh       # Główny skrypt commitowania
│   └── obsidian-quit-hook.sh          # Hook przy zamykaniu
└── .git/hooks/
    └── pre-commit-obsidian            # Validation hook
```

### Ustawienia Obsidian Git

```json
{
  "autoSaveInterval": 0,                          // NIE commituj co X minut
  "autoBackupAfterLatestCommitChanged": true,     // Commit przy zmianach
  "commitOnWorkspaceQuit": true,                  // ✅ Commit przy zamknięciu
  "commitMessageScript": "scripts/obsidian-commit-split.sh",
  "customMessageOnAutoBackup": true,
  "disablePush": true,                            // Bez auto-push
  "showStatusBar": true                           // Status w UI
}
```

## 🚀 Jak działa?

### 1. Przy zamykaniu Obsidiana

```
Obsidian → quit event → Obsidian Git plugin → commitMessageScript
```

### 2. Skrypt `obsidian-commit-split.sh`

```bash
# Sprawdź zmiany
git add -A
changed_files=($(git diff --cached --name-only))
total_files=${#changed_files[@]}

# Jeśli ≤ 18 plików
if [[ $total_files -le 18 ]]; then
    git commit -m "docs: ${total_files} plików - $(date)"
fi

# Jeśli > 18 plików - podziel
num_commits=$(( (total_files + 17) / 18 ))
for batch in {1..num_commits}; do
    # Commit po 18 plików
    git commit -m "docs: batch ${batch}/${num_commits} - 18 plików - $(date)"
done
```

### 3. Wynik w Git log

```bash
$ git log --oneline -5

9115d547 docs: batch 3/3 - 15 plików - 2025-11-21 13:28:35
67b6f2c2 docs: batch 2/3 - 18 plików - 2025-11-21 13:26:42
211bdbf2 docs: batch 1/3 - 18 plików - 2025-11-21 13:25:54
a5711bf8 docs: 12 plików - 2025-11-21 13:17:09
533ff806 docs: 7 plików - 2025-11-21 13:16:41
```

## 🎯 Korzyści

### Graph Rendering

- **18 plików/commit** = optymalna wielkość dla Obsidian graph
- Jeden commit = **jeden krok w graph history**
- Płynne przeglądanie historii zmian w graph view

### Automatyzacja

- ✅ **NIE** commituje co 5 min (brak spamu)
- ✅ **TAK** commituje przy zamknięciu vault
- ✅ Inteligentny podział (batch 1/3, 2/3, 3/3)
- ✅ Brak konfliktów merge

### Workflow

```
1. Pracujesz w Obsidian → edytujesz 50 plików
2. Zamykasz Obsidian → trigger
3. Plugin uruchamia skrypt
4. Skrypt tworzy 3 commity:
   - batch 1/3: 18 plików
   - batch 2/3: 18 plików  
   - batch 3/3: 14 plików
5. Gotowe! 
```

## 🧪 Test

```bash
# Test manualny
$ cd /home/jakubc/git/eww
$ ./scripts/obsidian-commit-split.sh

# Sprawdź wynik
$ git log --oneline -5
```

## 📊 Status

```bash
# W Obsidian - status bar pokazuje:
- 📝 Zmiany: 47 plików
- ⏳ Będzie 3 commity przy zamknięciu
```

## 🔗 Źródła

- [[obsidian-commit-split.sh]] - Główny skrypt
- [[pre-commit-obsidian]] - Validation hook
- [Obsidian Git Plugin](https://github.com/denolehov/obsidian-git)

## 👤 Autor

- **jakubc** - 2025-11-21
