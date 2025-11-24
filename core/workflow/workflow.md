---
tags:
  - #workflow
  - #core
  - #index
  - #folder_note
created: 2025-11-23T19:00:00Z
modified: 2025-11-23T19:00:00Z
author: jakubc
title: "Workflow - Kompletny przewodnik procesów EWW"
owner: jakubc
---

# Workflow - Kompletny przewodnik procesów EWW

Centralne miejsce dla wszystkich workflow, procesów i automatyzacji w projekcie EWW.

## 🎯 Quick Navigation

| Workflow | Status | Opis | Czas setup |
|----------|--------|------|------------|
| **[[infrastructure]]** | 🟢 Active | Hardware + Software stack | Ready |
| **[[git-sync-strategy]]** | 🟡 Planned | Git + LiveSync multi-workstation | ~3h |
| **[[auto-commit-workflow]]** | 🟡 Planned | Automatyczne commity + batching | ~2h |
| **[[dev-workflow]]** | 🟢 Active | Development process | Ready |
| **[[todo-structure]]** | 🟢 Active | Struktura TODO + folder notes | Ready |

## 📚 Pełna dokumentacja

### 0. Infrastructure [[infrastructure]]

**Inventory**: 2 workstations, software stack, network

**Hardware**:
- **GERC** (192.168.0.99) - Intel X99, i7-5960X, 32GB RAM, 2× GTX 980 Ti, jakubc
- **ASUS Z77** (192.168.0.77) - ASUS P8Z77-V, i7-3770K, 16GB RAM, GTX 1660 Ti, karinam

**Software per workstation**:
- Obsidian (vault management, graph view)
- VS Code (development IDE)
- GitHub Copilot (AI assistant - Business seat)
- GitHub Copilot CLI (terminal assistant)
- ChatGPT (GPT-4 - Business seat)
- Codex (⚠️ NEEDS DOCUMENTATION)
- Git (version control)
- Docker (GERC only - CouchDB server)
- BATS (testing framework)

**Network**: 192.168.0.0/24, Gateway 192.168.0.10 (ASUS DSL-N16)

**Status**: 🟢 DOCUMENTED (Codex needs definition)

---

### 1. Git Sync Strategy [[git-sync-strategy]]

**Strategia**: Hybrid Git + Self-hosted LiveSync

**Setup**:
- **2 workstations**: gerc (PRIMARY) + asus-z77 (SECONDARY)
- **2 users**: jakubc + karinam (osobne konta)
- **Real-time sync**: CouchDB LiveSync (1-2s)
- **Backup layer**: Git hourly + GitHub daily

**Komponenty**:
```
REAL-TIME LAYER (LiveSync):
gerc ←→ CouchDB :5984 ←→ asus-z77 (1-2 seconds)

STABLE LAYER (Git):
gerc → GitHub ← asus-z77 (hourly/daily)
```

**Key features**:
- ✅ Real-time collaboration (równoczesna edycja tego samego pliku!)
- ✅ Conflict-free merge (CouchDB auto-merge)
- ✅ Local network (fast, secure, FREE)
- ✅ Triple backup (CouchDB + Git + GitHub)
- ✅ Offline capable (Git fallback)

**Implementation**: ~3h (CouchDB + plugins + testing)

---

### 2. Auto-commit Workflow [[auto-commit-workflow]]

**Cel**: Automatyczne backupy bez ręcznej pracy

**Komponenty**:
1. **Obsidian Git plugin** - hourly vault backup (60 min)
2. **Graph snapshot** - daily graph.json snapshot (systemd timer 00:00)
3. **GitHub backup** - daily push to GitHub (systemd timer 03:00)
4. **Batched commits** - max 18 plików/commit (manual script)

**Schedule**:
```
Continuous → LiveSync (Obsidian plugin, on save)
Hourly     → Vault backup (Obsidian Git, auto 60 min)
00:00      → Graph snapshot (systemd timer)
03:00      → GitHub backup (systemd timer)
Manual     → Batched commit script (on demand)
```

**Scripts**:
- `dev/scripts/graph-snapshot.sh` - Daily graph snapshot
- `dev/scripts/daily-github-backup.sh` - GitHub push
- `dev/scripts/batched-commit.sh` - Batch commits (18 max)

**Implementation**: ~2h (scripts + systemd timers)

---

### 3. Development Workflow [[dev-workflow]]

**Stack**:
- VS Code (primary IDE)
- GitHub Copilot (AI code assistant)
- Git (version control)
- BATS (testing)
- Make (build automation)

**Process**:
```bash
# Daily routine
git pull origin main              # Morning sync
code .                            # Open VS Code
# Work → Copilot suggests → Test → Commit
git commit -m "feat(scope): xyz"  # Conventional commits
git push origin main              # Evening push
```

**Conventional Commits**:
```
feat(scope): New feature
fix(scope): Bug fix
docs(scope): Documentation
chore(scope): Maintenance
test(scope): Tests
```

**Testing**:
```bash
make test         # All tests
bats tests/       # BATS tests
```

**Status**: 🟢 ACTIVE (ready to use)

---

### 4. TODO Structure [[todo-structure]]

**Zasada**: Każdy folder note → `TODO/` directory

**Structure**:
```
area/
├── area.md              # Folder note
└── TODO/
    ├── TODO.md          # Index (linki do zadań)
    └── TODO-daily/
        └── YYYY-MM-DD/
            ├── README.md
            ├── task1.md
            └── task2.md
```

**Process**:
1. Nowy folder note → create `TODO/` obok
2. Zadania → pojedyncze pliki w `TODO-daily/YYYY-MM-DD/`
3. `TODO.md` linkuje do aktywnych zadań
4. Folder note ma sekcję `## ✅ Zadania` z linkiem do `TODO/TODO.md`

**Implemented**: `usr/jakubc/TODO/` (ready)
**TODO**: Rollout to other areas (gerc, asus-z77, docs/infra)

---

## 🚀 Implementation Roadmap

### Phase 1: Git + LiveSync (Week 1) 🟡

**Priority**: HIGH

- [ ] **CouchDB Server** (gerc):
  - [ ] Install Docker + docker-compose
  - [ ] Configure CouchDB container (port 5984)
  - [ ] Create database `eww-vault`
  - [ ] Enable CORS
  - [ ] Configure firewall (allow LAN)
  - [ ] Test: `curl http://192.168.0.99:5984`

- [ ] **LiveSync Plugins** (oba workstations):
  - [ ] Install Self-hosted LiveSync (gerc)
  - [ ] Configure: URL, device name, sync settings
  - [ ] Test real-time sync (edit → save → 1-2s)
  - [ ] Install Self-hosted LiveSync (asus-z77)
  - [ ] Configure same as gerc
  - [ ] Test parallel editing (conflict-free merge!)

- [ ] **Obsidian Git Plugin** (oba):
  - [ ] Install Obsidian Git
  - [ ] Configure: hourly commit, NO auto-pull/push
  - [ ] Test auto-commit (wait 60 min)

**Deliverable**: Real-time collaboration działa!
**Time**: ~3h

---

### Phase 2: Auto-commit Scripts (Week 2) 🟡

**Priority**: MEDIUM

- [ ] **Scripts**:
  - [ ] Create `dev/scripts/graph-snapshot.sh`
  - [ ] Create `dev/scripts/daily-github-backup.sh`
  - [ ] Create `dev/scripts/batched-commit.sh`
  - [ ] Test all scripts manually
  - [ ] Fix permissions: `chmod +x dev/scripts/*.sh`

- [ ] **Systemd Timers**:
  - [ ] Create `~/.config/systemd/user/graph-snapshot.timer`
  - [ ] Create `~/.config/systemd/user/graph-snapshot.service`
  - [ ] Create `~/.config/systemd/user/github-backup.timer`
  - [ ] Create `~/.config/systemd/user/github-backup.service`
  - [ ] Enable: `systemctl --user enable *.timer`
  - [ ] Start: `systemctl --user start *.timer`
  - [ ] Verify: `systemctl --user list-timers`

**Deliverable**: Automatyka działa (hourly + daily)
**Time**: ~2h

---

### Phase 3: TODO Rollout (Week 3) 🟢

**Priority**: LOW

- [ ] **Extend TODO** to other areas:
  - [ ] `docs/infra/hardware/workstations/gerc/TODO/`
  - [ ] `docs/infra/hardware/workstations/asus_z77/TODO/`
  - [ ] `docs/infra/TODO/`
  - [ ] `dev/TODO/`

- [ ] **Documentation**:
  - [ ] Update folder notes (add `## ✅ Zadania` section)
  - [ ] Create `TODO.md` indexes
  - [ ] Document workflow in README

**Deliverable**: TODO structure everywhere
**Time**: ~1h

---

## 📊 Metrics & KPIs

### Git Stats

```bash
# Commits today
git log --since="midnight" --oneline | wc -l

# Auto-commits vs manual
git log --grep="chore(vault)" --oneline | wc -l  # Auto
git log --grep="feat\|fix\|docs" --oneline | wc -l  # Manual

# Contributors
git shortlog -sn --all
```

### LiveSync Health

```bash
# CouchDB status
curl http://192.168.0.99:5984

# Database info
curl http://eww-admin:PASSWORD@192.168.0.99:5984/eww-vault

# Document count
curl http://eww-admin:PASSWORD@192.168.0.99:5984/eww-vault | jq '.doc_count'
```

### Obsidian Stats

- Settings → Self-hosted LiveSync → Status (green = OK)
- Settings → Obsidian Git → Last sync timestamp
- Total files: `find . -name "*.md" | wc -l`

---

## 🔧 Troubleshooting

### LiveSync Issues

**Problem**: Not syncing
**Solution**:
1. Check CouchDB: `curl http://192.168.0.99:5984`
2. Check network: `ping 192.168.0.99`
3. Restart plugin: Settings → Self-hosted LiveSync → Reload
4. Check firewall: `sudo ufw status` (port 5984)
5. Restart CouchDB: `docker restart couchdb-eww`

**Problem**: Conflict markers in files
**Solution**:
1. CouchDB usually auto-merges
2. If conflict appears: resolve manually in Obsidian
3. Save → LiveSync syncs resolved version

### Git Issues

**Problem**: Merge conflict
**Solution**:
```bash
git status
git mergetool  # Or VS Code merge editor
git commit
git push
```

**Problem**: Too many auto-commits
**Solution**:
```bash
# Squash last 24 hourly commits
git rebase -i HEAD~24
# Mark as 'squash'
git push --force-with-lease
```

### Systemd Timers

**Problem**: Timer not running
**Solution**:
```bash
systemctl --user status graph-snapshot.timer
systemctl --user restart graph-snapshot.timer
journalctl --user -u graph-snapshot.service
```

---

## 🎓 Best Practices

### Daily Workflow

1. **Morning**: Open Obsidian → LiveSync auto-sync
2. **Work**: Edit freely → LiveSync real-time sync
3. **Dev**: VS Code → manual commits (meaningful messages)
4. **Evening**: `git push` (stable versions to GitHub)

### Commit Hygiene

- ✅ Frequent small commits (atomic changes)
- ✅ Meaningful messages (Conventional Commits)
- ✅ Test before commit (`make test`)
- ✅ Push daily (backup to GitHub)
- ❌ Don't commit huge files (>10MB)
- ❌ Don't push broken code

### Collaboration

- 🤝 LiveSync handles real-time (Obsidian edits)
- 🤝 Git for stable versions (code, scripts)
- 🤝 Daily sync (ensure GitHub updated)
- 🤝 Communicate big changes (avoid surprises)

---

## 📖 Learning Resources

### Internal Docs

- [[infrastructure]] - Hardware + Software inventory
- [[git-sync-strategy]] - Full Git + LiveSync guide
- [[auto-commit-workflow]] - Automation scripts
- [[dev-workflow]] - Development process
- [[todo-structure]] - TODO management

### External Resources

- [Obsidian Self-hosted LiveSync](https://github.com/vrtmrz/obsidian-livesync)
- [CouchDB Documentation](https://docs.couchdb.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [BATS Testing](https://github.com/bats-core/bats-core)

---

## 🔗 Related Areas

- [[core/config]] - Core configuration
- [[core/systemd/]] - Systemd units
- [[core/VERSION]] - Versioning
- [[graph.md]] - 14 color scheme
- [[docs/infra/software/obsidian/plugins/core/graph-view/graph-view-plan]] - Graph roadmap
- [[dev/bin/]] - Helper scripts
- [[dev/scripts/]] - Automation scripts
- [[Makefile]] - Build targets

---

**Status**: 🟡 IN PROGRESS
**Phase 1**: 🟡 Planned (CouchDB + LiveSync)
**Phase 2**: 🟡 Planned (Auto-commit scripts)
**Phase 3**: 🟢 Partial (TODO structure dla jakubc)

**Owner**: jakubc
**Contributors**: karinam
**Last updated**: 2025-11-23
**Next milestone**: CouchDB setup (Week 1)
