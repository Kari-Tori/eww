created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: YAML Frontmatter - specyfikacja atrybutów
description: Kompletna dokumentacja wszystkich atrybutów YAML frontmatter używanych w projekcie eww
version: 1.0.0
type: specification
category: documentation
audience: developers
language: pl
tags:
  - yaml
  - frontmatter
  - metadata
  - specification
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---

# YAML Frontmatter - specyfikacja atrybutów

## O dokumencie

Ten dokument definiuje wszystkie atrybuty YAML frontmatter używane w projekcie E-Waste Workshop. Frontmatter to metadane w formacie YAML umieszczone na początku plików Markdown między znacznikami `---`.

## Format podstawowy

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: Tytuł dokumentu
description: Krótki opis (1-2 zdania)
version: 1.0.0
type: readme
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

## Kategorie atrybutów

### 1. Identyfikacja dokumentu

#### `title` (wymagany)
- **Typ:** string
- **Opis:** Pełny tytuł dokumentu
- **Format:** Krótki, opisowy, bez skrótów
- **Przykład:** `E-Waste Workshop README`
- **Użycie:** Nagłówek strony, meta tags, search results

#### `description` (wymagany)
- **Typ:** string
- **Opis:** Zwięzły opis zawartości dokumentu
- **Format:** 1-3 zdania, bez kropki na końcu (jeśli jedno zdanie)
- **Długość:** 50-160 znaków (optymalne dla SEO)
- **Przykład:** `Kompletna dokumentacja projektu - instalacja, konfiguracja, użycie`
- **Użycie:** Meta description, search snippets, TOC

#### `version` (opcjonalny)
- **Typ:** string (Semantic Versioning)
- **Opis:** Wersja dokumentu
- **Format:** `MAJOR.MINOR.PATCH` lub `MAJOR.MINOR.PATCH.BUILD`
- **Przykład:** `0.0.0.5`, `1.0.0`
- **Użycie:** Śledzenie zmian w dokumentacji
- **Wartości:**
  - MAJOR - breaking changes (struktura, format)
  - MINOR - nowa sekcja, znaczące zmiany
  - PATCH - poprawki, drobne aktualizacje
  - BUILD - automatyczne buildy (opcjonalnie)

### 2. Klasyfikacja

#### `type` (wymagany)
- **Typ:** string (enum)
- **Opis:** Typ dokumentu
- **Dozwolone wartości:**
  - `readme` - główna dokumentacja projektu/modułu
  - `index` - indeks/spis treści
  - `changelog` - historia zmian
  - `guide` - przewodnik/tutorial
  - `wiki` - artykuł wiki/knowledge base
  - `ai-context` - kontekst dla AI agents
  - `specification` - specyfikacja techniczna
  - `document` - ogólny dokument
  - `api` - dokumentacja API
  - `reference` - dokumentacja referencyjna
- **Przykład:** `readme`
- **Użycie:** Routing, templates, icons

#### `category` (wymagany)
- **Typ:** string (enum)
- **Opis:** Kategoria tematyczna
- **Dozwolone wartości:**
  - `documentation` - dokumentacja ogólna
  - `development` - dla deweloperów
  - `user-guide` - dla użytkowników
  - `api` - dokumentacja API
  - `tutorial` - tutoriale
  - `reference` - materiały referencyjne
  - `specification` - specyfikacje
  - `architecture` - architektura systemu
- **Przykład:** `documentation`
- **Użycie:** Filtrowanie, nawigacja, search facets

#### `audience` (opcjonalny)
- **Typ:** string lub array
- **Opis:** Docelowa grupa odbiorców
- **Dozwolone wartości:**
  - `developers` - programiści
  - `users` - użytkownicy końcowi
  - `administrators` - administratorzy
  - `contributors` - kontrybutorzy
  - `ai` - AI coding agents
  - `public` - publiczne
- **Przykład:** `developers`
- **Użycie:** Content filtering, access control

### 3. Metadane autorskie

#### `author` (wymagany)
- **Typ:** string
- **Opis:** Autor dokumentu
- **Format:** Username, imię i nazwisko, lub email
- **Przykład:** `Nairecth`, `Jan Kowalski <jan@example.com>`
- **Użycie:** Attribution, contact info

#### `contributors` (opcjonalny)
- **Typ:** array of strings
- **Opis:** Lista współautorów
- **Format:** Jak author
- **Przykład:**
  ```yaml
  contributors:
    - Alice Smith
    - Bob Jones
  ```
- **Użycie:** Credits, attribution

### 4. Daty

#### `created` (wymagany)
- **Typ:** date (ISO 8601)
- **Opis:** Data utworzenia dokumentu
- **Format:** `YYYY-MM-DD` lub `YYYY-MM-DD HH:MM:SS`
- **Przykład:** `2024-11-08`, `2024-11-08 14:30:00`
- **Użycie:** Sorting, archiving, history

#### `updated` (wymagany)
- **Typ:** date (ISO 8601)
- **Opis:** Data ostatniej aktualizacji
- **Format:** Jak created
- **Przykład:** `2025-11-09`
- **Użycie:** Freshness indicator, sorting
- **Uwaga:** Aktualizuj przy każdej znaczącej zmianie

#### `published` (opcjonalny)
- **Typ:** date (ISO 8601)
- **Opis:** Data publikacji (dla blogów, release notes)
- **Format:** Jak created
- **Przykład:** `2025-01-15`

#### `expires` (opcjonalny)
- **Typ:** date (ISO 8601)
- **Opis:** Data wygaśnięcia (dla tymczasowych dokumentów)
- **Format:** Jak created
- **Przykład:** `2026-12-31`

### 5. Projekt i repozytoria

#### `repository` (opcjonalny)
- **Typ:** URL
- **Opis:** Link do repozytorium GitHub
- **Format:** Pełny URL HTTPS
- **Przykład:** `https://github.com/Nairecth/eww`
- **Użycie:** Source link, contributing link

#### `website` (opcjonalny)
- **Typ:** URL
- **Opis:** Link do strony projektu
- **Format:** Pełny URL HTTPS/HTTP
- **Przykład:** `http://www.e-wasteworkshop.co.uk`
- **Użycie:** External link, project home

#### `license` (opcjonalny)
- **Typ:** string (SPDX identifier)
- **Opis:** Licencja dokumentu/projektu
- **Format:** SPDX short identifier
- **Dozwolone wartości:**
  - `MIT`
  - `Apache-2.0`
  - `GPL-3.0`
  - `BSD-3-Clause`
  - `CC-BY-4.0`
  - `CC-BY-SA-4.0`
  - `Proprietary`
- **Przykład:** `MIT`
- **Użycie:** Legal, licensing

### 6. Techniczne

#### `language` (opcjonalny)
- **Typ:** string (ISO 639-1)
- **Opis:** Język dokumentu
- **Format:** Dwuliterowy kod języka
- **Dozwolone wartości:**
  - `pl` - polski
  - `en` - angielski
  - `de` - niemiecki
  - itp.
- **Przykład:** `pl`
- **Użycie:** Localization, spell check, translation

#### `platform` (opcjonalny)
- **Typ:** string lub array
- **Opis:** Platforma systemowa
- **Format:** OS + wersja
- **Przykład:** `Kubuntu 24.04 LTS`, `Windows 11`
- **Użycie:** Compatibility info, system requirements

#### `requires` (opcjonalny)
- **Typ:** array of strings
- **Opis:** Wymagane zależności
- **Format:** `package >= version`
- **Przykład:**
  ```yaml
  requires:
    - bash >= 5.1
    - git >= 2.34
    - make >= 4.3
  ```
- **Użycie:** Dependency checking, installation

#### `status` (opcjonalny)
- **Typ:** string (enum)
- **Opis:** Status dokumentu
- **Dozwolone wartości:**
  - `draft` - w trakcie pisania
  - `review` - w recenzji
  - `stable` - stabilny, gotowy
  - `deprecated` - przestarzały
  - `archived` - zarchiwizowany
- **Przykład:** `stable`
- **Użycie:** Workflow, visibility, warnings

### 7. Organizacja treści

#### `tags` (opcjonalny)
- **Typ:** array of strings
- **Opis:** Lista tagów/słów kluczowych
- **Format:** Małe litery, kebab-case, bez spacji
- **Przykład:**
  ```yaml
  tags:
    - bash
    - kubuntu
    - automation
    - devtools
  ```
- **Użycie:** Search, filtering, related content

#### `related` (opcjonalny)
- **Typ:** array of strings
- **Opis:** Powiązane dokumenty (ścieżki względne)
- **Format:** Ścieżka do pliku .md
- **Przykład:**
  ```yaml
  related:
    - docs/guide/intro.md
    - docs/wiki/kubuntu.md
  ```
- **Użycie:** Navigation, "See also" links

#### `parent` (opcjonalny)
- **Typ:** string
- **Opis:** Dokument nadrzędny (dla hierarchii)
- **Format:** Ścieżka względna
- **Przykład:** `docs/README.md`
- **Użycie:** Breadcrumbs, navigation tree

#### `order` (opcjonalny)
- **Typ:** integer
- **Opis:** Kolejność sortowania
- **Format:** Liczba całkowita (0, 1, 2, ...)
- **Przykład:** `1`
- **Użycie:** Menu ordering, TOC ordering

### 8. Specjalne (dla narzędzi)

#### `generator` (auto)
- **Typ:** string
- **Opis:** Narzędzie które wygenerowało dokument
- **Format:** nazwa narzędzia + wersja
- **Przykład:** `eww-index v0.0.0.5`
- **Użycie:** Tracking, debugging
- **Uwaga:** Dodawane automatycznie przez narzędzia

#### `auto-generated` (auto)
- **Typ:** boolean
- **Opis:** Czy dokument jest auto-generowany
- **Format:** `true` lub `false`
- **Przykład:** `true`
- **Użycie:** Warnings ("Don't edit manually")

#### `source` (auto)
- **Typ:** string
- **Opis:** Źródło danych dla auto-generowanych dokumentów
- **Format:** Ścieżka do pliku źródłowego
- **Przykład:** `.filedesc`
- **Użycie:** Regeneration, source tracking

## Przykłady pełnych frontmatterów

### README.md (główny)

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: E-Waste Workshop README
description: Kompletna dokumentacja projektu - instalacja, konfiguracja, użycie
version: 0.0.0.5
repository: https://github.com/Nairecth/eww
website: http://www.e-wasteworkshop.co.uk
tags:
  - bash
  - kubuntu
  - automation
  - devtools
  - documentation
category: documentation
type: readme
audience: developers
language: pl
platform: Kubuntu 24.04 LTS
requires:
  - bash >= 5.1
  - git >= 2.34
  - make >= 4.3
updated: 2025-11-09
license: MIT
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

### CHANGELOG.md

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: CHANGELOG
description: Historia zmian projektu E-Waste Workshop
version: 0.0.0.5
format: Keep a Changelog 1.0.0
versioning: Semantic Versioning 2.0.0
type: changelog
category: documentation
audience: developers
language: pl
generator: eww-changelog v0.0.0.5
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

### AGENTS.md (AI context)

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: AGENTS.md - Kontekst dla AI Coding Agents
description: Kompletny kontekst projektu dla AI - architektura, workflow, konwencje
version: 0.0.0.4
type: ai-context
category: documentation
audience: ai
language: pl
tags:
  - ai
  - context
  - architecture
  - workflow
  - conventions
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

### docs/guide/intro.md (przewodnik)

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: Wprowadzenie do eww
description: Przewodnik dla początkujących - pierwsze kroki z E-Waste Workshop
version: 1.0.0
type: guide
category: tutorial
audience: users
language: pl
parent: docs/README.md
order: 1
tags:
  - tutorial
  - getting-started
  - introduction
related:
  - docs/wiki/kubuntu.md
  - README.md
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

### INDEX.md (auto-generated)

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: INDEX - Kompletny indeks projektu
description: Auto-generowany indeks wszystkich plików i katalogów projektu eww
version: 0.0.0.5
type: index
category: documentation
audience: developers
language: pl
generator: eww-index v0.0.0.5
source: .filedesc
auto-generated: true
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

### docs/wiki/kubuntu.md (wiki article)

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: Kubuntu 24.04 LTS - Konfiguracja
description: Przewodnik konfiguracji Kubuntu 24.04 LTS dla deweloperów
version: 1.0.0
type: wiki
category: reference
audience:
  - developers
  - administrators
language: pl
platform: Kubuntu 24.04 LTS
tags:
  - kubuntu
  - linux
  - configuration
  - setup
parent: docs/wiki/index.md
order: 1
updated: 2025-11-09
status: stable
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

## Walidacja

### Narzędzie: eww-frontmatter

Automatyczna walidacja i dodawanie frontmatter:

```bash
# Dodaj frontmatter z auto-detekcją typu
eww-frontmatter --auto README.md

# Waliduj istniejący frontmatter
eww-frontmatter --validate docs/guide.md

# Dry-run (pokaż bez zapisywania)
eww-frontmatter --dry-run --auto docs/wiki/intro.md
```

### Schema validation (yamllint)

Konfiguracja w `.yamllint.yaml`:

```yaml
rules:
  document-start: false  # Frontmatter nie wymaga ---
  line-length: 120
  indentation: 2
```

## Konwencje

### Nazewnictwo

- **Atrybuty:** camelCase lub kebab-case (konsekwentnie)
- **Wartości string:** Pierwsza wielka, reszta małe
- **Tags:** Małe litery, kebab-case
- **Daty:** ISO 8601 (YYYY-MM-DD)

### Kolejność atrybutów

Zalecana kolejność (dla czytelności):

1. title
2. description
3. version
4. type, category, audience
5. language, platform, requires
6. tags
7. created, updated, published
8. author, contributors
9. repository, website, license
10. status
11. generator, source, auto-generated (jeśli auto)

### Minimalna konfiguracja

Wymagane minimum dla każdego dokumentu:

```yaml
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
title: Tytuł dokumentu
description: Opis dokumentu
type: readme
category: documentation
updated: 2025-11-09
created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---
```

## Narzędzia wspierające

### VS Code Extensions

- **YAML** (redhat.vscode-yaml) - schema validation
- **Frontmatter** - GUI editor dla frontmatter

### CLI Tools

- **yamllint** - YAML linting
- **eww-frontmatter** - automatyzacja frontmatter
- **pandoc** - eksport z metadanymi

## Standardy zewnętrzne

- **YAML 1.2:** https://yaml.org/spec/1.2/spec.html
- **Semantic Versioning:** https://semver.org/
- **ISO 8601 (daty):** https://en.wikipedia.org/wiki/ISO_8601
- **SPDX (licencje):** https://spdx.org/licenses/
- **ISO 639-1 (języki):** https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

created: 2025-11-10T15:44:41Z
modified: 2025-11-10T15:44:41Z
author: Nairecth
---

**Autor:** Nairecth  
**Wersja:** 1.0.0  
**Data:** 2025-11-09  
**Status:** Stable
