---
tags:
  - #workflow
  - #core
  - #automation
  - #folder_note
created: 2025-11-23T19:00:00Z
modified: 2025-11-23T19:00:00Z
author: jakubc
title: "Workflow - Procesy i automatyzacja EWW"
owner: jakubc
---

# Workflow - Kompletny przewodnik procesów EWW

Centralne miejsce dla wszystkich workflow, procesów i automatyzacji w projekcie EWW.

> 🔥 **START HERE**: [[workflow.md]] - Kompletny przewodnik z roadmap, KPI, troubleshooting

## 📚 Dokumenty

### 🏗️ Infrastructure
- **[[infrastructure]]** - Sprzęt i oprogramowanie
  - Hardware inventory (GERC, ASUS Z77)
  - Network configuration (IPs, topology)
  - Software stack (Obsidian, VS Code, Copilot, ChatGPT, Codex)
  - Licenses & seats (GitHub Copilot Business, ChatGPT Business)
  - Installation checklists
  - Troubleshooting guides

### 🔄 Git & Sync
- **[[git-sync-strategy]]** - Strategia synchronizacji Git + Self-hosted LiveSync dla multi-workstation
  - 2 workstations (gerc + asus-z77)
  - 2 users (jakubc + karinam)
  - Real-time collaboration (CouchDB LiveSync)
  - Git backup layer (GitHub)

### 📋 Task Management
- **[[todo-structure]]** - Struktura TODO i folder notes
  - Zasada folder_note ↔ TODO
  - Datowane katalogi zadań
  - Single-file per task

### 🤖 Auto-commit
- **[[auto-commit-workflow]]** - Automatyzacja commitów (PLANNED)
  - Daily auto-commit z graph.json
  - Batching (18 plików/commit)
  - Systemd timers

### 📊 Graph Management
- **[[graph-workflow]]** - Workflow zarządzania grafem Obsidian (PLANNED)
  - Versjonowanie graph.json
  - Color scheme sync (14 kolorów)
  - Stats generation

### 🔧 Development
- **[[dev-workflow]]** - Workflow deweloperski (PLANNED)
  - VS Code + GitHub Copilot
  - Conventional Commits
  - Testing (BATS)
  - Code review

## 🎯 Główne zasady workflow

### 1. Git Workflow (Hybrid + LiveSync)

**Real-time layer** (LiveSync - sekundy):
```
gerc (jakubc) ←→ CouchDB :5984 ←→ asus-z77 (karinam)
```

**Stable layer** (Git - hourly/daily):
```
gerc → GitHub ← asus-z77
```

**Workflow**:
- **Obsidian edits**: LiveSync (auto, 1-2s sync)
- **VS Code work**: Manual git (commit/push)
- **Backup**: Git hourly auto-commit + daily push

### 2. Folder Notes + TODO

**Każdy folder note** ma przypisany `TODO/`:
```
area/
├── area.md           # Folder note
└── TODO/
    ├── TODO.md       # Index
    └── TODO-daily/   # Daily tasks
```

**Process**:
1. Nowy folder note → create `TODO/` structure
2. Tasks → pojedyncze pliki w `TODO-daily/YYYY-MM-DD/`
3. Index w `TODO.md` linkuje do aktywnych zadań

### 3. Conventional Commits

**Format**: `type(scope): description`

**Types**:
- `feat:` - nowa funkcjonalność
- `fix:` - bugfix
- `docs:` - dokumentacja
- `chore:` - maintenance (auto-commits, cleanup)
- `refactor:` - refactoring kodu
- `test:` - testy

**Examples**:
```bash
git commit -m "feat(scripts): add graph-snapshot.sh"
git commit -m "docs(workflow): create git-sync-strategy.md"
git commit -m "chore(graph): daily auto-commit 2025-11-23"
```

### 4. Auto-commit Strategy

**Obsidian Git plugin**:
- Auto-commit: 60 min (hourly backup)
- Message: `chore(vault): {user} backup {date}`
- NO auto-pull/push (LiveSync handles)

**Manual git**:
- VS Code work: commit per feature
- End of day: `git push` (stable versions to GitHub)

**Daily systemd timer** (gerc):
- 03:00 - backup GitHub push
- 00:00 - graph.json snapshot

### 5. Development Workflow

**Setup per workstation**:
- Obsidian (vault management)
- VS Code (development IDE)
- GitHub Copilot (AI assistance)
- Git + Obsidian Git plugin
- Self-hosted LiveSync plugin

**Daily routine**:
1. Morning: Open Obsidian → LiveSync auto-pull
2. Work: Edit files → LiveSync auto-sync (real-time)
3. Dev work: VS Code → manual git commit/push
4. Evening: Manual `git push` (stable versions)

## 🛠️ Tools & Automation

### Installed
- ✅ Git (version control)
- ✅ Obsidian (vault + graph)
- ✅ VS Code (IDE)
- ✅ GitHub Copilot (AI)
- ✅ Docker (CouchDB hosting)

### Planned
- [ ] CouchDB (LiveSync server on gerc)
- [ ] Self-hosted LiveSync plugin (oba kompy)
- [ ] Systemd timers (auto-backup)
- [ ] Graph snapshot script
- [ ] Stats generation script

## 📚 Related Documentation

### Core
- `[[core/config]]` - Konfiguracja core
- `[[core/systemd]]` - Systemd units
- `[[core/VERSION]]` - Versioning

### Infra
- `[[docs/infra/hardware/workstations/gerc/]]` - Primary workstation + CouchDB server
- `[[docs/infra/hardware/workstations/asus_z77/]]` - Secondary workstation (TODO)

### Graph
- `[[docs/infra/software/obsidian/plugins/core/graph-view/graph-view-plan]]` - Graph roadmap
- `[[graph.md]]` - 14 color scheme definition

### Development
- `[[dev/bin/]]` - Helper scripts
- `[[dev/scripts/]]` - Automation scripts
- `[[Makefile]]` - Build automation

## 🚀 Quick Start

### New user onboarding

1. **Clone repo**:
   ```bash
   git clone git@github.com:Nairecth/eww.git ~/git/eww
   cd ~/git/eww
   ```

2. **Setup Git identity**:
   ```bash
   git config user.name "username"
   git config user.email "user@eww.local"
   ```

3. **Install Obsidian + plugins**:
   - Obsidian (download from obsidian.md)
   - Self-hosted LiveSync (Community plugins)
   - Obsidian Git (Community plugins)

4. **Configure LiveSync**:
   - URL: `http://192.168.0.99:5984/eww-vault`
   - Device name: `{hostname}-{username}`
   - Enable: Sync on Save, Sync on Start

5. **Test workflow**:
   - Edit markdown in Obsidian → check LiveSync (1-2s)
   - VS Code edit → manual git commit/push

### Daily workflow

**Morning**:
```bash
# Obsidian: auto-pull via LiveSync (automatic)
# Check status
git status
```

**During work**:
```bash
# Obsidian: edit → save → LiveSync auto-sync (real-time)
# VS Code: edit code → commit → push
git add dev/scripts/new-script.sh
git commit -m "feat(scripts): add new-script.sh"
git push
```

**Evening**:
```bash
# Push stable versions
git add .
git commit -m "chore(vault): end of day backup"
git push
```

## 📊 Metrics & Monitoring

### Git stats
```bash
# Commits today
git log --since="midnight" --oneline

# Contributors
git shortlog -sn --all

# File changes
git diff --stat
```

### LiveSync health
```bash
# Check CouchDB
curl http://192.168.0.99:5984

# Check database
curl http://eww-admin:PASSWORD@192.168.0.99:5984/eww-vault
```

### Obsidian stats
- Settings → Self-hosted LiveSync → Status
- Settings → Obsidian Git → Last sync

## 🔧 Troubleshooting

### LiveSync not syncing
1. Check CouchDB: `curl http://192.168.0.99:5984`
2. Check network: `ping 192.168.0.99`
3. Restart plugin: Obsidian → Reload
4. Fallback: Manual git pull/push

### Git conflicts
1. LiveSync usually prevents conflicts (auto-merge)
2. If Git conflict: VS Code merge editor
3. Resolve → commit → push

### Performance issues
1. Check graph size: `find . -name "*.md" | wc -l`
2. Optimize graph filters (hide logs/archives)
3. Reduce LiveSync frequency (if needed)

---

**Status**: 🟢 ACTIVE
**Owner**: jakubc
**Last updated**: 2025-11-23
**Next review**: Po implementacji LiveSync (~1 tydzień)
