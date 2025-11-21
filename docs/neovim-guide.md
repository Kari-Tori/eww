---
title: Neovim Guide
description: Neovim - przewodnik testowania
type: file
category: docs
filepath: docs/neovim-guide.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
aliases:
  - neovim_guide
related:
  - docs/docs.md
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/neovim-guide.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# Neovim - przewodnik testowania

## 📁 Pliki testowe

Utworzono 3 pliki testowe w `dev/tests/`:

1. **test_neovim.md** - test Markdown + frontmatter
2. **test_neovim.yaml** - test YAML + schema validation
3. **test_neovim.sh** - test Bash + LSP features

## 🚀 Jak testować

### 1. Uruchom Neovim z plikiem testowym

```bash
# Test Markdown
nvim dev/tests/test_neovim.md

# Test YAML
nvim dev/tests/test_neovim.yaml

# Test Bash
nvim dev/tests/test_neovim.sh
```

### 2. Sprawdź health check

W Neovim:
```vim
:checkhealth
```

Powinno pokazać:
- ✅ `bash-language-server` - OK
- ✅ `yaml-language-server` - OK
- ✅ `marksman` lub `markdown-oxide` - dla Markdown

### 3. Testuj funkcje LSP

#### Dla wszystkich języków:

| Skrót | Akcja | Opis |
|-------|-------|------|
| `K` | Hover | Dokumentacja pod kursorem |
| `gd` | Go to definition | Przejdź do definicji |
| `gr` | Find references | Znajdź użycia |
| `]d` | Next diagnostic | Następny błąd |
| `[d` | Previous diagnostic | Poprzedni błąd |
| `<leader>ca` | Code actions | Dostępne akcje |
| `<leader>rn` | Rename | Zmień nazwę symbolu |
| `<leader>f` | Format | Formatuj plik |

#### Specyficzne dla Markdown:

| Skrót | Akcja |
|-------|-------|
| `<leader>mp` | Markdown Preview |
| `gx` | Open link under cursor |
| `[[` / `]]` | Navigate headers |

#### Specyficzne dla YAML:

- Autocomplete dla GitHub Actions workflow
- Schema validation (czerwone podkreślenie błędów)
- Indentation guides

#### Specyficzne dla Bash:

- ShellCheck integration (błędy inline)
- Function documentation (hover nad funkcją)
- Variable completion

## 🧪 Test skryptu Bash

Uruchom skrypt testowy:

```bash
# Bezpośrednio
./dev/tests/test_neovim.sh

# Lub przez Neovim terminal
# W Neovim: <Ctrl-/> aby otworzyć terminal
# Następnie: ./dev/tests/test_neovim.sh
```

Powinno pokazać:
```
Running Neovim LSP tests for Bash...
======================================
✓ Test passed
✓ Array test passed
✓ Command substitution test passed
✓ Conditional test passed
✓ Error handling test passed
======================================
All tests passed!
```

## ⚙️ Konfiguracja dodatkowych pluginów

### Markdown Preview

Dodaj do `~/.config/nvim/lua/plugins/markdown.lua`:

```lua
return {
  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
    },
  },

  -- Table mode
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
    },
  },

  -- Markdown TOC
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    cmd = { "GenTocGFM", "GenTocMarked" },
  },
}
```

### YAML Schema validation

Dodaj do `~/.config/nvim/lua/plugins/yaml.lua`:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/gitlab-ci.json"] = ".gitlab-ci.yml",
                ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
              },
              validate = true,
              completion = true,
            },
          },
        },
      },
    },
  },
}
```

### Bash - ShellCheck integration

Dodaj do `~/.config/nvim/lua/plugins/bash.lua`:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
          settings = {
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command)",
              shellcheckPath = "shellcheck",
            },
          },
        },
      },
    },
  },

  -- ShellCheck diagnostics
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      },
    },
  },
}
```

## 📊 Checklist testów

### Markdown (`test_neovim.md`)

- [ ] Syntax highlighting dla code blocks
- [ ] YAML frontmatter podświetlony
- [ ] Tabele wyświetlane poprawnie
- [ ] Mermaid diagrams syntax OK
- [ ] Math equations (KaTeX) syntax OK
- [ ] `:MarkdownPreview` działa
- [ ] Spell check włączony (`:set spell`)
- [ ] Format on save (`<leader>f`)

### YAML (`test_neovim.yaml`)

- [ ] Schema validation działa
- [ ] Autocomplete dla GitHub Actions
- [ ] Błędy składni pokazane inline
- [ ] Indentation guide widoczny
- [ ] Anchors/aliases podświetlone
- [ ] Hover pokazuje dokumentację
- [ ] Format on save działa

### Bash (`test_neovim.sh`)

- [ ] ShellCheck errors inline
- [ ] Function documentation (hover)
- [ ] Variable autocomplete
- [ ] Go to definition (funkcje)
- [ ] Find references (zmienne)
- [ ] Code actions dostępne
- [ ] Rename symbol działa
- [ ] Format on save (shfmt)

## 🎯 Porównanie edytorów dla Markdown/YAML

### VS Code
**Zalety:**
- ✅ Najlepszy Markdown Preview (GitHub style)
- ✅ Łatwa konfiguracja
- ✅ Extensions marketplace
- ✅ Copilot integration

**Wady:**
- ❌ Wolniejszy od terminala
- ❌ Wymaga X11/Wayland

### Neovim
**Zalety:**
- ✅ Błyskawiczny w terminalu
- ✅ SSH friendly
- ✅ Potężne vim motions
- ✅ LSP native

**Wady:**
- ❌ Markdown preview wymaga przeglądarki
- ❌ Krzywa uczenia się

### Helix (gdyby był zainstalowany)
**Zalety:**
- ✅ Zero config LSP
- ✅ Szybki
- ✅ Selection-first workflow

**Wady:**
- ❌ Brak pluginów
- ❌ Młody projekt
- ❌ Brak Markdown preview

## 💡 Rekomendacja dla projektu eww

**Używaj według kontekstu:**

1. **Markdown dokumentacja** → **VS Code**
   - Najlepszy preview
   - Łatwa edycja tabel
   - Copilot pomaga z pisaniem

2. **YAML konfiguracja** → **Neovim**
   - Schema validation
   - Szybka edycja
   - Vim motions dla struktur

3. **Bash scripting** → **Neovim**
   - LSP + ShellCheck
   - Terminal w edytorze
   - Debugger integration

4. **Quick edits przez SSH** → **Neovim**
   - Dostępny wszędzie
   - Nie wymaga GUI

## 🔧 Dodatki

### Alias w .bashrc

Dodaj do `~/.bashrc`:

```bash
# Neovim aliases
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'

# Szybkie otwarcie testów
alias nvtest='nvim dev/tests/test_neovim.md'
alias nvmd='nvim README.md'
alias nvconf='nvim ~/.config/nvim/'
```

### Skrypt do szybkiego testu

```bash
# dev/scripts/test-neovim.sh
#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Neovim LSP Test Suite"
echo "========================"

echo "1. Testing Bash LSP..."
./dev/tests/test_neovim.sh

echo ""
echo "2. Opening test files in Neovim..."
echo "   - test_neovim.md (Markdown)"
echo "   - test_neovim.yaml (YAML)"
echo "   - test_neovim.sh (Bash)"

nvim -p dev/tests/test_neovim.{md,yaml,sh}
```

## 📚 Dokumentacja

- **Neovim LSP**: `:help lsp`
- **LazyVim**: https://lazyvim.github.io
- **bash-language-server**: https://github.com/bash-lsp/bash-language-server
- **yaml-language-server**: https://github.com/redhat-developer/yaml-language-server
- **marksman** (Markdown LSP): https://github.com/artempyanykh/marksman

---

**Autor:** Nairecth  
**Data:** 2025-11-09  
**Wersja:** 1.0.0
