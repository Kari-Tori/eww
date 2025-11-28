created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #eww
  - #system
  - #automation
  - #folder_note
title: "📁 System Folder Notes"
owner: jakubc
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# 📁 System Folder Notes

## Zasada

**KAŻDY folder zawiera folder_note w postaci: `folder_name/folder_name.md`**

Zawsze! Bez wyjątków.

## Format folder_note

```yaml
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #folder_note
  - #folder_name
folder_color: 65331
folder_stats:
  md_files: 41
  total_files: 50
  subdirs: 2
title: "Folder Name - Folder Note"
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# Folder Name

> Automatycznie wygenerowana notatka folderu

## 📊 Statystyki

- **Pliki Markdown**: 41
- **Wszystkie pliki**: 50
- **Podfoldery**: 2
- **Kolor**: RGB 65331

## 📝 Zawartość

<!-- Auto-generated content -->
```

## Struktura YAML

### folder_stats

Zawiera statystyki folderu (aktualizowane automatycznie):

```yaml
folder_stats:
  md_files: 41        # Liczba plików .md
  total_files: 50     # Wszystkie pliki
  subdirs: 2          # Liczba podfolderów
```

### folder_color

RGB integer dla Graph View:

```yaml
folder_color: 65331  # 🔵 Blue
```

## Kolory głównych folderów

| Folder | Color | RGB | Hex |
|--------|-------|-----|-----|
| core/ | 🔵 Blue | 65331 | #00FF33 |
| business/ | 🟤 Brown | 2664719 | #28AA0F |
| config/ | 🟢 Lime | 5526612 | #5436F4 |
| dev/ | ⚡ Cyan | 6737151 | #66CCFF |
| docs/ | 💚 Green | 1334271 | #145CFF |
| usr/ | 🔴 Red | 16711680 | #FF0000 |
| tools/ | 🔧 Yellow | 6287 | #00188F |
| scripts/ | 🟪 Purple | 10944256 | #A6E000 |
| default | ⚪ Gray | 8421504 | #808080 |

## Automatyzacja

### Utwórz folder_notes dla wszystkich folderów

```bash
make create-folder-notes
# lub
bash scripts/create-folder-notes.sh create
```

Tworzy `folder_name.md` w każdym folderze (jeśli nie istnieje).

### Aktualizuj folder_stats

```bash
make update-folder-stats
# lub
bash scripts/create-folder-notes.sh update
```

Aktualizuje statystyki we wszystkich istniejących folder_notes.

## Przykłady

### core/core.md

```yaml
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #folder_note
  - #core
folder_color: 65331
folder_stats:
  md_files: 41
  total_files: 41
  subdirs: 2
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# Core

> Folder zawiera 41 plików markdown
```

### docs/infra/software/obsidian/obsidian.md

```yaml
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #folder_note
  - #obsidian
folder_color: 1334271
folder_stats:
  md_files: 7
  total_files: 8
  subdirs: 10
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# Obsidian

> Dokumentacja Obsidian
```

## Integracja z Graph View

W `.obsidian/graph.json`:

```json
{
  "colorGroups": [
    {
      "query": "tag:#folder_note path:core/",
      "color": {"a": 1, "rgb": 65331}
    }
  ]
}
```

## Workflow

1. **Utwórz nowy folder**
   ```bash
   mkdir new_folder
   ```

2. **Wygeneruj folder_note**
   ```bash
   make create-folder-notes
   ```

3. **Edytuj zawartość**
   ```bash
   vim new_folder/new_folder.md
   ```

4. **Aktualizuj statystyki**
   ```bash
   make update-folder-stats
   ```

## Wykluczenia

Folder_notes NIE są tworzone dla:
- `.git/` i podfolderów
- `archive/` i podfolderów
- `.obsidian/cache/`
- `.obsidian/plugins/`
- `.obsidian/themes/`

## Maintenance

### Znajdź foldery bez folder_note

```bash
find . -type d -not -path "./.git/*" | while read dir; do
    folder=$(basename "$dir")
    [[ ! -f "$dir/$folder.md" ]] && echo "Missing: $dir"
done
```

### Sprawdź folder_notes z nieaktualnymi stats

```bash
make update-folder-stats
git diff --name-only
```

created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

**ZASADA**: Folder bez folder_note = niepełny folder!
