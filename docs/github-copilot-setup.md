---
title: GitHub Copilot - Pełna instalacja i konfiguracja
created: 2025-12-01
modified: 2025-12-01
author: AI Assistant
category: documentation
tags:
  - github
  - copilot
  - ai
  - vscode
  - configuration
version: 0.0.6
---

# GitHub Copilot - Pełna instalacja i konfiguracja

## ✅ Status instalacji

### Zainstalowane komponenty

1. **GitHub CLI** ✅
   - Wersja: `2.83.1 (2025-11-13)`
   - Ścieżka: `/usr/bin/gh`
   - Autoryzacja: ✅ `Kari-Tori`
   - Uprawnienia: `gist`, `read:org`, `repo`, `workflow`

2. **GitHub Copilot CLI** ✅
   - **NOWE**: `@githubnext/github-copilot-cli` v0.1.36
   - Ścieżka: `~/.nvm/versions/node/v22.18.0/bin/github-copilot-cli`
   - Alias: `ghcs` (dodany do `~/.bashrc`)
   - **STARE (deprecated)**: `gh copilot` v1.2.0

3. **VS Code Extensions** ✅
   - `github.copilot` - główne rozszerzenie Copilot
   - `github.copilot-chat` - Copilot Chat
   - `github.vscode-pull-request-github` - Pull Requests
   - `github.vscode-github-actions` - GitHub Actions
   - `continue.continue` - Continue.dev (MCP)
   - **Łącznie:** 87 rozszerzeń

## 🔧 Konfiguracja VS Code

### Lokalizacja ustawień
`.vscode/settings.json` - ustawienia workspace dla projektu eww

### Kluczowe funkcje włączone

```json
{
  // Copilot - pełne włączenie dla wszystkich typów plików
  "github.copilot.enable": {
    "*": true,
    "yaml": true,
    "markdown": true,
    "shellscript": true,
    "json": true,
    "jsonc": true,
    "python": true
  },

  // Auto-completions i code actions
  "github.copilot.editor.enableAutoCompletions": true,
  "github.copilot.editor.enableCodeActions": true,
  "github.copilot.editor.iterativeFixing": true,

  // Copilot Chat - experimental features
  "github.copilot.chat.enabled": true,
  "github.copilot.chat.localeOverride": "pl",
  "github.copilot.chat.runCommand.enabled": true,
  "github.copilot.chat.executeImmediately": true,
  "github.copilot.chat.scopeSelection": true,
  "github.copilot.referencesEnabled": true,

  // Advanced - GPT-4 engine
  "github.copilot.advanced": {
    "authProvider": "github",
    "debug.overrideEngine": "gpt-4",
    "length": 500,
    "temperature": "0.7",
    "listCount": 10
  },

  // Experimental - coding agent capabilities
  "github.copilot.chat.experimental.codeGeneration.enabled": true,
  "github.copilot.chat.experimental.codingAgentCapabilities.enabled": true,

  // Security - trusted workspace
  "security.workspace.trust.enabled": true,
  "security.workspace.trust.startupPrompt": "never",
  "security.workspace.trust.untrustedFiles": "open"
}
```

## 📚 Instrukcje dla Copilot

### Główny plik instrukcji
`.github/copilot-instructions.md` - zawiera:
- Zasady programowania Bash
- Strukturę projektu
- Konwencje nazewnictwa
- Przykłady kodu
- Wymagania językowe (Polski!)

### Dodatkowy kontekst
`AGENTS.md` - kontekst dla AI coding agents:
- Misja Zero Waste
- Architektura repo
- Workflow
- Wersjonowanie

## 🚀 Użycie

### W VS Code
1. **Inline suggestions** - automatyczne podczas pisania kodu
2. **Chat** - `Ctrl+I` lub ikona Copilot
3. **Code actions** - żarówka przy błędach

### W terminalu

#### Nowe Copilot CLI (zalecane)
```bash
# Alias (po source ~/.bashrc)
ghcs "jak uruchomić testy"

# Pełna komenda
github-copilot-cli "jak zainstalować pakiet"
```

#### Stare gh copilot (deprecated, ale działa)
```bash
gh copilot suggest "komenda do wykonania"
gh copilot explain "wyjaśnij kod"
```

### Makefile targets
```bash
make github-status    # Status GitHub Tools
make github-setup     # Instalacja (jeśli potrzeba)
make github-auth      # Autoryzacja
```

## 🔐 Uprawnienia i bezpieczeństwo

### GitHub Token Scopes
- ✅ `gist` - zarządzanie Gist
- ✅ `read:org` - odczyt organizacji
- ✅ `repo` - pełny dostęp do repozytoriów
- ✅ `workflow` - GitHub Actions

### Workspace Trust
- ✅ Workspace `/home/karinam/git/eww` jest trusted
- ✅ Auto-execute poleceń włączone
- ✅ Brak promptów o bezpieczeństwo

## 📊 Wersjonowanie

Zgodnie z polityką projektu:
- **VERSION**: `0.0.0.5`
- **Git tag**: `v0.0.0.5` ✅
- **Spójność**: zweryfikowana przez `make check-versions`

## 🛠️ Troubleshooting

### Copilot nie działa
```bash
# 1. Sprawdź status
make github-status

# 2. Sprawdź autoryzację
gh auth status

# 3. Restart VS Code
code --restart
```

### Brak sugestii
1. Sprawdź czy rozszerzenie jest aktywne (dolny pasek VS Code)
2. Sprawdź ustawienia: `Ctrl+,` → "copilot"
3. Wyloguj i zaloguj ponownie: Command Palette → "Copilot: Sign Out"

### Stare CLI deprecated
- Zainstalowano nowe: `@githubnext/github-copilot-cli`
- Stare `gh copilot` nadal działa, ale jest przestarzałe
- Użyj aliasu `ghcs` dla nowego CLI

## 📝 Następne kroki

1. **Testowanie** - użyj Copilot do pisania kodu
2. **Fine-tuning** - dostosuj temperature/length w advanced settings
3. **MCP** - skonfiguruj Continue.dev z dodatkowymi modelami
4. **Dokumentacja** - dodaj więcej przykładów do `.github/copilot-instructions.md`

## 🔗 Linki

- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [Copilot CLI](https://github.com/github/copilot-cli)
- [VS Code Copilot](https://code.visualstudio.com/docs/copilot/overview)
- [Continue.dev](https://continue.dev/)

---

**Ostatnia aktualizacja:** 2025-12-01
**Wykonane przez:** AI Assistant
**Status:** ✅ Wszystko zainstalowane i skonfigurowane

## 🔗 Backlinks

- [[docs/docs]]
- [[INDEX]]
- [[EWW-MAP]]
