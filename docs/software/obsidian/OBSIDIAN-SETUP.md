---
version: 0.0.5
tags:
  - #automation
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21
modified: 2025-11-29
author: jakubc
title: "🔮 Obsidian Setup"






owner: jakubc
---

# 🔮 Obsidian Setup

> **Konfiguracja Obsidian** dla repozytorium EWW

## 📁 Struktura

### Vault Location
```
/home/jakubc/git/eww/  # Cała repo jako vault
```

### Folder Tagów
```
Tags/                → symlink do dev/obsidian/tags/
docs/infra/tags/     → symlink kompatybilności → dev/obsidian/tags/
dev/obsidian/tags/   → faktyczna lokalizacja tag pages (trzymamy tutaj)
```

**Dlaczego symlink?**
- Obsidian tworzy `Tags/` w root vault
- Chcemy mieć clean root directory
- Tagi trzymamy w `dev/obsidian/tags/`
- Symlink pozwala Obsidian działać normalnie
- Make.md/Spaces: `spacesFolder=dev/obsidian/tags`, `spaceSubFolder=.space`

### Ignorowane Foldery

**W `.obsidian-ignore`:**
```
archive/
node_modules/
.git/
bin/
lib/
scripts/
tests/
site/
```

**W `.gitignore`:**
```
Tags              # Symlink - nie commitujemy
.obsidian/workspace*.json  # User-specific
.obsidian/plugins/  # Lokalnie instalowane
```


## ⚙️ Konfiguracja

### Core Plugins

**Włączone:**
- File explorer
- Search
- Quick switcher
- Graph view
- Backlinks
- Tag pane
- Page preview
- Templates
- Daily notes
- Bookmarks

**Wyłączone:**
- Slides
- Audio recorder
- Sync (używamy Git)

### Community Plugins

**Zainstalowane (w Git):**
```
.obsidian/plugins/
├── dataview/
├── templater-obsidian/
├── obsidian-git/
├── tag-wrangler/
└── ... (80 pluginów)
```

**Nie w Git (tylko lokalnie):**
- Workspace cache
- Temporary files

### Waypoint — foldery w grafie

> Plugin [Waypoint](https://github.com/IdreesInc/Waypoint) zamienia folder notes w węzły grafu/mind mapę (linkuje katalogi, dodaje dynamiczne MOC-e).

**Instalacja skryptem:**
```bash
# domyślna ścieżka vaulta = bieżący katalog
scripts/install-obsidian-waypoint.sh /home/jakubc/git/eww
```

Po skopiowaniu plików włącz plugin w Obsidianie: Settings → Community plugins → Waypoint. Folder notes zaczną pojawiać się jako osobne nody w Graph View i w mind mapach.


## 🏷️ System Tagów

### Lokalizacja
```
dev/obsidian/tags/     # Faktyczne pliki
docs/infra/tags/       # Symlink kompatybilności
Tags/                  # Symlink (dla Obsidian)
```

### Struktura tagów
```
dev/obsidian/tags/
├── #business/
│   ├── #business.md
│   ├── #finanse.md
│   └── #sprzedaż.md
├── #docs/
│   ├── #documentation.md
│   └── #markdown.md
└── #tools/
    └── #obsidian.md
```

### Jak działają

1. Obsidian tworzy `Tags/#tag-name` przy pierwszym użyciu
2. Symlink przekierowuje do `dev/obsidian/tags/`
3. Make.md (Spaces) patrzy na `dev/obsidian/tags/` (`spaceSubFolder=.space`)
4. Git commituje tylko `dev/obsidian/tags/`
5. Root zostaje czysty


## 🔄 Git Integration

### Plugin Obsidian Git

**Auto-commit:**
```yaml
# .obsidian/plugins/obsidian-git/data.json
{
  "autoCommitMessage": "vault backup: {{date}}",
  "commitDateFormat": "YYYY-MM-DD HH:mm:ss",
  "autoSaveInterval": 10,
  "autoPushInterval": 0,
  "pullUpdatesOnMobile": true
}
```

**Manual workflow:**
```bash
# W Obsidian: Ctrl+P
> Obsidian Git: Commit all changes
> Obsidian Git: Push

# Lub normalnie w terminalu
git add .
git commit -m "docs: update notes"
git push
```


## 📝 Templates

### Lokalizacja
```
core/TEMPLATES/obsidian/  # Obsidian templates
docs/templates/           # Markdown templates
```

### Konfiguracja
```json
// .obsidian/templates.json
{
  "folder": "core/TEMPLATES/obsidian"
}
```

### Użycie
```
Ctrl+P → Templates: Insert template
```


## 🎨 Theme & Appearance

### Theme
```
.obsidian/themes/
├── Fancy-a-Story/
└── Obsidian Nord/
```

**Aktywny:** Sprawdź w `.obsidian/appearance.json`

### CSS Snippets
```
.obsidian/snippets/
└── custom-styles.css
```


## 🔗 Metadata & Frontmatter

### Plugin: Frontmatter Tag Wrangler

**Auto-dodawanie tagów:**
- Z frontmatter → tag pane
- Z `tags:` YAML → Obsidian tags

### Standardowy Frontmatter
```yaml
title: "Tytuł"
category: documentation
  - tag1
  - tag2
created: YYYY-MM-DD
updated: YYYY-MM-DD
author: EWW Team
```


## 🚀 Best Practices

### Daily Workflow

1. **Start dnia:**
   - Otwórz Obsidian
   - Sprawdź recent files
   - Pull latest (Git plugin)

2. **Praca:**
   - Edytuj notatki
   - Używaj [[wikilinks]]
   - Taguj #propernie

3. **Koniec dnia:**
   - Commit changes (Obsidian Git)
   - Push do remote

### Folder Notes

**Plugin:** Folder Note
```
folder-name/
├── folder-name.md    # Folder note
├── file1.md
└── file2.md
```

### Backlinks

**Używaj wikilinks:**
```markdown
[[docs/AGENTS]]
[[business/INDEX|Business]]
[[#tag-name]]
```

**Graph view:**
- `Ctrl+G` - Toggle graph
- Filter: `path:docs/` lub `tag:#business`


## 🔧 Troubleshooting

### Tags folder w root

**Problem:** Obsidian tworzy `Tags/` w root

**Rozwiązanie:**
```bash
rm -rf Tags/
ln -s dev/obsidian/tags Tags
git add .gitignore  # Dodaj Tags do ignore
```

### Workspace nie synchronizuje

**Problem:** `.obsidian/workspace.json` konfliktuje

**Rozwiązanie:**
- Nie commituj workspace*.json
- Każdy ma swój lokalny workspace

### Pluginy nie działają

**Problem:** Plugins folder pusty

**Rozwiązanie:**
```bash
cd .obsidian/plugins
# Zainstaluj przez Obsidian: Settings → Community plugins
```


## 📚 Zasoby

- [Obsidian Docs](https://help.obsidian.md/)
- [Obsidian Forum](https://forum.obsidian.md/)
- [Dataview Plugin](https://blacksmithgu.github.io/obsidian-dataview/)


**Zaktualizowano:** 2025-11-21  
**Vault:** `/home/jakubc/git/eww`  
**Tags:** `dev/obsidian/tags/` (symlink: `Tags/`, legacy: `docs/infra/tags/`)

## 🔗 Backlinks

- [[docs/software/obsidian/obsidian]]
- [[docs/docs]]
- [[INDEX]]