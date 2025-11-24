---
tags:
  - #workflow
  - #development
  - #vscode
  - #git
created: 2025-11-23T19:00:00Z
modified: 2025-11-23T19:00:00Z
author: jakubc
title: "Development Workflow - Proces deweloperski EWW"
owner: jakubc
---

# Development Workflow - Proces deweloperski EWW

Standardowy workflow dla development work w projekcie EWW.

## 🛠️ Development Stack

### Tools (per workstation)

| Tool | Purpose | Config |
|------|---------|--------|
| **VS Code** | Primary IDE | `~/.config/Code/` |
| **GitHub Copilot** | AI code assistant | VS Code extension |
| **Git** | Version control | `~/.gitconfig` |
| **Bash** | Scripting | `/bin/bash` |
| **BATS** | Testing framework | `tests/*.bats` |
| **Make** | Build automation | `Makefile` |
| **Obsidian** | Documentation | Vault management |

### VS Code Extensions

**Required**:
- GitHub Copilot (`GitHub.copilot`)
- GitLens (`eamodio.gitlens`)
- Bash IDE (`mads-hartmann.bash-ide-vscode`)
- Markdown All in One (`yzhang.markdown-all-in-one`)
- YAML (`redhat.vscode-yaml`)

**Optional**:
- Todo Tree (`Gruntfuggly.todo-tree`)
- Error Lens (`usernamehw.errorlens`)
- Better Comments (`aaron-bond.better-comments`)

## 📋 Workflow Process

### 1. Daily Routine

**Morning**:
```bash
cd ~/git/eww

# Pull latest changes
git pull origin main

# Check status
git status

# Open Obsidian (LiveSync auto-sync)
# Open VS Code
code .
```

**During work**:
```bash
# Feature development
git checkout -b feature/new-feature

# Edit files (VS Code + Copilot)
# Test changes
make test  # or bats tests/

# Commit frequently
git add dev/scripts/new-script.sh
git commit -m "feat(scripts): add new-script.sh"
```

**Evening**:
```bash
# Push feature branch
git push origin feature/new-feature

# Or merge to main (if stable)
git checkout main
git merge feature/new-feature
git push origin main
```

### 2. Feature Development

**Process**:
1. **Create branch**: `git checkout -b feature/feature-name`
2. **Develop**: Edit → Test → Commit
3. **Test**: `make test` lub `bats tests/`
4. **Review**: Check diff, validate
5. **Merge**: To main when stable
6. **Push**: `git push origin main`

**Example**:
```bash
# New feature: graph stats generator
git checkout -b feature/graph-stats

# Create script
cat > dev/scripts/generate-graph-stats.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
# Generate graph statistics
echo "Graph stats placeholder"
EOF

chmod +x dev/scripts/generate-graph-stats.sh

# Test
./dev/scripts/generate-graph-stats.sh

# Commit
git add dev/scripts/generate-graph-stats.sh
git commit -m "feat(scripts): add graph stats generator"

# Push
git push origin feature/graph-stats

# Merge to main
git checkout main
git merge feature/graph-stats
git push origin main
```

### 3. Bugfix Workflow

**Process**:
1. **Create bugfix branch**: `git checkout -b fix/bug-description`
2. **Reproduce**: Confirm bug exists
3. **Fix**: Edit code
4. **Test**: Verify fix works
5. **Commit**: `fix(scope): description`
6. **Merge**: Fast to main

**Example**:
```bash
# Bugfix: graph snapshot fails
git checkout -b fix/graph-snapshot-permissions

# Fix script
vim dev/scripts/graph-snapshot.sh
# (add mkdir -p, fix permissions)

# Test
./dev/scripts/graph-snapshot.sh

# Commit
git add dev/scripts/graph-snapshot.sh
git commit -m "fix(scripts): graph-snapshot mkdir -p missing"

# Merge
git checkout main
git merge fix/graph-snapshot-permissions
git push origin main
```

### 4. Documentation Updates

**Markdown editing** (Obsidian preferred):
```bash
# Open in Obsidian
# Edit docs/infra/guide/new-guide.md
# LiveSync auto-sync (real-time)
# Obsidian Git: auto-commit hourly
```

**Large docs** (VS Code for batch edits):
```bash
# Edit multiple files
code docs/

# Commit
git add docs/infra/guide/*.md
git commit -m "docs(guide): update workflow guides"
git push
```

## 🧪 Testing

### BATS Tests

**Run all tests**:
```bash
cd ~/git/eww
bats tests/
```

**Run specific test**:
```bash
bats tests/test_git.bats
```

**Create new test**:
```bash
cat > tests/test_new_feature.bats <<'EOF'
#!/usr/bin/env bats

@test "Feature works correctly" {
  run ./dev/scripts/new-feature.sh
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Success" ]]
}
EOF

chmod +x tests/test_new_feature.bats
bats tests/test_new_feature.bats
```

### Makefile Targets

```bash
# Run tests
make test

# Install tools
make install

# Cleanup
make clean

# Help
make help
```

## 📝 Commit Message Guidelines

### Conventional Commits Format

**Structure**: `type(scope): description`

**Types**:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `chore:` - Maintenance (auto-commits, cleanup)
- `refactor:` - Code refactoring
- `test:` - Tests
- `style:` - Formatting
- `perf:` - Performance

**Scopes**:
- `scripts:` - dev/scripts/
- `bin:` - dev/bin/
- `docs:` - Documentation
- `graph:` - Obsidian graph
- `vault:` - Obsidian vault
- `workflow:` - Workflow files
- `core:` - Core config

**Examples**:
```bash
feat(scripts): add graph-snapshot.sh for daily backups
fix(bin): correct PATH in eww-setup
docs(workflow): create dev-workflow.md guide
chore(vault): daily auto-backup 2025-11-23
refactor(scripts): extract common functions to lib/utils.sh
test(scripts): add BATS tests for graph-snapshot
```

### Commit Best Practices

1. **Commit often** - małe, atomowe zmiany
2. **Meaningful messages** - opisuj "co" i "dlaczego"
3. **One feature per commit** - łatwy revert
4. **Test before commit** - upewnij się że działa
5. **Push daily** - backup na GitHub

## 🤖 GitHub Copilot Usage

### Code Generation

**Prompt w komentarzu**:
```bash
# Generate function to count markdown files in directory
# Args: directory path
# Returns: count of .md files
count_markdown_files() {
    # Copilot suggests implementation here
}
```

**Accept suggestion**: `Tab`
**Next suggestion**: `Alt+]`
**Previous**: `Alt+[`

### Copilot Chat

**Shortcuts**:
- `Ctrl+I` - Inline chat
- `Ctrl+Shift+I` - Chat panel

**Przykłady**:
```
/explain - wyjaśnij kod
/fix - napraw błąd
/tests - generuj testy
/doc - dodaj dokumentację
```

## 🔄 Git Best Practices

### Branch Strategy

**Main branch**: Stable, production-ready code
**Feature branches**: `feature/feature-name`
**Bugfix branches**: `fix/bug-description`
**Experimental**: `experiment/experiment-name`

### Merge Strategy

**Fast-forward** (preferred dla małych zmian):
```bash
git checkout main
git merge feature/small-feature
```

**Merge commit** (dla dużych features):
```bash
git checkout main
git merge --no-ff feature/big-feature
git commit -m "Merge feature/big-feature: add XYZ"
```

**Squash** (cleanup history):
```bash
git checkout main
git merge --squash feature/messy-history
git commit -m "feat(scope): consolidated feature description"
```

### Rebase (advanced)

**Cleanup commits before merge**:
```bash
git checkout feature/my-feature
git rebase -i main
# Squash/reword commits
git push --force-with-lease
```

## 📊 Code Review

### Self-review Checklist

- [ ] Code follows project style (bash conventions)
- [ ] Functions have comments (Polish)
- [ ] Scripts have shebang (`#!/usr/bin/env bash`)
- [ ] Scripts have `set -euo pipefail`
- [ ] Error handling present
- [ ] Tests pass (`make test`)
- [ ] Commit message follows Conventional Commits
- [ ] Documentation updated (if needed)

### Review Process

**Solo development** (jakubc/karinam):
1. Self-review diff: `git diff`
2. Test locally
3. Commit if satisfied

**Collaborative** (optional):
1. Push to GitHub
2. Create PR (via GitHub web UI)
3. Review by other team member
4. Merge after approval

## 🔗 Related

- [[git-sync-strategy]] - Git + LiveSync setup
- [[auto-commit-workflow]] - Automation
- [[core/config]] - Core configuration
- [[Makefile]] - Build targets

---

**Status**: 🟢 ACTIVE
**Owner**: jakubc, karinam
**Tools**: VS Code + GitHub Copilot + Git + BATS
