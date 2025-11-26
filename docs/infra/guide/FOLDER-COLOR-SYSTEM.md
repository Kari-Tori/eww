---
tags:
  - #automation
  - #graph
  - #eww
  - #system
created: 2025-11-23T01:17:00Z
modified: 2025-11-23T01:17:00Z
author: jakubc
title: "🎨 System folder_color dla Graph View"
owner: jakubc
---

# 🎨 System folder_color dla Graph View

## Zasada

Każdy **folder_note** (README.md lub nazwa_folderu.md) ma w YAML:
1. `folder_color` - RGB integer dla Graph View
2. `file_count` - liczba plików .md w folderze
3. `tags` zawierający `#folder_note`

## Top 20 folderów z kolorami

| Folder | Pliki | folder_color | Hex | Emoji |
|--------|-------|--------------|-----|-------|
| `docs/infra/software/obsidian/resources/hub/02` | 2814 | 10485760 | #A020F0 | 🟪 Purple |
| `docs/infra/software/obsidian/resources/hub/01` | 2557 | 10485760 | #A020F0 | 🟪 Purple |
| `docs/infra/software/obsidian/resources/hub/02` | 455 | 10485760 | #A020F0 | 🟪 Purple |
| `docs` | 54 | 1334271 | #145CFF | 💚 Green |
| `usr/jakubc/star_wars` | 30 | 16711680 | #FF0000 | 🔴 Red |
| `usr/jakubc` | 15 | 16711680 | #FF0000 | 🔴 Red |
| `docs/infra` | 17 | 1334271 | #145CFF | 💚 Green |
| `core` | 41 | 65331 | #00FF33 | 🔵 Blue |
| `business` | 1 | 2664719 | #28AA0F | 🟤 Brown |
| `config` | 6 | 5526612 | #5436F4 | 🟢 Lime |
| `dev` | 34 | 6737151 | #66CCFF | ⚡ Cyan |

## Paleta kolorów

```yaml
folder_color_palette:
  obsidian_docs: 10485760  # 🟪 Purple #A020F0
  docs:          1334271   # 💚 Green  #145CFF
  jakubc:        16711680  # 🔴 Red    #FF0000
  karinam:       16711935  # 🟣 Pink   #FF00FF
  core:          65331     # 🔵 Blue   #00FF33
  business:      2664719   # 🟤 Brown  #28AA0F
  config:        5526612   # 🟢 Lime   #5436F4
  dev:           6737151   # ⚡ Cyan   #66CCFF
  tools:         6287      # 🔧 Yellow #00188F
  default:       8421504   # ⚪ Gray   #808080
```

## Format YAML folder_note

```yaml
---
tags:
  - #folder_note
  - #category
folder_color: 65331
file_count: 41
created: 2025-11-23T01:00:00Z
modified: 2025-11-23T01:00:00Z
author: jakubc
title: "Core - System plików podstawowych"
---

# Core

Folder zawiera **41 plików** podstawowej konfiguracji systemu.

## Zawartość
- house/ - konfiguracja domu
- tmp/ - pliki tymczasowe
```

## Integracja z Graph View

W `.obsidian/graph.json`:

```json
{
  "colorGroups": [
    {
      "query": "tag:#folder_note path:core/",
      "color": {"a": 1, "rgb": 65331}
    },
    {
      "query": "tag:#folder_note path:docs/",
      "color": {"a": 1, "rgb": 1334271}
    },
    {
      "query": "tag:#folder_note path:usr/jakubc/",
      "color": {"a": 1, "rgb": 16711680}
    }
  ]
}
```

## Skrypt generowania

```bash
#!/usr/bin/env bash
# Generuj folder_note z file_count i folder_color

folder="$1"
color="${2:-8421504}"  # Default gray

count=$(find "$folder" -name "*.md" | wc -l)

cat > "$folder/$(basename "$folder").md" << YAML
---
tags:
  - #folder_note
folder_color: $color
file_count: $count
created: $(date -Iseconds)
author: jakubc
---

# $(basename "$folder")

Folder zawiera **$count plików** markdown.
YAML
```

## Maintenance

### Update file_count dla wszystkich folder_notes:

```bash
find . -name "*.md" -exec grep -l "#folder_note" {} \; | while read note; do
    folder=$(dirname "$note")
    count=$(find "$folder" -name "*.md" | wc -l)
    sed -i "s/^file_count: .*/file_count: $count/" "$note"
done
```

## Graph Query dla TOP 20

Show tylko TOP 20 folderów w grafie:

```
path:docs/infra/software/obsidian/resources/hub/ OR 
path:docs/ OR 
path:usr/jakubc/ OR 
path:core/ OR 
path:config/ OR 
path:dev/
```

---

**Status**: 🎨 System kolorów zdefiniowany  
**Top folders**: 20 (7034 pliki w docs/infra/software/obsidian/)  
**Color groups**: 9 głównych kategorii
