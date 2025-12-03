---
title: "Globalne standardy projektu EWW"
description: "Uniwersalne konwencje struktury, nazewnictwa i organizacji dla całego repozytorium"
version: 0.0.6
category: documentation
tags:
  - standards
  - conventions
  - structure
  - best-practices
  - eww
language: pl
created: 2025-12-02
updated: 2025-12-03
author: karinam
owner: jakubc
---

# Globalne standardy projektu EWW

Dokument definiuje **uniwersalne konwencje** dla całego repozytorium E-Waste Workshop. Standardy dotyczą struktury katalogów, nazewnictwa, frontmatter, wersjonowania i organizacji plików.

## 📋 Spis treści

1. [Struktura katalogów](#struktura-katalogów)
2. [Nazewnictwo plików i folderów](#nazewnictwo-plików-i-folderów)
3. [Frontmatter YAML](#frontmatter-yaml)
4. [Wersjonowanie](#wersjonowanie)
5. [Dokumentacja](#dokumentacja)
6. [Kod](#kod)
7. [Testowanie](#testowanie)

---

## 1. Struktura katalogów

### 1.1 Warstwy główne

Repozytorium EWW organizuje się wokół **5 warstw logicznych**:

```
eww/
├── business/       # Wiedza domenowa, procesy, governance
├── development/    # Warsztat deweloperski (docelowa nazwa dev/)
├── core/          # Runtime, config, workflow repo
├── docs/          # Dokumentacja (głównie infra)
├── users/         # Workspace użytkowników (docelowa nazwa usr/)
└── archive/       # Archiwum historyczne
```

### 1.2 Standardy wspólne dla wszystkich warstw

#### **Każdy katalog musi mieć:**
- ✅ **Folder note** (`nazwa-katalogu.md`) lub `README.md`
- ✅ **Frontmatter YAML** z metadanymi
- ✅ **Lista podfolderów** w sekcji `## 📁 Podfoldery`
- ✅ **Backlinki** do katalogu nadrzędnego

#### **Katalogi specjalne:**
- `archive/` – zawsze na końcu listy podfolderów
- `tmp/`, `var/`, `logs/` – ignorowane w indeksach (`.gitignore`)
- `tests/` – obok kodu, który testuje

#### **Hierarchia maksymalna:**
- **3-4 poziomy** zagnieżdżenia (więcej = refaktor)
- Przykład OK: `dev/projects/obsidian/plugins/`
- Przykład ZŁY: `dev/tools/automation/scripts/helpers/utils/core/`

---

## 2. Nazewnictwo plików i folderów

### 2.1 Foldery

#### **Styl:**
- **lowercase, kebab-case**: `my-folder/`, `graph-view/`
- **Bez polskich znaków**: `dokumentacja/` → `docs/`
- **Bez spacji**: `My Documents/` → `my-documents/`

#### **Konwencje nazewnicze:**
```
business/processes/      # Procesy biznesowe (liczba mnoga)
dev/projects/           # Projekty deweloperskie (liczba mnoga)
docs/infra/hardware/    # Sprzęt (rzeczownik)
core/config/            # Konfiguracja (singularis)
users/jakubc/           # Nazwa użytkownika (lowercase)
```

#### **Foldery zarezerwowane:**
- `archive/` – archiwum historyczne
- `tmp/` – pliki tymczasowe (git-ignored)
- `var/` – zmienne, logi, cache (git-ignored)
- `tests/` – testy automatyczne
- `docs/` – dokumentacja

### 2.2 Pliki

#### **Markdown:**
```
README.md               # Indeks główny katalogu
CHANGELOG.md            # Historia zmian
TODO.md                 # Lista zadań
folder-name.md          # Folder note (Obsidian convention)
my-document.md          # Standardowy dokument (kebab-case)
```

#### **Skrypty Bash:**
```
bin/eww-command         # Bez rozszerzenia, executable
lib/module-name.sh      # Z rozszerzeniem .sh
dev/scripts/helper.sh   # Skrypty pomocnicze z .sh
```

#### **Konfiguracje:**
```
.gitignore              # Dot-files na początku
bashrc.eww.snippet      # Snippet z rozszerzeniem
config.yaml             # Lowercase, rozszerzenie wymagane
```

#### **Testy:**
```
tests/test-module.bats      # BATS testy (snake_case lub kebab-case)
tests/fixtures/data.json    # Dane testowe
```

---

## 3. Frontmatter YAML

### 3.1 Pola obowiązkowe

**Wszystkie dokumenty Markdown (.md)** muszą mieć frontmatter:

```yaml
---
title: "Tytuł dokumentu"
version: 0.0.0.1
created: 2025-12-02
modified: 2025-12-02
tags:
  - tag1
  - tag2
---
```

**`version` jest obowiązkowe** (SemVer `MAJOR.MINOR.PATCH`). Aktualizuj przy każdej modyfikacji treści.

### 3.2 Pola opcjonalne

```yaml
---
title: "Tytuł dokumentu"
description: "Krótki opis (1-2 zdania)"
author: karinam               # Autor główny
owner: jakubc                 # Właściciel/maintainer
category: documentation       # Kategoria
type: guide                   # Typ dokumentu
language: pl                  # Język (domyślnie pl)
audience: developers          # Grupa docelowa
status: draft                 # Status: draft/review/published
created: 2025-12-02
modified: 2025-12-02
tags:
  - tag1
  - tag2
---
```

### 3.3 Konwencje tagów

#### **Struktura tagów:**
```
#folder_note        # Oznaczenie folder note
#eww                # Projekt główny
#business           # Warstwa
#docs               # Warstwa
#development        # Warstwa

#automation         # Temat
#governance         # Temat
#infrastructure     # Temat

#guide              # Typ dokumentu
#checklist          # Typ dokumentu
#reference          # Typ dokumentu
```

#### **Hierarchia tagów (Obsidian nested tags):**
```yaml
tags:
  - eww/business/processes
  - eww/docs/infra/network
  - development/tests/unit
```

### 3.4 Daty

- **Format:** `YYYY-MM-DD` lub `YYYY-MM-DDTHH:MM:SSZ` (ISO 8601)
- **created:** data utworzenia (nigdy nie zmieniana)
- **modified:** data ostatniej modyfikacji (auto-update)

---

## 4. Wersjonowanie

### 4.1 Semantic Versioning (SemVer)

Projekt stosuje **Semantic Versioning 2.0.0**:

```
vX.Y.Z

X = MAJOR – breaking changes
Y = MINOR – new features (backward compatible)
Z = PATCH – bugfixes
```

### 4.2 Spójność wersji

**Wymagana zgodność 3 źródeł:**

1. **Git tag**: `git tag -a v0.0.0.5 -m "Release 0.0.0.5"`
2. **Plik VERSION**: `0.0.0.5`
3. **Frontmatter wszystkich dokumentów**: `version: 0.0.0.5`

#### **Walidacja:**
```bash
make check-versions      # Sprawdź spójność
make bump-version BUMP=0.0.0.6  # Bump wersji
```

### 4.3 Obsidian (darmowe wersjonowanie)

- Używamy pluginu **Obsidian Git** (darmowy) do wersjonowania vaulta; nie korzystamy z płatnego Obsidian Sync.
- Wszystkie szablony Obsidian (np. Templater) muszą zawierać pole `version` w frontmatterze.
- Workflow: `pull` → edycje → `Obsidian Git: commit & push` (auto-stamping dat, ale wersję podbijamy ręcznie zgodnie z SemVer).

### 4.4 Conventional Commits

**Format commit message:**

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### **Typy:**
- `feat:` – nowa funkcjonalność
- `fix:` – naprawa błędu
- `docs:` – dokumentacja
- `chore:` – maintenance, refaktoring
- `test:` – dodanie/modyfikacja testów
- `style:` – formatowanie, bez zmian logiki
- `refactor:` – refaktoring bez nowych funkcji
- `perf:` – optymalizacja wydajności
- `ci:` – CI/CD

#### **Przykłady:**
```bash
feat(core): dodaj funkcję inicjalizacji EWW_ROOT
fix(business): popraw błąd w procesie inwentaryzacji
docs(infra): zaktualizuj dokumentację sieci GaryNet
chore(dev): przenieś skrypty do dev/automation/
```

---

## 5. Dokumentacja

### 5.1 Struktura dokumentu

**Każdy dokument Markdown powinien zawierać:**

```markdown
---
title: "Tytuł"
created: 2025-12-02
modified: 2025-12-02
tags:
  - tag1
---

# Tytuł (H1 – tylko jeden)

Krótkie wprowadzenie (1-3 zdania).

## 📋 Spis treści (opcjonalnie)

- [Sekcja 1](#sekcja-1)
- [Sekcja 2](#sekcja-2)

---

## Sekcja 1

Treść sekcji...

### Podsekcja 1.1

Szczegóły...

---

## 🔗 Backlinks

- [[parent-folder]]
- [[related-document]]
- [[INDEX]]
```

### 5.2 Konwencje pisania

#### **Język:**
- **Polski** jako domyślny (kod + dokumentacja + komentarze)
- Angielski tylko dla kodu upstream/bibliotek zewnętrznych

#### **Emoji w nagłówkach (opcjonalnie):**
```markdown
## 📋 Spis treści
## 📁 Podfoldery
## 🔗 Backlinks
## ✅ Checklist
## ⚠️ Uwaga
## 💡 Wskazówka
```

#### **Code blocks:**
````markdown
```bash
#!/usr/bin/env bash
set -euo pipefail
```

```yaml
key: value
```
````

#### **Tabele:**
```markdown
| Kolumna 1 | Kolumna 2 | Kolumna 3 |
|-----------|-----------|-----------|
| Wartość 1 | Wartość 2 | Wartość 3 |
```

### 5.3 Folder notes (Obsidian)

**Każdy katalog powinien mieć folder note:**

```markdown
---
title: "nazwa-katalogu"
created: 2025-12-02
modified: 2025-12-02
tags:
  - folder_note
  - eww/business
---

# nazwa-katalogu

Opis katalogu (1-3 zdania).

## 📁 Podfoldery

- [[subfolder-1]]
- [[subfolder-2]]
- [[archive]]  # Zawsze na końcu

## 📄 Pliki w tym folderze

- [[document-1]]
- [[document-2]]

## 🔗 Backlinks

- [[parent-folder]]
- [[INDEX]]
```

---

## 6. Kod

### 6.1 Bash

#### **Shebang:**
```bash
#!/usr/bin/env bash
```

#### **Bezpieczeństwo:**
```bash
set -euo pipefail  # Zawsze na początku skryptu
```

#### **Nazewnictwo:**

**Zmienne globalne:**
```bash
EWW_ROOT="/git/eww"           # UPPERCASE
EWW_BANNER_ENABLE=1           # Boolean jako 0/1
```

**Zmienne lokalne:**
```bash
local katalog="/path/to/dir"  # lowercase, zawsze z `local`
local plik_konfiguracji="config.yaml"
```

**Funkcje:**
```bash
# Namespace dla modułów
eww::init() {
    # kod funkcji
}

git::last_tag() {
    # kod funkcji
}

# Funkcje pomocnicze (bez namespace)
pobierz_wersje() {
    # kod funkcji
}
```

#### **Komentarze:**
```bash
# Pobierz ostatni tag Git
# Argumenty:
#   $1 - opcjonalny prefix (np. "v")
# Zwraca:
#   Tag jako string lub pusty string
git::last_tag() {
    local prefix="${1:-}"
    git describe --tags --abbrev=0 "${prefix}*" 2>/dev/null || echo ""
}
```

#### **Cytowanie zmiennych:**
```bash
# DOBRZE ✅
echo "Wartość: $zmienna"
cd "$katalog" || exit 1
rm -rf "${TMP_DIR:?}"

# ŹLE ❌
echo Wartość: $zmienna     # Brak cytowania
cd $katalog                # Brak cytowania
rm -rf $TMP_DIR            # Niebezpieczne
```

### 6.2 Python

*(Jeśli projekt rozwinie się o komponenty Pythonowe)*

```python
# PEP 8 – Python Enhancement Proposal 8
# snake_case dla funkcji i zmiennych
# PascalCase dla klas

def pobierz_dane(sciezka: str) -> dict:
    """
    Pobiera dane z pliku JSON.

    Args:
        sciezka: Ścieżka do pliku JSON

    Returns:
        Dict z danymi
    """
    with open(sciezka, 'r', encoding='utf-8') as f:
        return json.load(f)
```

### 6.3 YAML

```yaml
# Wcięcia: 2 spacje (nie tabulatory)
# Klucze: lowercase, snake_case lub kebab-case

version: 0.0.0.1
config:
  enable_banner: true
  root_path: /git/eww
  modules:
    - name: core
      enabled: true
    - name: dev
      enabled: false
```

---

## 7. Testowanie

### 7.1 Struktura testów

```
development/tests/
├── unit/              # Testy jednostkowe (BATS)
│   ├── test-git.bats
│   ├── test-log.bats
│   └── test-version.bats
├── integration/       # Testy integracyjne
│   └── test-init.bats
├── fixtures/          # Dane testowe
│   ├── sample.json
│   └── mock-config.yaml
└── tools/             # Narzędzia testowe
    └── helpers.bash
```

### 7.2 BATS testy

```bash
#!/usr/bin/env bats
# test-git.bats - Testy funkcji Git

load 'tools/helpers'

setup() {
    # Przygotowanie przed każdym testem
    source "${BATS_TEST_DIRNAME}/../lib/git.sh"
}

teardown() {
    # Sprzątanie po teście
    rm -rf "$TMP_DIR"
}

@test "git::last_tag zwraca ostatni tag" {
    run git::last_tag
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "git::last_tag zwraca pusty string gdy brak tagów" {
    # Mock repo bez tagów
    run git::last_tag
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
```

### 7.3 Uruchamianie testów

```bash
# Wszystkie testy
make test
bats tests/

# Konkretny plik
bats tests/unit/test-git.bats

# Z verbose output
bats -t tests/
```

---

## 📊 Checklist compliance

Użyj tej checklisty do weryfikacji zgodności z standardami:

### Struktura katalogów
- [ ] Katalog ma folder note lub README.md
- [ ] Frontmatter YAML jest kompletny
- [ ] Sekcja "Podfoldery" istnieje i jest aktualna
- [ ] Backlinki prowadzą do rodzica i INDEX
- [ ] Hierarchia ≤ 4 poziomy

### Nazewnictwo
- [ ] Foldery: lowercase, kebab-case
- [ ] Pliki: kebab-case.md lub UPPERCASE.md (specjalne)
- [ ] Brak polskich znaków w nazwach
- [ ] Brak spacji w nazwach

### Frontmatter
- [ ] `title` jest wypełniony
- [ ] `created` jest ustawiony (ISO 8601)
- [ ] `modified` jest aktualny
- [ ] Tagi są logiczne i hierarchiczne
- [ ] `version` zgodny z VERSION i tagiem Git (jeśli dotyczy)

### Kod Bash
- [ ] Shebang: `#!/usr/bin/env bash`
- [ ] `set -euo pipefail` na początku
- [ ] Zmienne cytowane: `"$zmienna"`
- [ ] `local` dla zmiennych lokalnych
- [ ] Funkcje z komentarzem opisującym działanie

### Wersjonowanie
- [ ] Tag Git: `vX.Y.Z`
- [ ] Plik VERSION: `X.Y.Z`
- [ ] Frontmatter: `version: X.Y.Z`
- [ ] Commit message: Conventional Commits

### Dokumentacja
- [ ] Język polski (domyślnie)
- [ ] Jeden H1 (# Tytuł)
- [ ] Sekcje z H2 (##)
- [ ] Code blocks z podświetleniem składni
- [ ] Sekcja "Backlinks" na końcu

---

## 🔧 Narzędzia automatyzacji

### Makefile targets

```bash
make help                 # Pomoc
make check-versions       # Walidacja wersji
make bump-version BUMP=X  # Bump wersji
make changelog            # Generuj CHANGELOG
make index                # Aktualizuj indeksy
make test                 # Uruchom testy
```

### Skrypty pomocnicze

```bash
dev/scripts/check-version-consistency.sh  # Sprawdź spójność wersji
dev/scripts/check_readme.sh              # Sprawdź README
dev/scripts/version.sh                   # Wyświetl wersję
```

---

## 📚 Powiązane dokumenty

- [[AGENTS]] – Kontekst dla AI coding agents
- [[.github/copilot-instructions]] – Instrukcje GitHub Copilot
- [[docs/governance/RESTRUCTURE-MAP]] – Plan migracji struktury
- [[CONTRIBUTING]] – Przewodnik kontrybutorów
- [[README]] – Główny README projektu
- [[INDEX]] – Główny indeks

---

## 🔗 Backlinks

- [[docs]]
- [[INDEX]]
- [[AGENTS]]

---

**Wersja dokumentu:** 0.0.0.1
**Ostatnia aktualizacja:** 2025-12-02
**Właściciel:** jakubc
**Autor:** karinam
