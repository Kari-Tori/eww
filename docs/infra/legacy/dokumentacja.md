created: 2025-11-09T16:56:23Z
modified: 2025-11-24T22:31:13Z
author: Nairecth
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "Jak dokumentować projekt E-Waste Workshop"






owner: jakubc
created: 2025-11-09T16:56:23Z
modified: 2025-11-24T22:31:13Z
author: Nairecth
---



# Jak dokumentować projekt E-Waste Workshop

## 📖 O tym dokumencie

Ten przewodnik opisuje jak prawidłowo dokumentować pliki Markdown w projekcie eww.

## YAML Frontmatter

Każdy plik Markdown powinien zawierać metadane YAML na początku:

```yaml
title: Tytuł dokumentu
description: Krótki opis zawartości
version: 0.0.0.4
type: readme|changelog|index|guide|wiki
category: documentation
  - tag1
  - tag2
language: pl
updated: YYYY-MM-DD
```

## Typy dokumentów

### 1. README.md - Główna dokumentacja

```yaml
title: E-Waste Workshop README
description: Kompletna dokumentacja projektu
version: 0.0.0.4
repository: https://github.com/Nairecth/eww
website: http://www.e-wasteworkshop.co.uk
type: readme
category: documentation
audience: developers
language: pl
platform: Kubuntu 24.04 LTS
requires:
  - bash >= 5.1
  - git
  - make
license: MIT
status: stable
```

**Zawartość:**
- Quick Start (instalacja jedną komendą)
- Demo (przykładowa sesja)
- Wymagania
- Instalacja
- Konfiguracja
- Użycie
- Struktura projektu
- Narzędzia deweloperskie
- Dokumentacja
- Contributing
- License

### 2. INDEX.md - Indeks projektu

```yaml
title: INDEX - E-Waste Workshop
description: Automatycznie generowany indeks projektu
version: 0.0.0.4
generator: ./dev/bin/eww-index
source: .filedesc
type: index
auto-generated: true
```

**Generowanie:**
```bash
./dev/bin/eww-index
make index
```

### 3. CHANGELOG.md - Historia zmian

```yaml
title: CHANGELOG - E-Waste Workshop
description: Historia zmian projektu
version: 0.0.0.4
format: Keep a Changelog
versioning: Semantic Versioning
type: changelog
generator: ./dev/bin/eww-changelog
```

**Format:** [Keep a Changelog](https://keepachangelog.com/pl/1.0.0/)

**Sekcje:**
- `[Unreleased]` - nadchodzące zmiany
- `[x.y.z]` - wydane wersje z datą
- `Added` - nowe funkcje
- `Changed` - zmiany w istniejących
- `Deprecated` - oznaczone do usunięcia
- `Removed` - usunięte
- `Fixed` - poprawki błędów
- `Security` - poprawki bezpieczeństwa

### 4. AGENTS.md - Kontekst AI

```yaml
title: AGENTS.md - Kontekst dla AI Coding Agents
description: Kompletny kontekst projektu dla AI
version: 0.0.0.4
audience: AI coding agents
type: ai-context
language: pl
```

**Zawartość:**
- Informacje o projekcie
- Architektura
- Stack technologiczny
- Wzorce i praktyki
- Workflow
- Zasady dla AI

### 5. MVP.md - Kryteria akceptacji

```yaml
title: MVP - Kryteria akceptacji
description: Definition of Done dla MVP 0.0.0.1
version: 0.0.0.1
type: specification
category: project-management
```

### 6. Dokumenty w docs/

#### docs/infra/guide/ - Przewodniki

```yaml
title: Nazwa przewodnika
description: Krótki opis
type: guide
category: documentation
difficulty: beginner|intermediate|advanced
estimated-time: 10 minutes
```

#### docs/infra/wiki/ - Wiki

```yaml
title: Tytuł artykułu wiki
description: Opis tematu
type: wiki
category: setup|configuration|troubleshooting
platform: Kubuntu 24.04|Neovim|Obsidian
```

## Komentarze HTML

Używaj komentarzy HTML do strukturyzacji dokumentu:

```html
<!-- 
  README.md - Główna dokumentacja projektu
  
  Struktura:
  1. Quick Start
  2. Demo
  3. Wymagania
  ...
  
  Aktualizacja: ./dev/scripts/check_readme.sh
-->
```

## Linki wewnętrzne

```markdown
[Zobacz INDEX](INDEX.md)
[Historia zmian](CHANGELOG.md)
[Kontekst AI](AGENTS.md)
```

## Badżki (shields.io)

```markdown
![build](https://img.shields.io/badge/build-passing-brightgreen)
![version](https://img.shields.io/badge/release-v0.0.0.4-blue)
![license](https://img.shields.io/badge/license-MIT-green)
![bash](https://img.shields.io/badge/bash-5.1+-blue)
![platform](https://img.shields.io/badge/platform-Kubuntu%2024.04-orange)
```

## Sekcje standardowe

### Quick Start

```markdown
## Quick Start

\`\`\`bash
# Instalacja jedną komendą
curl -fsSL https://raw.githubusercontent.com/... | bash
\`\`\`
```

### Użycie

```markdown
## Użycie

\`\`\`bash
# Podstawowe komendy
make help
make tree
make index
\`\`\`
```

### Contributing

```markdown
## Contributing

1. Fork projektu
2. Utwórz branch: `git checkout -b feat/nowa-funkcja`
3. Commituj: `git commit -m "feat: opis"`
4. Wyślij PR

### Konwencje
- Commity: Conventional Commits
- Kod: Po polsku (komentarze, zmienne opisowe)
- Testy: BATS
```

## System opisów plików (.filedesc)

Każdy plik projektu ma opis w `.filedesc`:

```
# Format: ścieżka|Krótki opis
README.md|Dokumentacja główna projektu E-Waste Workshop
lib/git.sh|Helpery Git (tagi, commity, sprawdzanie stanu)
dev/bin/eww-tree|Wyświetla drzewo katalogów z opisami plików
```

**Aktualizacja:**
```bash
# Edytuj .filedesc
vim .filedesc

# Regeneruj INDEX.md
make index
```

## Narzędzia

### Walidacja

```bash
# Sprawdź README.md
./dev/scripts/check_readme.sh

# Sprawdź linki
make readme-check
```

### Generowanie

```bash
# INDEX.md
make index

# CHANGELOG.md
make changelog-update

# Podgląd
make readme-preview
make index-preview
glow README.md
```

### Automatyzacja

```bash
# Aktualizuj wersję
make readme-update-version

# Pełny release
make release VERSION=0.0.0.5
```

## Przykład kompletnego dokumentu

```markdown
title: Przykładowy dokument
description: Opis tego co zawiera dokument
version: 0.0.0.4
type: guide
category: documentation
  - example
  - template
language: pl
updated: 2025-11-09

<!-- 
  Przykład dokumentu zgodnego ze standardem EWW
  Aktualizacja: make docs-update
-->

# Przykładowy dokument

> Krótkie wprowadzenie do dokumentu

## Spis treści

- [Sekcja 1](#sekcja-1)
- [Sekcja 2](#sekcja-2)

## Sekcja 1

Treść...

### Podsekcja

Więcej treści...

## Sekcja 2

\`\`\`bash
# Przykłady kodu
echo "Hello EWW"
\`\`\`

## Zobacz też

- [README.md](../README.md)
- [INDEX.md](../INDEX.md)


**Autor:** Nairecth  
**Ostatnia aktualizacja:** 2025-11-09
```

## Checklist dla nowego dokumentu

- [ ] Dodano YAML frontmatter
- [ ] Ustawiono tytuł i opis
- [ ] Określono typ i kategorię
- [ ] Dodano tagi
- [ ] Ustawiono datę created/updated
- [ ] Dodano do INDEX.md (jeśli potrzeba)
- [ ] Dodano do .filedesc
- [ ] Sprawdzono linki
- [ ] Przetestowano generowanie (glow, markdown preview)
- [ ] Commitowano z Conventional Commits

## Odnośniki

- [Keep a Changelog](https://keepachangelog.com/pl/1.0.0/)
- [Semantic Versioning](https://semver.org/lang/pl/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Markdown Guide](https://www.markdownguide.org/)
- [YAML Frontmatter](https://jekyllrb.com/docs/front-matter/)


**Wygenerowano:** 2025-11-09  
**Projekt:** E-Waste Workshop  
**Maintainer:** Nairecth
