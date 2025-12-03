---
title: "Checklist wdrożenia wersjonowania semver + odbudowa historii"
version: 0.0.2
created: 2025-12-03
modified: 2025-12-03
tags:
  - checklist
  - versioning
  - implementation
  - automation
status: active
owner: karinam
---

# Checklist wdrożenia wersjonowania semver + odbudowa historii

## ✅ Krok 1: Instalacja narzędzi

- [ ] Zainstaluj `semver` CLI: `npm install -g semver`
- [ ] Sprawdź wersję: `semver --version`
- [ ] Przetestuj: `semver -i patch 0.0.1` (powinno zwrócić `0.0.2`)

**Dokumentacja:** `docs/setup/install-semver.md`

## ✅ Krok 2: Weryfikacja istniejących skryptów

- [x] Skrypt `dev/scripts/sync-versions.sh` utworzony i wykonywalny
- [x] Skrypt `dev/scripts/generate-version-report.py` utworzony i wykonywalny
- [x] Skrypt `dev/scripts/rebuild-version-history.py` utworzony i wykonywalny
- [x] Skrypt `dev/scripts/pre-commit-version.sh` utworzony i wykonywalny
- [x] Makefile rozbudowany o nowe targety:
  - `make version` - wyświetl wersję
  - `make bump-version BUMP=[major|minor|patch]` - podbij wersję
  - `make sync-versions` - synchronizuj frontmattery
  - `make version-report` - raport braków
  - `make check-versions` - walidacja spójności
  - `make rebuild-history` - odbuduj wersje z Git
  - `make rebuild-history-dry` - dry-run odbudowy
  - `make install-hooks` - zainstaluj pre-commit hook
  - `make uninstall-hooks` - usuń hook

## ✅ Krok 3: Odbudowa historii z Git

- [ ] Uruchom dry-run: `make rebuild-history-dry`
- [ ] Sprawdź podsumowanie (ile plików zostanie zaktualizowanych)
- [ ] Jeśli wygląda OK, uruchom: `make rebuild-history`
- [ ] Sprawdź kilka plików ręcznie czy `version`/`created`/`modified` są poprawne

**Oczekiwany wynik:**
- Wszystkie pliki z historią Git mają poprawne daty i wersje bazujące na liczbie commitów
- Przykład: plik z 5 commitami → `version: 0.0.5`

## ✅ Krok 4: Instalacja automatycznego wersjonowania

- [ ] Zainstaluj pre-commit hook: `make install-hooks`
- [ ] Sprawdź czy hook istnieje: `ls -la .git/hooks/pre-commit`
- [ ] Przetestuj: zmodyfikuj dowolny plik `.md`, zrób `git add`, `git commit` i sprawdź czy wersja została podbita

**Oczekiwany wynik:**
- Przy każdym commicie zmodyfikowane pliki `.md` automatycznie dostają:
  - Podbity `version` (patch bump)
  - Zaktualizowany `modified` (dzisiejsza data)
- [ ] Użyj skryptu Python z `dev/ideas/wersjonowanie-v2.md` (sekcja "Komendy wdrożeniowe #2")
- [ ] **UWAGA:** Zrób backup przed uruchomieniem!
- [ ] Przejrzyj zmiany: `git diff`
- [ ] Zatwierdź lub odrzuć: `git add .` lub `git restore .`

## ✅ Krok 5: Synchronizacja wersji

- [ ] Sprawdź aktualną wersję: `make version`
- [ ] Zsynchronizuj wszystkie frontmattery: `make sync-versions`
- [ ] Sprawdź spójność: `make check-versions`

## ✅ Krok 6: Testowanie workflow bumpu

- [ ] Testowy bump patch: `make bump-version BUMP=patch`
- [ ] Sprawdź czy VERSION się zmieniło: `cat VERSION`
- [ ] Sprawdź czy frontmattery zostały zaktualizowane: `git diff`
- [ ] Jeśli OK, commit: `git add . && git commit -m "test: wersjonowanie semver"`
- [ ] Jeśli nie OK, rollback: `git restore .`

## ✅ Krok 7: Polityka wersjonowania

- [ ] Przeczytaj `docs/reference/semver-workflow.md`
- [ ] Ustal w zespole zasady bumpowania:
  - **patch** (0.0.X): drobne poprawki, docs, refactoring
  - **minor** (0.X.0): nowe funkcje, rozszerzenia
  - **major** (X.0.0): breaking changes, duże refactory
- [ ] Dodaj zasady do `docs/STANDARDS.md`

## ✅ Krok 8: Integracja z Obsidian (opcjonalnie)

- [ ] Zainstaluj plugin **Obsidian Git**
- [ ] Skonfiguruj auto-commit (10 min interval)
- [ ] Skonfiguruj auto-pull on startup
- [ ] Przetestuj workflow:
  - Edytuj plik w Obsidian
  - Plugin automatycznie commituje
  - W terminalu: `make bump-version BUMP=patch`
  - Sprawdź czy Obsidian wykrył zmiany

**Dokumentacja:** `docs/setup/install-semver.md` (sekcja "Konfiguracja dla Obsidian")

## ✅ Krok 9: Aktualizacja szablonów

- [ ] Zaktualizuj szablony Templater w Obsidian (dodaj `version: 0.0.1`)
- [ ] Zaktualizuj PR template w `.github/PULL_REQUEST_TEMPLATE.md`:
  ```markdown
  ## Checklist
  - [ ] Podbiłem wersję: `make bump-version BUMP=[patch|minor|major]`
  - [ ] Sprawdziłem spójność: `make check-versions`
  ```

## ✅ Krok 10: CI/CD (opcjonalnie)

- [ ] Dodaj krok walidacji do GitHub Actions:
  ```yaml
  - name: Install semver
    run: npm install -g semver
  - name: Check version consistency
    run: make check-versions
  - name: Generate version report
    run: make version-report
  ```

## ✅ Krok 11: Pre-commit hook (opcjonalnie)

- [ ] Utwórz `.git/hooks/pre-commit`:
  ```bash
  #!/bin/bash
  make check-versions || {
      echo "❌ Niespójność wersji! Uruchom: make sync-versions"
      exit 1
  }
  ```
- [ ] Nadaj uprawnienia: `chmod +x .git/hooks/pre-commit`

## ✅ Krok 12: Dokumentacja i komunikacja

- [ ] Dodaj sekcję o wersjonowaniu do `README.md`
- [ ] Zaktualizuj `CONTRIBUTING.md` z workflow wersjonowania
- [ ] Poinformuj zespół o nowym workflow
- [ ] Przeprowadź krótkie demo/szkolenie

## ✅ Krok 13: Weryfikacja końcowa

- [ ] Uruchom: `make version-report`
- [ ] Sprawdź czy liczba plików bez wersji się zmniejszyła
- [ ] Wykonaj pełny cykl:
  ```bash
  # 1. Zmiana w pliku
  echo "test" >> README.md
  git add README.md
  git commit -m "docs: test wersjonowania"

  # 2. Bump wersji
  make bump-version BUMP=patch

  # 3. Sprawdź spójność
  make check-versions

  # 4. Tag i push
  git push && git push --tags
  ```

## 📊 Metryki sukcesu

Po wdrożeniu sprawdź:
- [ ] Liczba plików bez `version` < 10% całości
- [ ] `make check-versions` przechodzi bez błędów
- [ ] Zespół wie jak używać `make bump-version`
- [ ] Tagi Git są synchronizowane z VERSION

## 🔗 Powiązane dokumenty

- `dev/ideas/wersjonowanie.md` - oryginalny pomysł
- `dev/ideas/wersjonowanie-v2.md` - plan wdrożenia z semver
- `docs/reference/semver-workflow.md` - szczegółowy workflow
- `docs/setup/install-semver.md` - instalacja narzędzi

## 🆘 W razie problemów

**Problem:** `semver: command not found`
**Rozwiązanie:** Zobacz `docs/setup/install-semver.md` → Troubleshooting

**Problem:** Makefile używa starego skryptu zamiast semver
**Rozwiązanie:** Sprawdź `which semver`, upewnij się że jest w PATH

**Problem:** Frontmattery nie są aktualizowane
**Rozwiązanie:** Uruchom ręcznie `dev/scripts/sync-versions.sh sync`

**Problem:** `make check-versions` pokazuje niespójności
**Rozwiązanie:** Uruchom `make sync-versions` i sprawdź ponownie

## 🔗 Backlinks

- [[wersjonowanie]]
- [[semver-workflow]]
- [[dev]]
