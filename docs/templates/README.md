---
tags:
  - #automation
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
  - #templates
created: 2025-11-21T11:00:00Z
modified: 2025-11-21T11:00:00Z
author: jakubc
title: "Szablon Frontmatter"






---




# Szablon Frontmatter

Standardowy frontmatter dla wszystkich plików MD w repozytorium.

## Użycie

```yaml
title: "Tytuł dokumentu"
description: "Krótki opis"
category: general
  - tag1
  - tag2
  - tag3
created: YYYY-MM-DD
updated: YYYY-MM-DD
author: Imię Nazwisko
source: "[[INDEX]]"
cssclasses:
  - eww-doc
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
