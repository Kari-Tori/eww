---
version: 0.0.6
title: "Wersjonowanie - Wdrożenie Kompletne"
created: 2025-11-28
modified: 2025-11-28
tags:
  - wersjonowanie
  - implementacja
  - enforcement
  - dokumentacja
  - kompletne
---

# Wersjonowanie - Wdrożenie Kompletne

## 🎯 Podsumowanie wdrożenia

System wersjonowania dla repozytorium EWW został **w pełni zaimplementowany i wymuszony** dla wszystkich użytkowników.

### Czego dotyczy

System wersjonuje automatycznie wszystkie pliki `.md` w repozytorium:
- Dodaje/aktualizuje frontmatter YAML z `version`, `modified`, `created`
- Synchronizuje wersję z plikiem `VERSION` i tagami Git
- Wymusza spójność wersjonowania poprzez Git hooks
- Integruje się z Obsidian dla płynnego workflow

## 📋 Co zostało wdrożone

### 1. Infrastruktura techniczna

#### Narzędzia podstawowe
- ✅ **semver CLI** (npm package) - walidacja i inkrementacja wersji SemVer
- ✅ **Git hooks** (`.githooks/pre-commit`, `.githooks/pre-push`) - automatyzacja wersjonowania
- ✅ **Python scripts** - rebuild historii, generowanie raportów
- ✅ **Bash scripts** - sync wersji, setup hooków

#### Pliki systemowe
```
eww/
├── .githooks/
│   ├── pre-commit       # Auto-wersjonowanie przy commit
│   └── pre-push         # Walidacja przed push
├── dev/scripts/
│   ├── sync-versions.sh           # Główny skrypt wersjonowania
│   ├── rebuild-version-history.py # Odbudowa z Git history
│   ├── generate-version-report.py # Raport braków
│   ├── pre-commit-version.sh      # Hook pre-commit (źródło)
│   └── setup-githooks.sh          # Automatyczna konfiguracja
├── VERSION                # Główna wersja projektu (0.0.6)
└── Makefile              # 8 targetów wersjonowania
```

### 2. Dokumentacja

#### docs/versioning/ (9 plików)
- `README.md` - główny indeks, wszystkie komendy, status PRODUCTION READY
- `quickstart.md` - 5-minutowe wprowadzenie
- `install-semver.md` - instalacja semver (3 metody)
- `semver-workflow.md` - szczegółowy workflow
- `wersjonowanie-checklist.md` - 13-krokowa checklist
- `final-summary.md` - statystyki (1480 plików, 591 z Git)
- `implementation-summary.md` - szczegóły implementacji
- `implementation-final.md` - raport końcowy

#### docs/setup/ (2 pliki)
- `obsidian-config.md` - kompletna konfiguracja Obsidian (pluginy, ustawienia, templates)
- `onboarding.md` - **OBOWIĄZKOWA** instrukcja dla nowych użytkowników (7 kroków + checklist)

#### docs/concepts/ (1 plik)
- `wersjonowanie.md` - koncepcja systemu (przeniesione z dev/ideas/)

### 3. Wymuszanie (enforcement)

#### Git hooks (współdzielone w repo)
- **Pre-commit**: Automatycznie wersjonuje zmodyfikowane pliki `.md`
  - Podbija `version` (patch +1)
  - Aktualizuje `modified` (timestamp ISO 8601)
  - Używa semver CLI gdy dostępne

- **Pre-push**: Waliduje spójność przed push
  - Uruchamia `make check-versions`
  - Blokuje push jeśli wersje są niespójne
  - Kompatybilny z Git LFS

#### Konfiguracja Git
```bash
git config core.hooksPath .githooks
```
Ustawiane automatycznie przez `make install-hooks` lub `dev/scripts/setup-githooks.sh`

#### CI/CD
- `.github/workflows/version-check.yml` - GitHub Actions workflow
- Uruchamia `make check-versions` na każdym push/PR
- Blokuje merge PR z niespójnymi wersjami

#### Dokumentacja wymagań
- **CONTRIBUTING.md** - zaktualizowane z OBOWIĄZKOWĄ sekcją konfiguracji wersjonowania
- **Pull Request Template** - checklist wersjonowania (7 punktów)
- **README.md** - sekcja wersjonowania z linkami do dokumentacji

### 4. Integracja z Obsidian

#### Wymagane pluginy
- **Obsidian Git** - auto-commit co 10 min, auto-pull przy starcie
- **Templater** - templates z automatycznym frontmatter

#### Konfiguracja
- Auto-backup co 10 minut
- Auto-pull przy uruchomieniu Obsidian
- Commit message: `vault backup: {numFiles} changed`
- Keyboard shortcuts: `Ctrl+S` (commit + push)

#### Template structure
```yaml
---
version: 0.0.1
title: "{{title}}"
created: {{date:YYYY-MM-DD}}
modified: {{date:YYYY-MM-DD}}
tags:
  - auto-versioned
---
```

## 🔧 Workflow dla użytkowników

### Konfiguracja (raz po sklonowaniu)

```bash
# 1. Zainstaluj semver
npm install -g semver

# 2. Skonfiguruj Git hooks
make install-hooks

# 3. Zweryfikuj
git config core.hooksPath  # Powinno: .githooks
semver --version           # Powinno: 7.x.x
```

**OBOWIĄZKOWE:** Przeczytaj [`docs/setup/onboarding.md`](../setup/onboarding.md)

### Codzienna praca

#### Tworzenie nowych plików
1. Utwórz plik `.md` z frontmatter (użyj template w Obsidian)
2. Dodaj do Git: `git add nowy-plik.md`
3. Commit: `git commit -m "docs: dodaj nowy-plik"`
4. **Hook automatycznie** zaktualizuje `version` i `modified`

#### Edycja istniejących plików
1. Edytuj plik w Obsidian lub VS Code
2. Zapisz zmiany
3. Commit: `git commit -am "docs: aktualizuj plik"`
4. **Hook automatycznie** podbije wersję (patch +1) i zaktualizuje `modified`

#### Push zmian
1. Przed push: `make check-versions` (opcjonalnie)
2. Push: `git push`
3. **Pre-push hook** sprawdzi spójność wersji
4. Jeśli są błędy: `make sync-versions` i powtórz push

### Zarządzanie wersjami

#### Sprawdź aktualną wersję
```bash
make version
# Lub
cat VERSION
```

#### Podbij wersję projektu
```bash
make bump-version BUMP=patch  # 0.0.6 → 0.0.7
make bump-version BUMP=minor  # 0.0.6 → 0.1.0
make bump-version BUMP=major  # 0.0.6 → 1.0.0
```

#### Synchronizuj wszystkie pliki z VERSION
```bash
make sync-versions
```

#### Sprawdź spójność
```bash
make check-versions
```

#### Odbuduj historię z Git
```bash
make rebuild-history  # Rzeczywista aktualizacja
make rebuild-history-dry  # Podgląd bez zmian
```

## 📊 Statystyki wdrożenia

### Pliki zaktualizowane
- **1480 plików** `.md` zsynchronizowanych z VERSION
- **591 plików** z odbudowaną historią z Git commits
- **889 plików** bez historii Git (nowe/zaimportowane)

### Git historia
- **Tag v0.0.6** utworzony
- Wersja obliczana jako `0.0.{commit_count}`
- `created` = data pierwszego commit
- `modified` = data ostatniego commit

### Dokumentacja
- **12 plików** dokumentacji wersjonowania
- **2 pliki** setup/onboarding
- **8 Makefile targets**
- **1 GitHub Actions workflow**
- **2 Git hooks**

## 🚨 Wymagania dla wszystkich użytkowników

### PRZED pierwszym committem

**MUSISZ wykonać:**

1. ✅ Zainstalować semver: `npm install -g semver`
2. ✅ Skonfigurować hooks: `make install-hooks`
3. ✅ Przeczytać: [`docs/setup/onboarding.md`](../setup/onboarding.md)
4. ✅ Zweryfikować: `git config core.hooksPath` → `.githooks`

### PRZED każdym PR

**Checklist (z Pull Request Template):**

- [ ] ✅ Zainstalowano Git hooks (`make install-hooks`)
- [ ] ✅ Przeczytano [`docs/setup/onboarding.md`](../setup/onboarding.md)
- [ ] ✅ Sprawdzono spójność wersji (`make check-versions`)
- [ ] ✅ Wszystkie pliki `.md` mają frontmatter z `version`
- [ ] ✅ Testy przechodzą
- [ ] ✅ Commit messages zgodne z Conventional Commits
- [ ] ✅ Kod i komentarze po polsku

### W Obsidian

**MUSISZ zainstalować:**

1. **Obsidian Git** plugin
   - Auto-backup co 10 min
   - Auto-pull przy starcie

2. **Templater** plugin
   - Template z frontmatter version

**Szczegóły:** [`docs/setup/obsidian-config.md`](../setup/obsidian-config.md)

## 🔍 Weryfikacja działania

### Test 1: Pre-commit hook

```bash
echo "test" >> test.md
git add test.md
git commit -m "test: weryfikacja hook"
# Sprawdź czy version został zaktualizowany w test.md
git diff HEAD~1 test.md
```

### Test 2: Pre-push validation

```bash
# Zepsuj wersję celowo
echo "9.9.9" > VERSION
git add VERSION
git commit -m "test: zła wersja"
git push
# Powinno: ❌ Push zatrzymany - błąd wersjonowania
```

### Test 3: Sync versions

```bash
make sync-versions
make check-versions
# Powinno: ✅ Wszystkie wersje spójne
```

## 📖 Linki do dokumentacji

### Dla użytkowników
- [Onboarding (OBOWIĄZKOWE)](../setup/onboarding.md)
- [Quickstart](README.md#quickstart)
- [Obsidian Configuration](../setup/obsidian-config.md)

### Dla maintainerów
- [SemVer Workflow](semver-workflow.md)
- [Implementation Checklist](wersjonowanie-checklist.md)
- [Final Summary](final-summary.md)

### Dla deweloperów
- [CONTRIBUTING.md](../../CONTRIBUTING.md)
- [.github/PULL_REQUEST_TEMPLATE.md](../../.github/PULL_REQUEST_TEMPLATE.md)
- [Concept: Wersjonowanie](../concepts/wersjonowanie.md)

## 🎓 FAQ

### Co jeśli hook nie działa?

```bash
# Sprawdź konfigurację
git config core.hooksPath
# Powinno: .githooks

# Jeśli puste, uruchom setup
make install-hooks
# lub
./dev/scripts/setup-githooks.sh
```

### Czy mogę ominąć hook?

Technicznie tak (`--no-verify`), ale **NIE ZALECANE**:

```bash
git commit --no-verify  # Omija pre-commit
git push --no-verify    # Omija pre-push
```

**UWAGA:** CI/CD i tak sprawdzi wersjonowanie. PR zostanie zablokowany.

### Jak naprawić niespójne wersje?

```bash
# Synchronizuj wszystkie pliki z VERSION
make sync-versions

# Sprawdź czy naprawione
make check-versions
```

### Co z plikami bez Git history?

Pre-commit hook nadal zadzia, ustawiając:
- `version: 0.0.1`
- `created: {current_date}`
- `modified: {current_date}`

Przy kolejnych commitach wersja będzie rosła.

### Jak zmienić wersję główną projektu?

```bash
make bump-version BUMP=minor  # 0.0.6 → 0.1.0
```

To utworzy tag Git `v0.1.0` i zaktualizuje `VERSION`.

## 🚀 Następne kroki

- [ ] Dodać testy integracyjne dla hooków
- [ ] Rozszerzyć CI/CD o automatyczne release notes
- [ ] Stworzyć hook post-merge dla automatycznej synchronizacji
- [ ] Dodać metryki wersjonowania do dashboardu projektu
- [ ] Rozważyć automatyczne semantic versioning z commit messages

## 🔗 Backlinks

- [[INDEX]]
- [[docs/versioning/README]]
- [[docs/setup/onboarding]]
- [[CONTRIBUTING]]

---

**Status:** ✅ PRODUCTION READY - pełne wdrożenie i enforcement
**Data wdrożenia:** 2025-11-28
**Wersja systemu:** 0.0.6
**Maintainer:** [@Nairecth](https://github.com/Nairecth), [@karinam](https://github.com/karinam)
