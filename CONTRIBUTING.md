---
modified: 2025-11-26
created: 2025-11-26
version: 0.0.6
title: Contributing to E-Waste Workshop
description: Wytyczne dla kontrybutorów projektu
tags:
  - contributing
  - development
  - community
language: pl
---

# Contributing to E-Waste Workshop

Dziękujemy za zainteresowanie projektem E-Waste Workshop! 🎉

## 📋 Jak kontrybuować

### 🚨 WYMAGANA konfiguracja (raz po sklonowaniu)

**Przed pierwszym committem MUSISZ:**

```bash
# 1. Zainstaluj semver
npm install -g semver

# 2. Skonfiguruj Git hooks
make install-hooks

# 3. Zweryfikuj konfigurację
git config core.hooksPath  # Powinno zwrócić: .githooks
semver --version           # Powinno zwrócić wersję semver
```

**Dlaczego to jest wymagane?**
- Pre-commit hook automatycznie wersjonuje pliki `.md`
- Zapewnia spójność wersjonowania w całym projekcie
- Wymuszane przez CI/CD - PR bez prawidłowego wersjonowania zostanie odrzucony

**Szczegółowa instrukcja:** [`docs/setup/onboarding.md`](docs/setup/onboarding.md)

### 1. Fork & Clone

```bash
# Fork repozytorium na GitHubie
# Następnie sklonuj swój fork:
git clone https://github.com/TWOJ_USERNAME/eww.git
cd eww

# WAŻNE: Od razu po sklonowaniu uruchom:
make install-hooks
```

### 2. Utwórz branch

```bash
git checkout -b feat/nazwa-funkcji
# lub
git checkout -b fix/nazwa-bugfixa
```

### 3. Wprowadź zmiany

- Pisz kod zgodnie z konwencjami projektu (patrz [AGENTS.md](AGENTS.md))
- Komentarze i komunikaty **po polsku**
- **Pliki Markdown muszą mieć frontmatter z `version`** (hook doda automatycznie)
- Dodaj testy dla nowych funkcji
- Sprawdź kod: `make lint` (jeśli dostępne)

### 4. Commit

Używamy **Conventional Commits**:

```bash
feat: dodaj nową funkcję X
fix: napraw błąd w Y
docs: zaktualizuj dokumentację Z
chore: porządki w konfiguracji
refactor: refaktoryzacja komponentu W
test: dodaj testy dla V
```

### 5. Sprawdź wersjonowanie

Przed push sprawdź spójność wersji:

```bash
make check-versions
```

Jeśli są błędy, napraw je:

```bash
make sync-versions  # Synchronizuje wszystkie pliki z VERSION
```

### 6. Push & Pull Request

```bash
git push origin feat/nazwa-funkcji
```

Utwórz Pull Request na GitHubie z opisem:

- Co zmienia PR?
- Dlaczego ta zmiana jest potrzebna?
- Czy dodano testy?
- Screenshot/demo (jeśli dotyczy UI/workflow)

**Checklist (wymagane przed zatwierdzeniem PR):**

- [ ] ✅ Zainstalowano Git hooks (`make install-hooks`)
- [ ] ✅ Przeczytano [`docs/setup/onboarding.md`](docs/setup/onboarding.md)
- [ ] ✅ Sprawdzono spójność wersji (`make check-versions`)
- [ ] ✅ Wszystkie pliki `.md` mają frontmatter z `version`
- [ ] ✅ Testy przechodzą (`bats tests/`)
- [ ] ✅ Commit messages zgodne z Conventional Commits
- [ ] ✅ Kod i komentarze po polsku

## 🧪 Testowanie

```bash
# Uruchom testy
bats tests/

# Sprawdź składnię Bash
shellcheck bin/* lib/*.sh
```

## 📝 Konwencje kodu

### Bash

- Shebang: `#!/usr/bin/env bash`
- Bezpieczeństwo: `set -euo pipefail`
- Zmienne globalne: `UPPERCASE`
- Zmienne lokalne: `local lowercase`
- Cytuj zmienne: `"$variable"`
- Funkcje: `namespace::function_name` lub `function_name`

### Dokumentacja

- Markdown z YAML frontmatter
- Język: **polski**
- Struktura: tytuł, opis, przykłady, odnośniki

## 🐛 Zgłaszanie błędów

Zgłaszaj issues z:
- Opisem problemu
- Krokami reprodukcji
- Środowiskiem (OS, wersja Bash, itp.)
- Logami (jeśli dostępne)

## 💡 Propozycje funkcji

Feature requests mile widziane! Opisz:
- Use case - do czego to potrzebne?
- Propozycja implementacji
- Alternatywy, które rozważałeś/aś

## 📖 Zasoby

- [AGENTS.md](AGENTS.md) - kontekst projektu dla AI
- [docs/](docs/) - pełna dokumentacja
- [core/workflow/](core/workflow/) - workflow i procesy

## 🤝 Code of Conduct

Projekt przestrzega [Code of Conduct](CODE_OF_CONDUCT.md). Bądź uprzejmy/a i profesjonalny/a.

## 📧 Kontakt

- GitHub Issues: https://github.com/Nairecth/eww/issues
- Website: https://e-wasteworkshop.co.uk
- YouTube: https://www.youtube.com/channel/UCe31iZazQVN678Yqn62u3GA

---

**Dzięki za wkład w projekt! 🚀**

## 🔗 Backlinks

- [[EWW-MAP]]
- [[INDEX]]
- [[README]]
