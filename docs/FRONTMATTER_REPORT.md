---
title: Raport Frontmatter
description: Podsumowanie generowania rozszerzonego frontmatter YAML
type: report
category: docs
filepath: FRONTMATTER_REPORT.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: completed
priority: high
license: MIT
tags:
  - documentation
  - report
  - frontmatter
  - yaml
  - metadata
  - docs
  - knowledge
keywords:
  - frontmatter
  - metadata
  - yaml
  - automation
  - enhancement
project: eww
repository: https://github.com/Kari-Tori/eww-1
related:
  - docs/IMPROVEMENT-SUGGESTIONS.md
  - docs/MAKEFILE-GUIDE.md
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
---

# Raport Frontmatter - Rozszerzenie YAML

## Podsumowanie

Rozszerzono system generowania frontmatter YAML z **11 pól** do **20+ pól** z inteligentnymi funkcjami wydobywania metadanych.

## Statystyka

- **313 plików .md** z frontmatter YAML
- **59 plików .sh** z metadata (komentarze)
- **100% pokrycie** głównych katalogów (bin, lib, scripts, docs, core, dev, business)

## Nowe funkcje w eww-frontmatter.sh

### 1. `get_file_type()` - Określanie typu pliku
- **executable** - pliki w bin/ bez rozszerzenia
- **library** - lib/*.sh
- **script** - scripts/*.sh
- **readme** - README.md
- **guide** - docs/guide/
- **troubleshooting** - docs/*troubleshoot*
- **documentation** - pozostałe .md

### 2. `generate_keywords()` - Słowa kluczowe
- Z nazwy pliku (obsidian → vault, pkm, notes)
- Z zawartości markdown (\*\*keyword\*\*)
- Max 7 unikalnych

### 3. `find_dependencies()` - Zależności
- Sourced files: `source lib/log.sh`
- Required commands: `command -v git`
- Max 3 na kategorię

### 4. `get_priority()` - Priorytet
- **high** - README, init scripts
- **medium** - fix, clean, setup scripts
- **low** - test, example files
- **normal** - pozostałe

### 5. `generate_aliases()` - Alternatywne nazwy
- Usuwa prefiks eww-
- Zamienia - na _
- Dodaje warianty nazwowe

## Struktura rozszerzonego frontmatter

```yaml
---
title: Nazwa pliku
description: Automatyczny opis
type: executable|library|script|guide|readme|documentation
category: Automatycznie z ścieżki (bin, lib, scripts, docs)
filepath: Relatywna ścieżka od repo root
author: jakubc (fallback gdy git niedostępny)
owner: jakubc
created: YYYY-MM-DD (git lub stat)
updated: YYYY-MM-DD (git lub stat)
version: 1.0.0
language: pl
status: active
priority: high|medium|low|normal
license: MIT
tags:
  - tag1 (max 7)
  - tag2
keywords:
  - keyword1 (z zawartości)
  - keyword2
aliases:
  - alternative_name1
  - alternative_name2


related:
  - docs/IMPROVEMENT-SUGGESTIONS.md
  - docs/MAKEFILE-GUIDE.md
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
dependencies:
  - lib/log.sh (sourced files)
  - command:git (required commands)
sources:
  - filepath (self-reference)
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---
```

## Przykład markdown (docs/obsidian-troubleshooting.md)

```yaml
---
title: Obsidian Troubleshooting
description: Obsidian - Rozwiązywanie problemów
type: file
category: docs
filepath: docs/obsidian-troubleshooting.md
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - obsidian
  - pkm
keywords:
  - notes
  - obsidian
  - pkm
  - vault
aliases:
  - obsidian_troubleshooting


related:
  - docs/IMPROVEMENT-SUGGESTIONS.md
  - docs/MAKEFILE-GUIDE.md
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
dependencies:
sources:
  - docs/obsidian-troubleshooting.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---
```

## Przykład bash (lib/log.sh - nowe pliki)

```bash
#!/usr/bin/env bash
# File: lib/log.sh
# Author: jakubc
# Created: 2025-11-21
# Updated: 2025-11-21
# Description: bash
```

**Uwaga:** Pliki z istniejącymi komentarzami (# Tags:) są pomijane żeby nie duplikować metadanych.

## Korzyści

1. **Odkrywalność** - keywords i aliases ułatwiają wyszukiwanie
2. **Kontekst** - type, category, priority od razu pokazują czym jest plik
3. **Zależności** - dependencies mapuje relacje między skryptami
4. **Standardyzacja** - jednolity format dla całego repo
5. **Obsidian** - pełna kompatybilność z Obsidian PKM
6. **YAML valid** - sprawdzone przez python yaml.safe_load()

## Walidacja

```bash
python3 -c "import yaml; yaml.safe_load(open('docs/obsidian-troubleshooting.md').read().split('---\n', 2)[1]); print('✅ YAML valid')"
```

Wynik: **✅ YAML valid**

## Użycie

```bash
# Dry-run (test)
./scripts/eww-frontmatter.sh --dry-run docs/

# Aktualizacja katalogu
./scripts/eww-frontmatter.sh bin/

# Całe repo (ostrożnie!)
./scripts/eww-frontmatter.sh .
```

## Planowane ulepszenia

1. Wykrywanie zewnętrznych linków (HTTP/HTTPS URLs)
2. Ekstrakcja examples/usage z sekcji markdown
3. Lepsza obsługa dat z git (obecnie fallback na stat)
4. Migracja starych # Tags: do nowej struktury # File:
5. Dokumentacja API funkcji frontmatter

## Historia zmian

- **2025-11-21** - Wersja rozszerzona z 20+ polami
  - Dodano: type, category, priority, keywords, aliases, dependencies
  - Poprawiono: fallback dla author/created/updated
  - Naprawiono: YAML string quoting dla context
  - Walidacja: python yaml.safe_load()
  - Statystyka: 313 .md + 59 .sh plików zaktualizowanych

- **2025-11-20** - Wersja podstawowa z 11 polami
  - Pola: title, description, filepath, author, owner, created, updated, version, language, status, tags, related, sources, backlinks

