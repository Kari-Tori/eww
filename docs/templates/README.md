---
title: README
description: Szablon Frontmatter
type: readme
category: docs
filepath: docs/templates/README.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: high
license: MIT
tags:
  - documentation
  - markdown
  - readme
  - docs
  - knowledge
keywords:
aliases:
related:
  - CHANGELOG.md
  - README.md
  - archive/archive.md
dependencies:
sources:
  - docs/templates/README.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---




# Szablon Frontmatter

Standardowy frontmatter dla wszystkich plików MD w repozytorium.

## Użycie

```yaml
---
title: "Tytuł dokumentu"
description: "Krótki opis"
category: general
tags:
  - tag1
  - tag2
  - tag3
created: YYYY-MM-DD
updated: YYYY-MM-DD
author: Imię Nazwisko
source: "[[INDEX]]"
cssclasses:
  - eww-doc
---
```

## Pola

- **title** - tytuł dokumentu
- **description** - krótki opis (opcjonalne)
- **category** - general|development|business|documentation|personal|core
- **tags** - max 7 tagów
- **created** - data utworzenia (YYYY-MM-DD)
- **updated** - data ostatniej modyfikacji (YYYY-MM-DD)
- **author** - autor dokumentu
- **source** - link do źródła (domyślnie [[INDEX]])
- **cssclasses** - klasy CSS dla Obsidian

## Przykład użycia

```bash
cp docs/templates/frontmatter-template.md my-new-doc.md
# Edytuj pola frontmatter
```
