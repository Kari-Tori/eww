---
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

### 1. Fork & Clone

```bash
# Fork repozytorium na GitHubie
# Następnie sklonuj swój fork:
git clone https://github.com/TWOJ_USERNAME/eww.git
cd eww
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

### 5. Push & Pull Request

```bash
git push origin feat/nazwa-funkcji
```

Utwórz Pull Request na GitHubie z opisem:
- Co zmienia PR?
- Dlaczego ta zmiana jest potrzebna?
- Czy dodano testy?
- Screenshot/demo (jeśli dotyczy UI/workflow)

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
