---
version: 0.0.1
title: "Dokumentacja wersjonowania - Index"
created: 2025-12-03
modified: 2025-12-03
tags:
  - documentation
  - versioning
  - index
status: active
owner: karinam
---

# Dokumentacja wersjonowania EWW

System wersjonowania oparty na **semver CLI + automatyzacja + odbudowa historii z Git**.

## 📚 Dokumenty w tym katalogu

### ⚠️ START TUTAJ

**[enforcement-complete.md](enforcement-complete.md)** - **KOMPLETNE WDROŻENIE**
   - 🎯 Podsumowanie całego systemu
   - 🔧 Workflow dla użytkowników
   - 🚨 WYMAGANIA dla wszystkich
   - 📊 Statystyki wdrożenia
   - 🔍 Weryfikacja działania
   - ❓ FAQ
   - **Status: ✅ PRODUCTION READY**

### Dla użytkowników

1. **[quickstart.md](quickstart.md)** - Szybki start (5 minut)
   - Instalacja `semver`
   - Pierwsze kroki
   - Podstawowe komendy

2. **[install-semver.md](install-semver.md)** - Instalacja i konfiguracja
   - 3 metody instalacji semver
   - Weryfikacja
   - Integracja z Obsidian
   - Troubleshooting

3. **[semver-workflow.md](semver-workflow.md)** - Szczegółowy workflow
   - Jak działa system?
   - Dostępne komendy
   - Przykłady użycia
   - FAQ

### Setup (OBOWIĄZKOWE)

4. **[../setup/onboarding.md](../setup/onboarding.md)** - Onboarding nowych użytkowników
   - 7 kroków konfiguracji
   - Checklist (17 punktów)
   - 3 testy weryfikacyjne
   - Troubleshooting

5. **[../setup/obsidian-config.md](../setup/obsidian-config.md)** - Konfiguracja Obsidian
   - Wymagane pluginy (Obsidian Git, Templater)
   - Konfiguracja JSON
   - Template structure
   - Keyboard shortcuts

### Dla implementatorów

6. **[wersjonowanie-checklist.md](wersjonowanie-checklist.md)** - Checklist wdrożenia
   - 13 kroków wdrożenia
   - Metryki sukcesu
   - Pomoc w razie problemów

7. **[implementation-summary.md](implementation-summary.md)** - Podsumowanie wdrożenia
   - Co zostało zrobione
   - Dostępne komendy
   - Następne kroki

8. **[final-summary.md](final-summary.md)** - Finalne podsumowanie
   - Statystyki wdrożenia
   - Kluczowe osiągnięcia
   - Metryki sukcesu

### Koncepcja

9. **[../concepts/wersjonowanie.md](../concepts/wersjonowanie.md)** - Oryginalny koncept
   - Problem i rozwiązanie
   - Plan wdrożenia
   - Inspiracje

## 🚀 Szybki start

```bash
# 1. Zainstaluj semver
npm install -g semver

# 2. Sprawdź wersję projektu
make version

# 3. Podbij wersję
make bump-version BUMP=patch

# 4. Sprawdź spójność
make check-versions
```

## 🔧 Dostępne komendy

### Podstawowe
```bash
make version                      # Wyświetl wersję
make bump-version BUMP=patch      # Podbij patch
make bump-version BUMP=minor      # Podbij minor
make bump-version BUMP=major      # Podbij major
```

### Synchronizacja
```bash
make sync-versions                # Sync frontmattery z VERSION
make check-versions               # Waliduj spójność
make version-report               # Raport braków wersji
```

### Odbudowa historii
```bash
make rebuild-history-dry          # Dry-run odbudowy
make rebuild-history              # Odbuduj wersje z Git
```

### Hooki
```bash
make install-hooks                # Zainstaluj pre-commit hook
make uninstall-hooks              # Usuń hook
```

## 📊 Status wdrożenia

- ✅ Skrypty automatyzacji (4 pliki)
- ✅ Integracje (Makefile, hooks, CI/CD)
- ✅ Dokumentacja (7 dokumentów)
- ✅ Odbudowa historii (591 plików)
- ✅ Synchronizacja wersji (1480 plików)
- ✅ Pre-commit hook aktywny
- ✅ GitHub Actions workflow

**Wersja projektu:** 0.0.6
**Tag Git:** v0.0.6
**Status:** PRODUCTION READY ✅

## 🎯 Kluczowe komponenty

### Skrypty (`dev/scripts/`)
- `sync-versions.sh` - synchronizacja wersji (semver)
- `generate-version-report.py` - raportowanie braków
- `rebuild-version-history.py` - odbudowa z Git
- `pre-commit-version.sh` - automatyczny bump

### Integracje
- `Makefile` - 8 targetów wersjonowania
- `.git/hooks/pre-commit` - hook aktywny
- `.github/workflows/version-check.yml` - CI/CD

### Dokumentacja
- `docs/versioning/` - wszystkie dokumenty (ten katalog)
- `docs/concepts/wersjonowanie.md` - oryginalny koncept
- `docs/reports/frontmatter-version-gap.md` - raport braków

## 🔗 Powiązane dokumenty

- [[../concepts/wersjonowanie]] - Oryginalny koncept
- [[semver-workflow]] - Workflow semver
- [[quickstart]] - Szybki start
- [[final-summary]] - Finalne podsumowanie

## 📞 Pomoc

**Problem z instalacją?**
→ [install-semver.md](install-semver.md) → Troubleshooting

**Pytania o workflow?**
→ [semver-workflow.md](semver-workflow.md) → FAQ

**Krok po kroku?**
→ [wersjonowanie-checklist.md](wersjonowanie-checklist.md)

---

**Utworzono:** 2025-12-03
**Wersja dokumentacji:** 0.0.1
**Status:** Aktywna dokumentacja produkcyjna
