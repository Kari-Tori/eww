---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "YAML Frontmatter - README.md"






owner: jakubc
---



# YAML Frontmatter - README.md

## Analiza atrybutów dla README.md projektu eww

### Aktualna konfiguracja (wersja 0.0.0.5)

```yaml
title: E-Waste Workshop README
description: Kompletna dokumentacja projektu - instalacja, konfiguracja, użycie
version: 0.0.0.5
author: Nairecth
repository: https://github.com/Nairecth/eww
website: http://www.e-wasteworkshop.co.uk
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
  - git
  - make
created: 2024-11-08
updated: 2025-11-09
license: MIT
status: stable
```

## Szczegółowy opis atrybutów

### 1. Identyfikacja

#### `title`
- **Wartość:** `E-Waste Workshop README`
- **Cel:** Pełna nazwa dokumentu widoczna w przeglądarkach, search results
- **Format:** "Nazwa projektu + typ dokumentu"
- **SEO:** Używany jako `<title>` tag w HTML
- **Uwagi:** Krótki, opisowy, bez nadmiarowych słów

#### `description`
- **Wartość:** `Kompletna dokumentacja projektu - instalacja, konfiguracja, użycie`
- **Cel:** Meta description dla SEO i preview w search engines
- **Długość:** 67 znaków (optymalne: 50-160)
- **Format:** Lista głównych tematów oddzielona myślnikami
- **SEO Impact:** Wysoki - pojawia się w Google snippets
- **Uwagi:** Treściwy, bez kropki na końcu

#### `version`
- **Wartość:** `0.0.0.5`
- **Cel:** Synchronizacja z plikiem VERSION
- **Format:** Semantic Versioning (MAJOR.MINOR.PATCH.BUILD)
- **Aktualizacja:** Przy każdym wydaniu (make release)
- **Powiązane:** VERSION file, badges w README
- **Historia:**
  - 0.0.0.1 → 0.0.0.4 (dokumentacja podstawowa)
  - 0.0.0.5 (aktualna - dodano narzędzia dev, testy)

### 2. Projekt i autor

#### `author`
- **Wartość:** `Nairecth`
- **Cel:** Identyfikacja maintainera projektu
- **Format:** GitHub username
- **Użycie:** Attribution w footer, contact info
- **Powiązane:** GitHub profile, commits

#### `repository`
- **Wartość:** `https://github.com/Nairecth/eww`
- **Cel:** Link do źródła projektu
- **Format:** Pełny HTTPS URL
- **Użycie:** 
  - Link "View on GitHub"
  - Clone instructions
  - Issue tracker
- **Wymagania:** Publiczne repo lub z odpowiednimi uprawnieniami

#### `website`
- **Wartość:** `http://www.e-wasteworkshop.co.uk`
- **Cel:** Oficjalna strona projektu E-Waste Workshop
- **Format:** HTTP URL (nie HTTPS - legacy)
- **Użycie:** External link, project home
- **Uwagi:** Strona projektu fizycznego, nie dokumentacji

#### `license`
- **Wartość:** `MIT`
- **Cel:** Określenie licencji projektu
- **Format:** SPDX short identifier
- **Użycie:** Legal info, badge, LICENSE file
- **Implikacje:** Open source, permissive license
- **Status:** TBD w sekcji License → do ustalenia końcowej licencji

### 3. Klasyfikacja techniczna

#### `category`
- **Wartość:** `documentation`
- **Cel:** Klasyfikacja typu zawartości
- **Alternatywy:** development, tutorial, reference
- **Użycie:** Filtrowanie, organizacja docs/
- **Uwagi:** Główny dokument = zawsze "documentation"

#### `type`
- **Wartość:** `readme`
- **Cel:** Precyzyjne określenie typu dokumentu
- **Możliwe wartości:** readme, guide, wiki, changelog, index
- **Użycie:** 
  - Routing w dokumentacji
  - Template selection
  - Icon display
- **Konwencja:** README.md = type:readme (zawsze)

#### `audience`
- **Wartość:** `developers`
- **Cel:** Określenie grupy docelowej
- **Alternatywy:** users, administrators, contributors
- **Użycie:** Content filtering, UX decisions
- **Implikacje:** Założenie znajomości terminalu, Git, Bash

#### `language`
- **Wartość:** `pl`
- **Cel:** Język dokumentu (polski)
- **Format:** ISO 639-1 (dwuliterowy kod)
- **Użycie:**
  - Spell checking (VS Code, Grammarly)
  - Translation hints
  - Locale selection
- **Uwagi:** Projekt po polsku (kod, komentarze, docs)

### 4. Wymagania techniczne

#### `platform`
- **Wartość:** `Kubuntu 24.04 LTS`
- **Cel:** Docelowa platforma systemowa
- **Format:** "OS + wersja + edition"
- **Kompatybilność:** Ubuntu/Debian derivatives
- **Użycie:** System requirements, installation guide
- **Testy:** Projekt testowany na Kubuntu 24.04

#### `requires`
- **Wartość:** (lista)
  ```yaml
  - bash >= 5.1
  - git
  - make
  ```
- **Cel:** Minimalne wymagania do uruchomienia
- **Format:** `package >= version` lub `package`
- **Użycie:** 
  - Prerequisites section
  - Dependency checking (eww-doctor)
  - Installation validation
- **Pełna lista w README:** BATS, ShellCheck, gh (opcjonalne)

### 5. Organizacja i tagowanie

#### `tags`
- **Wartość:** (lista)
  ```yaml
  - bash
  - kubuntu
  - automation
  - devtools
  - documentation
  ```
- **Cel:** SEO, wyszukiwanie, kategoryzacja
- **Format:** Małe litery, kebab-case
- **Użycie:**
  - Search keywords
  - GitHub topics
  - Related content discovery
- **Strategia:** 3-7 tagów, najpierw technologie (bash), potem funkcje (automation)

### 6. Daty i wersjonowanie

#### `created`
- **Wartość:** `2024-11-08`
- **Cel:** Data utworzenia projektu/dokumentu
- **Format:** ISO 8601 (YYYY-MM-DD)
- **Historia:** Początek projektu eww
- **Użycie:** Sorting, archiving
- **Niezmienne:** Data się nie zmienia (tylko updated)

#### `updated`
- **Wartość:** `2025-11-09`
- **Cel:** Data ostatniej znaczącej aktualizacji
- **Format:** ISO 8601 (YYYY-MM-DD)
- **Aktualizacja:** Przy każdej większej zmianie (nowa sekcja, fix błędów)
- **Użycie:** Freshness indicator dla czytelników
- **Uwagi:** Dzisiaj! (2025-11-09 - aktualizacja narzędzi, testy Neovim)

### 7. Status

#### `status`
- **Wartość:** `stable`
- **Cel:** Określenie gotowości dokumentu
- **Możliwe wartości:**
  - `draft` - w trakcie pisania
  - `review` - w recenzji
  - `stable` - gotowy, przetestowany ✅
  - `deprecated` - przestarzały
  - `archived` - zarchiwizowany
- **Implikacje:** README stable = projekt gotowy do użycia
- **Walidacja:** 5/5 testów BATS przeszło

## Powiązania z innymi plikami

### Synchronizacja wersji

```bash
# VERSION file
0.0.0.5

# README.md frontmatter
version: 0.0.0.5

# README.md badge
![release](https://img.shields.io/badge/release-v0.0.0.5-blue)

# README.md text
**Wersja: 0.0.0.5** | **Ostatni commit:** `ebe70c9`
```

**Proces aktualizacji:**
```bash
# 1. Zmień VERSION
echo "0.0.0.6" > VERSION

# 2. Zaktualizuj README frontmatter
version: 0.0.0.6

# 3. Zaktualizuj badge
![release](https://img.shields.io/badge/release-v0.0.0.6-blue)

# 4. Zaktualizuj tekst
**Wersja: 0.0.0.6** | ...

# 5. Zaktualizuj datę
updated: 2025-11-09  # dzisiejsza data
```

### Spójność z CHANGELOG.md

```yaml
# CHANGELOG.md używa podobnych atrybutów
title: CHANGELOG
version: 0.0.0.5  # Synchronizowane z README
format: Keep a Changelog 1.0.0
versioning: Semantic Versioning 2.0.0
```

### Walidacja z AGENTS.md

```yaml
# AGENTS.md ma tę samą wersję
version: 0.0.0.4  # ❌ Niezsynchronizowane! (powinno być 0.0.0.5)
```

## Użycie atrybutów w praktyce

### 1. Automatyzacja (eww-frontmatter)

```bash
# Sprawdź zgodność
eww-frontmatter --validate README.md

# Aktualizuj datę automatycznie
eww-frontmatter --update-date README.md

# Sprawdź spójność wersji
grep "version:" README.md VERSION CHANGELOG.md AGENTS.md
```

### 2. Generowanie metadanych HTML

```bash
# Pandoc używa frontmatter do generowania HTML
pandoc README.md -o README.html --metadata title="E-Waste Workshop"

# Meta tags w HTML:
<title>E-Waste Workshop README</title>
<meta name="description" content="Kompletna dokumentacja projektu...">
<meta name="author" content="Nairecth">
<meta name="keywords" content="bash, kubuntu, automation, devtools">
```

### 3. MkDocs integration

```yaml
# mkdocs.yml może czytać frontmatter
site_name: E-Waste Workshop
site_url: http://www.e-wasteworkshop.co.uk
repo_url: https://github.com/Nairecth/eww
```

### 4. GitHub API

```bash
# Topics (z tags)
gh repo edit Nairecth/eww --add-topic bash
gh repo edit Nairecth/eww --add-topic kubuntu
gh repo edit Nairecth/eww --add-topic automation
```

## Checklist aktualizacji README.md

### Przy każdym release:

- [ ] Zaktualizuj `version:` (zgodnie z VERSION file)
- [ ] Zaktualizuj `updated:` (dzisiejsza data ISO 8601)
- [ ] Sprawdź badge wersji w treści
- [ ] Sprawdź **Wersja:** w tekście
- [ ] Zsynchronizuj z CHANGELOG.md
- [ ] Zsynchronizuj z AGENTS.md

### Przy większych zmianach:

- [ ] Zaktualizuj `description:` jeśli zmienił się zakres
- [ ] Dodaj nowe tagi w `tags:` jeśli nowe technologie
- [ ] Zaktualizuj `requires:` jeśli nowe zależności
- [ ] Zaktualizuj `platform:` jeśli zmiana OS
- [ ] Zmień `status:` jeśli draft→stable lub stable→deprecated

### Walidacja:

```bash
# 1. YAML syntax
yamllint README.md

# 2. Markdown lint
markdownlint README.md

# 3. Spójność wersji
diff <(grep "version:" README.md | cut -d: -f2) VERSION

# 4. Kompletność frontmatter
eww-frontmatter --validate README.md
```

## Statystyki

- **Liczba atrybutów:** 15
- **Wymagane:** 8 (title, description, type, category, created, updated, author, status)
- **Opcjonalne:** 7 (version, repository, website, tags, audience, language, platform, requires, license)
- **Unikalnych wartości w tags:** 5
- **Wersja dokumentu:** 0.0.0.5
- **Wiek dokumentu:** 1 rok (2024-11-08 → 2025-11-09)
- **Ostatnia aktualizacja:** Dzisiaj (2025-11-09)


**Dokument:** README.md YAML Frontmatter Analysis  
**Autor:** Nairecth  
**Data:** 2025-11-09  
**Wersja projektu:** 0.0.0.5
