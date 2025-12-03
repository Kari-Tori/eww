---
title: "Wersjonowanie z semver CLI - Wyjaśnienie rozwiązania"
version: 0.0.1
created: 2025-12-03
modified: 2025-12-03
tags:
  - documentation
  - versioning
  - semver
  - automation
status: active
owner: karinam
---

# Wersjonowanie z semver CLI - Wyjaśnienie rozwiązania

## 🎯 Dlaczego semver + własne skrypty?

Połączenie narzędzia `semver` CLI z własnymi skryptami Bash/Python daje najlepsze z obu światów:

### Zalety `semver` CLI
- **Walidacja:** automatyczne sprawdzanie poprawności formatu wersji (X.Y.Z)
- **Inkrementacja:** bezpieczne podbijanie wersji (`semver -i major|minor|patch`)
- **Porównywanie:** sprawdzanie relacji między wersjami (`semver 1.2.3 -r '>1.0.0'`)
- **Standard branżowy:** używane przez npm i inne narzędzia ekosystemu Node.js
- **Zero kodu:** gotowe rozwiązanie bez własnej implementacji parsowania SemVer

### Zalety własnych skryptów
- **Synchronizacja frontmatterów:** `semver` nie wie nic o plikach Markdown
- **Integracja z repo:** dostosowanie do struktury EWW (VERSION, tagi Git, Obsidian)
- **Automatyzacja workflow:** jeden skrypt do pełnego bumpu (VERSION + frontmattery + tag)
- **Raportowanie:** generowanie raportów braków wersji w plikach .md
- **Customizacja:** możliwość rozbudowy o dodatkowe funkcje (np. changelog, backup)

## 🔧 Jak to działa?

### 1. Instalacja semver
```bash
npm install -g semver
```

### 2. Struktura rozwiązania

```
eww/
├── VERSION                           # Główny numer wersji projektu
├── Makefile                          # Targety: bump-version, sync-versions, version-report
└── dev/scripts/
    ├── sync-versions.sh              # Główny skrypt (używa semver)
    └── check-version-consistency.sh  # Walidacja spójności VERSION ↔ tag ↔ frontmattery
```

### 3. Workflow bumpu wersji

```bash
# 1. Podbij wersję (np. patch: 0.0.1 → 0.0.2)
make bump-version BUMP=patch

# Co się dzieje pod spodem:
# - sync-versions.sh wywołuje: semver -i patch 0.0.1  →  0.0.2
# - Zapisuje nową wersję do VERSION
# - Aktualizuje pole version: w frontmatterach wszystkich plików .md
# - Opcjonalnie tworzy tag Git v0.0.2
```

### 4. Użycie semver w skryptach

```bash
#!/usr/bin/env bash

# Pobierz aktualną wersję
CURRENT=$(cat VERSION)

# Waliduj format
if ! semver "$CURRENT" > /dev/null 2>&1; then
    echo "Błąd: nieprawidłowy format wersji"
    exit 1
fi

# Podbij wersję
NEW_VERSION=$(semver -i patch "$CURRENT")
echo "$NEW_VERSION" > VERSION

# Porównaj wersje
if semver "$NEW_VERSION" -r ">$CURRENT"; then
    echo "Nowa wersja $NEW_VERSION > $CURRENT"
fi
```

## 📋 Dostępne komendy

### Makefile
```bash
make version              # Wyświetl aktualną wersję
make bump-version BUMP=patch   # Podbij patch (0.0.1 → 0.0.2)
make bump-version BUMP=minor   # Podbij minor (0.0.1 → 0.1.0)
make bump-version BUMP=major   # Podbij major (0.0.1 → 1.0.0)
make sync-versions        # Zsynchronizuj frontmattery z VERSION
make version-report       # Wygeneruj raport braków wersji
make check-versions       # Sprawdź spójność VERSION ↔ tag ↔ frontmattery
```

### Bezpośrednie wywołanie skryptu
```bash
dev/scripts/sync-versions.sh bump patch    # Podbij wersję
dev/scripts/sync-versions.sh sync          # Synchronizuj frontmattery
dev/scripts/sync-versions.sh validate      # Waliduj VERSION
dev/scripts/sync-versions.sh help          # Pomoc
```

## 🔄 Synchronizacja wersji w frontmatterach

Skrypt `sync-versions.sh` automatycznie aktualizuje pole `version:` w każdym pliku `.md`:

**Przed:**
```yaml
---
title: "Przykładowy dokument"
version: 0.0.1
created: 2025-12-03
---
```

**Po wykonaniu `make bump-version BUMP=patch`:**
```yaml
---
title: "Przykładowy dokument"
version: 0.0.2
created: 2025-12-03
---
```

## 📊 Raportowanie braków

`make version-report` generuje raport w `docs/reports/frontmatter-version-gap.md`:

```markdown
# Frontmatter version gap report

## Brak frontmatteru
- docs/przykład1.md
- ops/przykład2.md

## Frontmatter bez pola version
- dev/ideas/pomysł1.md
- usr/jakubc/notatka.md
```

## 🎨 Integracja z Obsidian

### Obsidian Git plugin
1. Zainstaluj plugin **Obsidian Git** (darmowy)
2. Konfiguracja:
   - Auto pull on startup: `true`
   - Auto commit interval: `10` minut
   - Commit message: `vault backup: {{date}}`

### Ręczny bump wersji w Obsidian
Przy edycji dokumentu w Obsidian:
1. Otwórz frontmatter
2. Ręcznie zwiększ `version:` (np. 0.0.1 → 0.0.2)
3. Plugin Obsidian Git automatycznie commituje zmianę

### Automatyczna synchronizacja
Po `git pull` w terminalu (po `make bump-version`):
- Obsidian Git wykryje zmiany
- Przeładuje pliki
- Wyświetli zaktualizowane wersje

## 🛡️ Walidacja i spójność

### Pre-commit hook (opcjonalnie)
```bash
#!/bin/bash
# .git/hooks/pre-commit

# Sprawdź spójność wersji przed commitem
make check-versions || {
    echo "❌ Niespójność wersji! Uruchom: make sync-versions"
    exit 1
}
```

### CI/CD (GitHub Actions)
```yaml
name: Version Check
on: [push, pull_request]
jobs:
  version-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm install -g semver
      - run: make check-versions
      - run: make version-report
```

## 📖 Polityka bumpowania

### Kiedy używać patch (0.0.X)
- Drobne poprawki błędów
- Aktualizacje dokumentacji
- Refactoring bez zmian API
- Poprawki formatowania

### Kiedy używać minor (0.X.0)
- Nowe funkcje/sekcje w dokumentacji
- Nowe skrypty/narzędzia (backward compatible)
- Rozszerzenia istniejących funkcji
- Dodanie nowych dokumentów

### Kiedy używać major (X.0.0)
- Breaking changes w strukturze repo
- Duży refactoring (np. zmiana struktury folderów)
- Nowa major wersja workflow/procesów
- Migracja do nowej architektury

## 🔗 Powiązane dokumenty

- [[wersjonowanie]] - główny dokument z pomysłem
- [[dev/ideas/wersjonowanie-v2]] - zaktualizowany plan wdrożenia
- `docs/STANDARDS.md` - standardy dokumentacji
- `docs/reference/specifications/yaml-frontmatter-spec.md` - specyfikacja frontmatter

## 🎓 Przykłady użycia

### Scenario 1: Pierwsza konfiguracja
```bash
# 1. Zainstaluj semver
npm install -g semver

# 2. Wygeneruj raport braków
make version-report

# 3. Uzupełnij brakujące wersje
# (użyj komendy z dev/ideas/wersjonowanie-v2.md)

# 4. Synchronizuj wszystko
make sync-versions

# 5. Sprawdź spójność
make check-versions
```

### Scenario 2: Regularny release
```bash
# 1. Wprowadź zmiany w plikach
git add .
git commit -m "feat: nowa funkcja X"

# 2. Podbij wersję (minor)
make bump-version BUMP=minor

# 3. Skrypt automatycznie:
#    - Podbija VERSION (0.1.0 → 0.2.0)
#    - Aktualizuje frontmattery
#    - Tworzy tag v0.2.0 (jeśli potwierdzisz)

# 4. Push
git push && git push --tags
```

### Scenario 3: Hotfix
```bash
# 1. Fix błędu
git add .
git commit -m "fix: naprawiono błąd Y"

# 2. Podbij patch
make bump-version BUMP=patch

# 3. Wersja: 0.2.0 → 0.2.1
```

## ❓ FAQ

**Q: Czy muszę instalować Node.js/npm dla samego semver?**
A: Tak, `semver` jest pakietem npm. Alternatywnie można użyć standalone binary lub reimplement w Bash (ale lepiej użyć gotowego narzędzia).

**Q: Co jeśli nie chcę używać semver?**
A: Możesz użyć starego skryptu `bump-version.sh` - Makefile automatycznie wykrywa czy `semver` jest dostępne.

**Q: Czy synchronizacja frontmatterów działa z Obsidian?**
A: Tak! Po `git pull` plugin Obsidian Git automatycznie przeładuje pliki ze zaktualizowanymi wersjami.

**Q: Jak działa walidacja wersji?**
A: `semver` sprawdza format według SemVer 2.0.0 spec (X.Y.Z + opcjonalnie pre-release/build metadata).

**Q: Co z plikami bez frontmatter?**
A: `version-report` wykryje je i wylistuje w raporcie. Możesz użyć skryptu Python do automatycznego dodania frontmatter.

## 🔗 Backlinks

- [[wersjonowanie]]
- [[dev]]
- [[STANDARDS]]
