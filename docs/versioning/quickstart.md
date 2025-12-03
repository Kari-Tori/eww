---
title: "Wersjonowanie semver - Quick Start"
version: 0.0.6
created: 2025-12-03
modified: 2025-12-03
tags:
  - quickstart
  - versioning
  - semver
  - cheatsheet
  - automation
---

# 🚀 Wersjonowanie semver - Quick Start

## ✅ System gotowy do użycia!

Infrastruktura wersjonowania semver + odbudowa historii + automatyzacja jest w pełni wdrożona.

---

## 🎯 Szybki Start (3 kroki)

### 1. Zainstaluj semver (jeśli jeszcze nie masz)
```bash
npm install -g semver
semver --version  # Sprawdź czy działa
```

### 2. Odbuduj historię wersji z Git
```bash
# Najpierw dry-run (zobacz co zostanie zmienione)
make rebuild-history-dry

# Jeśli OK, uruchom właściwą odbudowę
make rebuild-history
```

**Efekt:** Wszystkie pliki `.md` z historią Git dostaną:
- `version: 0.0.{commits}` (bazując na liczbie commitów)
- `created: YYYY-MM-DD` (data pierwszego commitu)
- `modified: YYYY-MM-DD` (data ostatniego commitu)

### 3. Aktywuj automatyczne wersjonowanie
```bash
make install-hooks
```

**Efekt:** Przy każdym `git commit` zmodyfikowane pliki `.md` automatycznie dostaną:
- Podbity `version` (patch bump: `0.0.1` → `0.0.2`)
- Zaktualizowany `modified` (dzisiejsza data)

---

## 📋 Podstawowe komendy

### Odbudowa historii

```bash
# Dry-run (zobacz co zostanie zmienione)
make rebuild-history-dry

# Właściwa odbudowa
make rebuild-history
```

### Automatyzacja

```bash
# Zainstaluj pre-commit hook
make install-hooks

# Usuń hook
make uninstall-hooks
```

### Zarządzanie wersjami

```bash
# Sprawdź aktualną wersję projektu
make version

# Podbij wersję projektu
make bump-version BUMP=patch   # 0.0.5 → 0.0.6
make bump-version BUMP=minor   # 0.0.5 → 0.1.0
make bump-version BUMP=major   # 0.0.5 → 1.0.0

# Synchronizuj frontmattery z VERSION
make sync-versions
```

### Raporty i walidacja

```bash
# Raport braków wersji
make version-report
# Wynik: docs/reports/frontmatter-version-gap.md

# Sprawdź spójność wersji (Git tag / VERSION / frontmattery)
make check-versions
```

### Sprawdź spójność wersji (VERSION, tagi Git, frontmattery)
```bash
make check-versions
```

---

## 🛠️ Zaawansowane (skrypty bezpośrednio)

### Waliduj format wersji w VERSION
```bash
./dev/scripts/sync-versions.sh validate
```

### Pomoc dla sync-versions.sh
```bash
./dev/scripts/sync-versions.sh help
```

---

## 📖 Dokumentacja

- **Pełny przewodnik:** `docs/reference/semver-workflow.md`
- **Checklist wdrożenia:** `docs/checklists/wersjonowanie-checklist.md`
- **Instalacja semver:** `docs/setup/install-semver.md`
- **Finalne podsumowanie:** `docs/reports/wersjonowanie-implementacja-final.md`

---

## 🎯 Workflow dla nowego commita

```bash
# 1. Wprowadź zmiany w kodzie/dokumentacji
vim some-file.md

# 2. Podbij wersję (patch/minor/major)
make bump-version BUMP=patch

# 3. Sprawdź zmiany
git diff
cat VERSION

# 4. Commit + push
git add .
git commit -m "chore: bump version to $(cat VERSION)"
git push
git push --tags
```

---

## ❓ FAQ

**Q: Czy muszę ręcznie aktualizować `version` w każdym pliku?**
A: Nie! `make sync-versions` robi to automatycznie.

**Q: Co zrobić jeśli mam pliki bez frontmatter?**
A: Wygeneruj raport (`make version-report`) i dodaj frontmattery ręcznie lub użyj skryptu Python z `dev/ideas/wersjonowanie.md`.

**Q: Czy mogę użyć 4-segmentowej wersji (0.0.0.5)?**
A: Nie. SemVer wymaga 3 segmentów (MAJOR.MINOR.PATCH).

**Q: Kiedy podbijam major/minor/patch?**
A:
- **patch**: drobne poprawki, docs
- **minor**: nowe funkcje
- **major**: breaking changes

---

**Autor:** karinam
**Data:** 2025-12-03
**Status:** ✅ Gotowe do użycia
