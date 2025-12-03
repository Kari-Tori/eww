---
title: "Instalacja semver CLI"
version: 0.0.1
created: 2025-12-03
modified: 2025-12-03
tags:
  - setup
  - versioning
  - semver
status: active
---

# Instalacja semver CLI

## 🎯 Czym jest semver?

`semver` to narzędzie CLI do pracy z wersjami w formacie Semantic Versioning (X.Y.Z). Używane w projekcie EWW do:
- Walidacji numerów wersji
- Automatycznej inkrementacji (major/minor/patch)
- Porównywania wersji

## 📦 Instalacja

### Metoda 1: npm (zalecana)

```bash
# Instalacja globalna
npm install -g semver

# Weryfikacja
semver --version
```

### Metoda 2: Z kodem źródłowym repo (bez instalacji globalnej)

```bash
# Sklonuj repo semver
git clone https://github.com/npm/node-semver.git ~/.local/share/semver
cd ~/.local/share/semver
npm install

# Dodaj alias do ~/.bashrc
echo 'alias semver="node ~/.local/share/semver/bin/semver.js"' >> ~/.bashrc
source ~/.bashrc

# Weryfikacja
semver --version
```

### Metoda 3: Przez package.json projektu (dev dependency)

```bash
cd /home/karinam/git/eww

# Utwórz package.json jeśli nie istnieje
npm init -y

# Zainstaluj semver jako dev dependency
npm install --save-dev semver

# Użycie przez npx
npx semver --version
```

## ✅ Weryfikacja instalacji

```bash
# Sprawdź wersję
semver --version

# Testowe użycie
semver 1.2.3
# Wyjście: 1.2.3

# Inkrementacja
semver -i patch 1.2.3
# Wyjście: 1.2.4

semver -i minor 1.2.3
# Wyjście: 1.3.0

semver -i major 1.2.3
# Wyjście: 2.0.0
```

## 🚀 Pierwsze kroki w projekcie EWW

Po zainstalowaniu `semver`, przetestuj integrację z repo:

```bash
cd /home/karinam/git/eww

# 1. Sprawdź aktualną wersję projektu
make version

# 2. Waliduj format wersji w pliku VERSION
dev/scripts/sync-versions.sh validate

# 3. Wygeneruj raport braków wersji
make version-report

# 4. (Opcjonalnie) Synchronizuj wersje w frontmatterach
make sync-versions
```

## 🔧 Konfiguracja dla Obsidian

Jeśli używasz Obsidian w vaultcie EWW:

1. **Zainstaluj Obsidian Git plugin:**
   - Otwórz Settings → Community plugins
   - Wyszukaj "Obsidian Git"
   - Zainstaluj i włącz

2. **Skonfiguruj auto-commit:**
   - Settings → Obsidian Git
   - Vault backup interval: `10` minut
   - Auto pull on startup: włącz
   - Commit message: `vault backup: {{date}}`

3. **Workflow z wersjonowaniem:**
   - Edytujesz plik w Obsidian
   - Plugin automatycznie commituje
   - W terminalu uruchamiasz `make bump-version BUMP=patch`
   - Plugin wykrywa zmianę i przeładowuje pliki

## 📚 Dodatkowe zasoby

- Dokumentacja semver: https://github.com/npm/node-semver
- SemVer 2.0.0 spec: https://semver.org/
- Workflow w EWW: `docs/reference/semver-workflow.md`
- Plan wdrożenia: `dev/ideas/wersjonowanie-v2.md`

## ❓ Troubleshooting

### Błąd: `semver: command not found`

**Rozwiązanie 1:** Sprawdź ścieżkę npm global bin
```bash
npm config get prefix
# Dodaj do PATH w ~/.bashrc:
export PATH="$PATH:$(npm config get prefix)/bin"
```

**Rozwiązanie 2:** Użyj npx zamiast globalnej instalacji
```bash
npx semver --version
```

**Rozwiązanie 3:** Zainstaluj ponownie
```bash
npm uninstall -g semver
npm install -g semver
```

### Błąd: `npm: command not found`

Zainstaluj Node.js i npm:
```bash
# Kubuntu/Ubuntu
sudo apt update
sudo apt install nodejs npm

# Weryfikacja
node --version
npm --version
```

### Makefile wywołuje stary skrypt zamiast semver

Sprawdź warunek w `Makefile`:
```bash
# Makefile sprawdza dostępność semver:
if command -v semver >/dev/null 2>&1; then
    # używa sync-versions.sh (z semver)
else
    # używa starego bump-version.sh
fi
```

Upewnij się, że `semver` jest w PATH.

## 🔗 Backlinks

- [[semver-workflow]]
- [[wersjonowanie]]
- [[dev]]
