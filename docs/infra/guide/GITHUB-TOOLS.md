created: 2025-11-21T09:00:00Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---
tags:
  - #automation
  - #docs
  - #eww
  - #git
  - #knowledge
  - #linux
  - #secondbrain
title: "🚀 GitHub & AI Tools - Zestaw Narzędzi"






owner: jakubc
created: 2025-11-21T09:00:00Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---


# 🚀 GitHub & AI Tools - Zestaw Narzędzi

> **Kompletny setup** - GitHub CLI, Copilot, Continue.dev i więcej

## 📦 Co instalujemy?

### 1. GitHub CLI (`gh`)
**Oficjalne CLI do GitHub**

- Zarządzanie repo, PR, issues z terminala
- Szybsze workflow niż web UI
- Automatyzacja zadań

### 2. GitHub Copilot CLI
**AI asystent w terminalu**

- Sugestie komend shell
- Wyjaśnianie komend
- Generowanie skryptów

### 3. Continue.dev
**AI coding assistant dla VS Code**

- Chat z AI w edytorze
- Inline code editing
- Multi-model support (Claude, GPT-4, Codestral)
- Kontekst: kod, docs, terminal, diff

### 4. GitHub Copilot
**AI pair programmer**

- Autocomplete kodu
- Generowanie funkcji
- Testy, dokumentacja
- Chat w edytorze

### 5. Git Configuration
**Optimized Git setup**

- User config
- Helpful aliases
- Best practices


## ⚡ Instalacja

### Automatyczna (zalecane)

```bash
cd /git/eww
./bin/eww-github-setup
```

### Ręczna

#### 1. GitHub CLI

```bash
# Debian/Ubuntu
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y

# Weryfikacja
gh --version
```

#### 2. GitHub Copilot CLI

```bash
gh extension install github/gh-copilot
gh copilot --help
```

#### 3. Continue.dev (VS Code)

```bash
code --install-extension Continue.continue
```

Konfiguracja: `~/.continue/config.json`

#### 4. GitHub Copilot (VS Code)

```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```


## 🔐 Konfiguracja

### 1. Uwierzytelnienie GitHub CLI

```bash
gh auth login
```

Wybierz:
- GitHub.com
- HTTPS
- Authenticate via browser

### 2. Copilot CLI

```bash
gh copilot config
```

### 3. Continue.dev API Keys

Edytuj `~/.continue/config.json`:

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4",
      "provider": "anthropic",
      "model": "claude-sonnet-4-20250514",
      "apiKey": "sk-ant-..."
    },
    {
      "title": "GPT-4 Turbo",
      "provider": "openai",
      "model": "gpt-4-turbo-preview",
      "apiKey": "sk-..."
    }
  ]
}
```

Gdzie wziąć API keys:
- **Anthropic**: https://console.anthropic.com/
- **OpenAI**: https://platform.openai.com/api-keys
- **Mistral**: https://console.mistral.ai/

### 4. GitHub Copilot

W VS Code:
1. Kliknij ikonę Copilot (prawy dolny róg)
2. Sign in with GitHub
3. Authorize extension

**Wymagane:** GitHub Copilot subscription


## 🚀 Użycie

### GitHub CLI

```bash
# Repos
gh repo clone user/repo
gh repo view
gh repo create

# Pull Requests
gh pr list
gh pr create
gh pr checkout 123
gh pr review

# Issues
gh issue list
gh issue create
gh issue view 42

# Workflows
gh workflow list
gh workflow run
gh run list
gh run view

# Gists
gh gist create file.sh
gh gist list
```

### GitHub Copilot CLI

```bash
# Sugestie komend
gh copilot suggest "jak znaleźć duże pliki"
gh copilot suggest "compress all jpg files"

# Wyjaśnienia
gh copilot explain "git rebase -i HEAD~3"
gh copilot explain "find . -name '*.log' -mtime +7 -delete"
```

**Aliasy:**
```bash
# Dodaj do ~/.bashrc
alias '??'='gh copilot suggest -t shell'
alias 'git?'='gh copilot suggest -t git'
alias 'gh?'='gh copilot suggest -t gh'
```

Użycie:
```bash
?? jak znaleźć procesy zajmujące port 8080
git? squash last 3 commits
gh? create PR with template
```

### Continue.dev (VS Code)

**Skróty klawiszowe:**
- `Ctrl+L` - Otwórz chat
- `Ctrl+I` - Inline edit
- `Ctrl+Shift+R` - Debug terminal command

**Slash commands:**
```
/edit - Edytuj kod
/comment - Dodaj komentarze
/test - Generuj testy
/fix - Napraw błędy
/explain - Wyjaśnij kod
```

**Przykłady:**
```
@codebase jak działa system logowania?
@terminal wyjaśnij błąd z ostatniej komendy
@docs jak używać tej funkcji?
```

### GitHub Copilot (VS Code)

**Autocomplete:**
- Pisz kod → Copilot sugeruje → `Tab` akceptuje
- `Ctrl+Enter` - Zobacz alternatywy

**Chat:**
- `Ctrl+Shift+I` - Otwórz chat
- `/explain` - Wyjaśnij kod
- `/fix` - Napraw kod
- `/tests` - Generuj testy
- `/doc` - Napisz dokumentację

**Inline chat:**
- Zaznacz kod
- `Ctrl+I`
- Opisz co zmienić


## 📊 Porównanie

| Feature | GitHub CLI | Copilot CLI | Continue.dev | Copilot |
|---------|-----------|-------------|--------------|---------|
| **Typ** | CLI tool | AI CLI | VS Code ext | VS Code ext |
| **Główna funkcja** | GitHub ops | Shell help | AI coding | Code complete |
| **Kontekst** | GitHub | Terminal | Codebase | Current file |
| **AI Model** | - | GPT-4 | Multi-model | Codex |
| **Koszt** | Free | Copilot sub | API keys | Copilot sub |
| **Offline** | ✅ | ❌ | ❌ | ❌ |


## 💡 Best Practices

### Workflow z AI

1. **Planowanie** - Continue.dev chat dla architektury
2. **Kodowanie** - Copilot autocomplete
3. **Review** - Copilot explain
4. **Dokumentacja** - Copilot /doc
5. **Testy** - Continue.dev /test
6. **Deploy** - GitHub CLI workflow run

### Bezpieczeństwo

- ❌ Nie commituj API keys
- ✅ Używaj `.env` dla secrets
- ✅ Review AI-generated code
- ✅ Test przed deploy

### Efektywność

- Używaj alias'ów (`??`, `git?`)
- Kontekst w Continue.dev (`@codebase`, `@terminal`)
- Copilot dla boilerplate
- GitHub CLI dla rutynowych tasków


## 🔧 Troubleshooting

### GitHub CLI nie działa

```bash
# Sprawdź wersję
gh --version

# Sprawdź auth
gh auth status

# Re-login
gh auth logout
gh auth login
```

### Copilot CLI nie odpowiada

```bash
# Sprawdź extension
gh extension list

# Update
gh extension upgrade gh-copilot

# Debug
gh copilot --help
```

### Continue.dev nie łączy się

1. Sprawdź API keys w `~/.continue/config.json`
2. Sprawdź saldo w console (Anthropic/OpenAI)
3. Restart VS Code

### GitHub Copilot offline

1. Sprawdź subscription: https://github.com/settings/copilot
2. Sign out/in w VS Code
3. Sprawdź połączenie internetowe


## 📚 Zasoby

### Dokumentacja
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [GitHub Copilot Docs](https://docs.github.com/copilot)
- [Continue.dev Docs](https://continue.dev/docs)
- [Copilot Best Practices](https://github.blog/changelog/label/copilot/)

### Tutoriale
- [GitHub CLI Quickstart](https://docs.github.com/en/github-cli/github-cli/quickstart)
- [Copilot Getting Started](https://docs.github.com/en/copilot/getting-started-with-github-copilot)
- [Continue.dev Quickstart](https://continue.dev/docs/quickstart)

### Community
- [GitHub CLI Discussions](https://github.com/cli/cli/discussions)
- [Copilot Community](https://github.com/orgs/community/discussions/categories/copilot)
- [Continue.dev Discord](https://discord.gg/vapESyrFmJ)


## 🎯 Next Steps

1. ✅ Zainstaluj narzędzia: `./bin/eww-github-setup`
2. ✅ Skonfiguruj auth: `gh auth login`
3. ✅ Dodaj API keys do Continue.dev
4. ✅ Zaloguj się do Copilot w VS Code
5. ✅ Dodaj aliasy do `~/.bashrc`
6. 🚀 Start coding with AI!


**Zaktualizowano:** 2025-11-21  
**Autor:** EWW Team  
**Źródło:** [[INDEX]]
