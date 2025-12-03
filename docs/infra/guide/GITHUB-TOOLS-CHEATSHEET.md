---
version: 0.0.4
title: "GITHUB-TOOLS-CHEATSHEET"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

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
title: "⚡ GitHub Tools - Cheatsheet"






owner: jakubc
created: 2025-11-21T09:00:00Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---


# ⚡ GitHub Tools - Cheatsheet

## 🔧 Setup

```bash
# Instalacja wszystkiego
make github-setup

# Auth
make github-auth

# Status
make github-status
```


## 📦 GitHub CLI (`gh`)

### Repos
```bash
gh repo clone user/repo              # Clone
gh repo view                         # View current
gh repo create                       # Create new
gh repo fork                         # Fork repo
```

### Pull Requests
```bash
gh pr list                           # List PRs
gh pr create                         # Create PR
gh pr checkout 123                   # Checkout PR#123
gh pr view 123                       # View PR
gh pr merge 123                      # Merge PR
gh pr review --approve               # Approve
gh pr diff                           # Show diff
```

### Issues
```bash
gh issue list                        # List issues
gh issue create                      # Create issue
gh issue view 42                     # View #42
gh issue close 42                    # Close #42
gh issue comment 42 "message"        # Comment
```

### Workflows
```bash
gh workflow list                     # List workflows
gh workflow run workflow.yml         # Run workflow
gh run list                          # List runs
gh run view                          # View latest
gh run watch                         # Watch run
```

### Gists
```bash
gh gist create file.sh               # Create gist
gh gist list                         # List gists
gh gist view abc123                  # View gist
gh gist edit abc123                  # Edit gist
```


## 🤖 Copilot CLI

### Sugestie
```bash
# General suggest
gh copilot suggest "jak znaleźć duże pliki"

# Shell commands
gh copilot suggest -t shell "compress jpg files"

# Git commands
gh copilot suggest -t git "undo last commit"

# GitHub CLI
gh copilot suggest -t gh "create PR"
```

### Wyjaśnienia
```bash
gh copilot explain "find . -name '*.log' -delete"
gh copilot explain "git rebase -i HEAD~3"
gh copilot explain "docker-compose up -d"
```

### Aliasy (dodaj do ~/.bashrc)
```bash
alias '??'='gh copilot suggest -t shell'
alias 'git?'='gh copilot suggest -t git'
alias 'gh?'='gh copilot suggest -t gh'

# Użycie:
?? find large files
git? squash commits
gh? list my PRs
```


## 🎨 Continue.dev (VS Code)

### Skróty
```
Ctrl+L              Open chat
Ctrl+I              Inline edit
Ctrl+Shift+R        Debug terminal
Ctrl+Shift+L        New chat
```

### Slash Commands
```
/edit code          Edit selection
/comment            Add comments
/test               Generate tests
/fix                Fix errors
/explain            Explain code
/optimize           Optimize code
```

### Context Providers
```
@codebase           Entire codebase
@terminal           Terminal output
@docs               Documentation
@diff               Git diff
@problems           VSCode problems
@folder             Current folder
```

### Przykłady
```
@codebase jak działa auth?
@terminal dlaczego ten błąd?
/test dla funkcji login()
/optimize ten algorytm
```


## 💻 GitHub Copilot (VS Code)

### Autocomplete
```
Tab                 Accept suggestion
Ctrl+Enter          Show alternatives
Alt+]               Next suggestion
Alt+[               Previous suggestion
```

### Chat
```
Ctrl+Shift+I        Open chat
Ctrl+I              Inline chat
```

### Chat Commands
```
/explain            Explain code
/fix                Fix problems
/tests              Generate tests
/doc                Write docs
/simplify           Simplify code
```

### Inline Chat
```
1. Select code
2. Press Ctrl+I
3. Type: "add error handling"
4. Press Enter
```


## 🔥 Quick Wins

### Daily Workflow
```bash
# Start
gh repo view
gh pr list
gh issue list --assignee @me

# Create feature
git checkout -b feature/new
# ... code with Copilot ...

# Commit
git add .
git? "good commit message for user auth"
git commit -m "feat: add user authentication"

# Push & PR
git push -u origin feature/new
gh pr create --fill

# Review
gh pr view
gh pr checks
```

### Terminal Help
```bash
# Nie pamiętasz komendy?
?? compress all jpg to 80% quality
?? find files larger than 100MB
?? kill process on port 3000

# Nie rozumiesz komendy?
gh copilot explain "tar -czf backup.tar.gz /data"
```

### Code Help
```
# W VS Code:
1. Ctrl+L - chat
2. "how to implement JWT auth in Express"
3. Copilot generuje kod
4. Tab - accept
```


## 💡 Pro Tips

### GitHub CLI
- Use `--web` flag to open in browser: `gh pr view --web`
- Use aliases: `gh alias set pv 'pr view'`
- JSON output: `gh pr list --json number,title`

### Copilot CLI
- Be specific: "compress all .jpg files to 80% quality"
- Use context: "in the current directory"
- Combine: `?? ... | sh` to run immediately

### Continue.dev
- Use `@codebase` for architecture questions
- Use `@terminal` after errors
- Use `/edit` for targeted changes

### GitHub Copilot
- Write comments first, let Copilot implement
- Use descriptive function names
- Review generated code always


## 📚 More Info

- Full docs: [[GITHUB-TOOLS]]
- Setup: `make github-setup`
- Status: `make github-status`


**Updated:** 2025-11-21

## 🔗 Backlinks

- [[docs/infra/guide/guide]]
- [[docs/docs]]
- [[INDEX]]