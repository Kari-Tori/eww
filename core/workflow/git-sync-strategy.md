---
tags:
  - #infra
  - #git
  - #workflow
  - #versioning
  - #sync
  - #obsidian
created: 2025-11-23T18:45:00Z
modified: 2025-11-23T18:45:00Z
author: jakubc
title: "Git Sync Strategy - Multi-workstation setup"
owner: jakubc
---

# Git Sync Strategy - Multi-workstation setup

## 🖥️ Infrastruktura aktualnie

### Workstations (2)

| Hostname | Hardware | User | Lokalizacja repo | IP | Status |
|----------|----------|------|------------------|----|----|
| **gerc** | Intel X99, i7-5960X, 32GB, 2×GTX 980Ti | jakubc | `/home/jakubc/git/eww` | 192.168.0.99 | 🟢 PRIMARY + Live Sync Server |
| **asus-z77** | ASUS Z77 | karinam (osobne konto) | `/home/karinam/git/eww` | 192.168.0.??? | 🟢 SECONDARY + Live Sync Client |

### Software stack (per workstation)

**Każda maszyna ma pełny setup**:
- ✅ **Obsidian** (vault: `/home/{user}/git/eww`)
- ✅ **VS Code** (development IDE)
- ✅ **Codex** (??? - dokumentuj!)
- ✅ **GitHub Copilot** (AI assistant w VS Code + Obsidian?)
- ✅ **Git** (CLI + Obsidian Git plugin)

**Użytkownicy**:
- 👤 **jakubc** (gerc) - full access (dev + vault)
- 👤 **karinam** (asus-z77) - full access (dev + vault)

### Remote (GitHub)
- 🌐 **github.com/Nairecth/eww** (origin)
- 🔒 Branch: `main`
- 👤 Owner: Nairecth (jakubc)

---

## 📜 Historia rozwiązań

### ❌ Rozwiązanie #1: Syncthing + VM Git (deprecated)

**Setup**:
```
192.168.0.88 (Lenovo m710q - Proxmox)
└─ VM: 192.168.0.211 (sb-synapser)
   └─ Projekt: Secondbrain (część)

Syncthing:
├─ gerc (workstation)
├─ asus-z77 (workstation)
├─ tel jakubc
└─ tel karinam

Git: na VM (192.168.0.211)
```

**Problemy**:
- ❌ **Dużo conflict syncs** (4 urządzenia → chaos)
- ❌ Syncthing + Git = konflikt mechanizmów
- ❌ VM jako single point of failure
- ❌ Brak izolacji zmian per user

**Status**: 🔴 NIEAKTUALNE (porzucone)

---

## 🎯 Wymagania nowego rozwiązania

### Must-have
1. ✅ **Git-based** (no Syncthing for code/markdown)
2. ✅ **Multi-user** (jakubc + karinam na osobnych maszynach)
3. ✅ **Conflict resolution** (intelligent merge, nie manual copy)
4. ✅ **Obsidian-friendly** (graph.json sync bez breakingu)
5. ✅ **Free/open-source** (no Obsidian Sync)
6. ✅ **Local-first** (offline work możliwy)

### Nice-to-have
- 🔵 Auto-sync (background, minimal manual git push)
- 🔵 Server centralny (optional, do backupów)
- 🔵 Mobile sync (read-only na telefonach?)
- 🔵 Conflict prevention (locking mechanism?)

---

## 🚀 Strategie (porównanie)

### 📋 Opcja A: Git per-machine + manual sync

**Setup**:
```
gerc (jakubc):
  /home/jakubc/git/eww/.git → origin: github.com/Nairecth/eww

asus-z77 (karinam):
  /home/jakubc/git/eww/.git → origin: github.com/Nairecth/eww

Workflow:
1. jakubc edytuje na gerc → git commit → git push
2. karinam edytuje na asus-z77 → git pull → resolve → git push
3. Konflikty: manual merge (git mergetool)
```

**Pros**:
- ✅ Najprostszy setup (każda maszyna = clone repo)
- ✅ Pełna kontrola git (branches, tags, history)
- ✅ Działa offline
- ✅ GitHub jako backup + remote

**Cons**:
- ❌ **Manual sync required** (git pull/push co sesję)
- ❌ Konflikty przy równoczesnej edycji
- ❌ Wymaga dyscypliny (commit często!)
- ❌ Brak auto-sync (trzeba pamiętać)

**Verdict**: 🟢 **RECOMMENDED** dla małego teamu (2 osoby)

---

### 📋 Opcja B: Git + branches per-user

**Setup**:
```
gerc (jakubc):
  Branch: main (primary development)

asus-z77 (karinam):
  Branch: karinam-work (personal workspace)

Merge workflow:
- karinam: git checkout karinam-work → edit → commit → push
- jakubc: git merge karinam-work → resolve → push main
```

**Pros**:
- ✅ **Izolacja zmian** (każdy user ma branch)
- ✅ Mniej konfliktów na main
- ✅ Cherry-pick możliwy
- ✅ Code review workflow (PR-style local)

**Cons**:
- ❌ Bardziej skomplikowany (branch management)
- ❌ Merge bottleneck (jakubc musi mergeować)
- ❌ Nadmiarowy dla 2 osób?

**Verdict**: 🟡 **OPTIONAL** (jeśli dużo równoczesnej pracy)

---

### 📋 Opcja C: Git + bare repo na serwerze lokalnym

**Setup**:
```
Server (gerc lub dedykowany):
  /srv/git/eww.git (bare repository)

gerc (jakubc):
  origin: /srv/git/eww.git (local)
  remote: github (backup)

asus-z77 (karinam):
  origin: /srv/git/eww.git (local, przez SSH/NFS)
  remote: github (backup)

Auto-sync:
- Cron/systemd: git pull origin main (co 5 min?)
- Cron/systemd: git push github main (daily backup)
```

**Pros**:
- ✅ **Centralny punkt sync** (local network, szybki)
- ✅ GitHub jako backup (nie primary)
- ✅ Auto-pull możliwy (background sync)
- ✅ Konflikt resolution lokalnie (szybko)

**Cons**:
- ❌ Wymaga servera (gerc 24/7 lub dedykowany)
- ❌ Network dependency (LAN must work)
- ❌ Bardziej złożony setup
- ❌ Konflikty dalej możliwe (jeśli równoczesna edycja)

**Verdict**: 🟡 **OPTIONAL** (jeśli gerc działa 24/7)

---

### 📋 Opcja D: Git + Obsidian Git plugin (auto-commit/pull)

**Setup**:
```
Plugin: obsidian-git (community plugin)

Konfiguracja:
- Auto-pull: co 5 minut
- Auto-commit: co 10 minut (lub on file change)
- Auto-push: co 30 minut

gerc + asus-z77:
  Oba: origin → github.com/Nairecth/eww
  Plugin robi: pull → commit → push automatycznie
```

**Pros**:
- ✅ **Fully automatic** (zero manual git commands!)
- ✅ Frequent commits (fine-grained history)
- ✅ Conflict detection + notification
- ✅ Działa w tle (transparent dla użytkownika)

**Cons**:
- ❌ **Dużo micro-commits** (noise w historii)
- ❌ Konflikty dalej możliwe (plugin notification)
- ❌ Obsidian-specific (nie działa poza Obsidian)
- ❌ Może być buggy (community plugin)

**Verdict**: 🟢 **RECOMMENDED** dla Obsidian vault (łatwy start)

---

### 📋 Opcja E: Hybrid - Git manual + Obsidian Git plugin

**Setup**:
```
gerc (jakubc):
  Manual git (dev work: scripts, docs, bin/)
  Obsidian Git plugin (vault: .obsidian/, markdown notes)

asus-z77 (karinam):
  Obsidian Git plugin ONLY (she works only in Obsidian)

Separacja:
- jakubc: full git access (terminal + Obsidian)
- karinam: tylko Obsidian (plugin robi wszystko)
```

**Pros**:
- ✅ **Best of both worlds**
- ✅ jakubc: pełna kontrola (manual git)
- ✅ karinam: zero learning curve (Obsidian robi wszystko)
- ✅ Flexible (można manual override)

**Cons**:
- ❌ Asymetryczny workflow (różne dla users)
- ❌ Możliwe konflikty jeśli jakubc + plugin równocześnie

**Verdict**: 🟢 **RECOMMENDED** (praktyczny kompromis!)

---

### 📋 Opcja F: Hybrid + Self-hosted LiveSync (LOCAL)

**Setup**:
```
CouchDB Server (gerc):
  Docker: couchdb:latest
  Port: 5984 (local network only)
  URL: http://192.168.0.99:5984
  Database: eww-vault

gerc (jakubc):
  Manual git (dev work)
  Obsidian Self-hosted LiveSync plugin → localhost:5984

asus-z77 (karinam):
  Manual git (dev work)
  Obsidian Self-hosted LiveSync plugin → 192.168.0.99:5984

Workflow:
- Git: manual commits dla stable versions (daily/feature complete)
- LiveSync: real-time sync dla Obsidian edits (seconds)
- Best of both: Git history + live collaboration
```

**Pros**:
- ✅ **Real-time sync** (sekundy zamiast minut!)
- ✅ **Local network** (fast, no internet required)
- ✅ **Git backup** (history preserved)
- ✅ **Conflict-free** dla równoczesnej edycji (CouchDB merges)
- ✅ **FREE** (self-hosted, no cloud)
- ✅ **Obsidian native** (plugin community trusted)

**Cons**:
- ❌ Wymaga CouchDB server (gerc must be ON)
- ❌ Bardziej złożony setup (Docker + plugin config)
- ❌ Dual versioning (Git + CouchDB)
- ❌ Storage overhead (CouchDB + Git)

**Verdict**: 🟢 **HIGHLY RECOMMENDED** dla real-time collaboration!

---

## 🏆 Rekomendacja dla eww

### 🎯 Strategia: **Hybrid Git + Self-hosted LiveSync (Opcja F)** 🆕

**Dlaczego F zamiast E?**
- ✅ **Real-time sync** (LiveSync) dla Obsidian work
- ✅ **Git stability** dla dev work (scripts, configs)
- ✅ **Local network** (fast, secure, FREE)
- ✅ **Best of both worlds**: live collaboration + version history

**Setup**:

#### 0. CouchDB Server (gerc - FIRST STEP!)

```bash
# gerc: Install CouchDB via Docker
docker run -d \
  --name couchdb-eww \
  --restart always \
  -p 5984:5984 \
  -e COUCHDB_USER=eww-admin \
  -e COUCHDB_PASSWORD=<STRONG_PASSWORD> \
  -v /home/jakubc/docker/couchdb/data:/opt/couchdb/data \
  -v /home/jakubc/docker/couchdb/config:/opt/couchdb/etc/local.d \
  couchdb:latest

# Verify
curl http://192.168.0.99:5984
# {"couchdb":"Welcome","version":"3.x.x"}

# Create database
curl -X PUT http://eww-admin:<PASSWORD>@192.168.0.99:5984/eww-vault

# Enable CORS (for Obsidian)
curl -X PUT http://eww-admin:<PASSWORD>@192.168.0.99:5984/_node/_local/_config/httpd/enable_cors \
  -d '"true"'
curl -X PUT http://eww-admin:<PASSWORD>@192.168.0.99:5984/_node/_local/_config/cors/origins \
  -d '"*"'
```

**Firewall** (gerc):
```bash
# Allow asus-z77 access to CouchDB
sudo ufw allow from 192.168.0.0/24 to any port 5984 comment 'CouchDB LiveSync'
```

**Systemd** (auto-start CouchDB):
```bash
# Docker compose (preferred)
cat > /home/jakubc/docker/couchdb/docker-compose.yml <<EOF
version: '3'
services:
  couchdb:
    image: couchdb:latest
    container_name: couchdb-eww
    restart: always
    ports:
      - "5984:5984"
    environment:
      - COUCHDB_USER=eww-admin
      - COUCHDB_PASSWORD=<PASSWORD>
    volumes:
      - ./data:/opt/couchdb/data
      - ./config:/opt/couchdb/etc/local.d
EOF

# Start
cd /home/jakubc/docker/couchdb
docker-compose up -d
```

#### 1. gerc (jakubc - PRIMARY)
```bash
# Already setup
cd /home/jakubc/git/eww
git remote -v
# origin  git@github.com:Nairecth/eww.git (fetch/push)

# Software stack:
- Obsidian (vault: /home/jakubc/git/eww)
- VS Code (development)
- Codex
- GitHub Copilot (AI assistant)
- Git + Obsidian Git plugin

# Install plugins (2):
# 1. Self-hosted LiveSync (PRIMARY - real-time)
# Settings → Community plugins → "Self-hosted LiveSync"
# Config:
  - Remote Database URL: http://192.168.0.99:5984/eww-vault
  - Username: eww-admin
  - Password: <PASSWORD>
  - Device name: gerc-jakubc
  - LiveSync: Enable
  - Sync on Save: Enable
  - Sync on Start: Enable

# 2. Obsidian Git (BACKUP - periodic)
# Settings → Community plugins → "Obsidian Git"
# Config:
  - Auto pull: DISABLED (LiveSync handles)
  - Auto commit: 60 min (hourly backup: "git: jakubc backup {{date}}")
  - Auto push: DISABLED (manual push only)
  - Commit author: jakubc <jakub@eww.local>
```

**Workflow jakubc**:
- **VS Code work** (scripts, bin, Makefile, Python, Bash): **manual git**
  ```bash
  git add dev/scripts/new-script.sh
  git commit -m "feat(scripts): add new-script.sh"
  git push  # Push to GitHub (stable versions)
  ```

- **Obsidian work** (notes, docs, graph config): **LiveSync (real-time!)**
  - Edit → Save → **instant sync** to CouchDB → karinam sees in seconds!
  - Manual git commit: Ctrl+P → "Obsidian Git: Commit" (hourly auto-backup)
  - Git push: manual (end of day or feature complete)

- **GitHub Copilot**: aktywny w VS Code + Obsidian (AI suggestions)

**Key insight**: LiveSync = real-time, Git = stable checkpoints!

#### 2. asus-z77 (karinam - SECONDARY)

```bash
# Setup na asus-z77 (osobny user: karinam)
su - karinam
mkdir -p /home/karinam/git
cd /home/karinam/git
git clone git@github.com:Nairecth/eww.git
cd eww

# Software stack (identical to gerc):
- Obsidian (vault: /home/karinam/git/eww)
- VS Code (development)
- Codex
- GitHub Copilot (AI assistant)
- Git + Obsidian Git plugin

# Git config (karinam identity)
git config user.name "karinam"
git config user.email "karina@eww.local"

# Install plugins (2):
# 1. Self-hosted LiveSync (PRIMARY - real-time)
# Settings → Community plugins → "Self-hosted LiveSync"
# Config:
  - Remote Database URL: http://192.168.0.99:5984/eww-vault
  - Username: eww-admin
  - Password: <PASSWORD>
  - Device name: asus-karinam
  - LiveSync: Enable
  - Sync on Save: Enable
  - Sync on Start: Enable

# 2. Obsidian Git (BACKUP - periodic)
# Settings → Community plugins → "Obsidian Git"
# Config:
  - Auto pull: DISABLED (LiveSync handles)
  - Auto commit: 60 min (hourly: "git: karinam backup {{date}}")
  - Auto push: DISABLED (manual only)
  - Commit author: karinam <karina@eww.local>
```

**Workflow karinam**:
- **VS Code work** (scripts, docs, edits): **manual git** (same as jakubc)
  ```bash
  git add docs/new-document.md
  git commit -m "docs: add new-document.md"
  git push  # Push to GitHub
  ```

- **Obsidian work** (notes, browsing, graph): **LiveSync (real-time!)**
  - Edit → Save → **instant sync** to CouchDB → jakubc sees in seconds!
  - Manual git commit: Ctrl+P → "Obsidian Git: Commit" (hourly auto-backup)
  - Git push: manual (end of day)

- **GitHub Copilot**: aktywny w VS Code + Obsidian (AI suggestions)

- **Konflikty**:
  - **LiveSync**: CouchDB auto-merge (CRDT-like, conflict-free!)
  - **Git**: Manual resolve w VS Code (rzadko, bo LiveSync handles most)

#### 3. Conflict prevention

**Git config (per-user, per-machine)**:
```bash
# gerc (/home/jakubc/git/eww):
cd /home/jakubc/git/eww
git config user.name "jakubc"
git config user.email "jakub@eww.local"

# asus-z77 (/home/karinam/git/eww):
cd /home/karinam/git/eww
git config user.name "karinam"
git config user.email "karina@eww.local"

# Auto-merge strategy (favor newer for .obsidian/workspace.json)
cat >> .git/config <<EOF
[merge]
    conflictstyle = diff3
    tool = vimdiff

[merge "obsidian-workspace"]
    name = Favor newer workspace
    driver = cp %B %A
EOF

# .gitattributes (w repo root)
cat >> .gitattributes <<EOF
# Obsidian workspace - favor theirs (newer)
.obsidian/workspace.json merge=obsidian-workspace
.obsidian/workspace-mobile.json merge=obsidian-workspace

# Graph config - manual merge (ważny!)
.obsidian/graph.json merge=diff3

# Auto-merge markdown (usually safe)
*.md merge=union
EOF
```

#### 4. Daily backup to GitHub

**Systemd timer na gerc** (ensure GitHub ma wszystko):
```bash
# ~/.config/systemd/user/eww-github-backup.service
[Unit]
Description=EWW GitHub Backup

[Service]
Type=oneshot
WorkingDirectory=/home/jakubc/git/eww
ExecStart=/usr/bin/git push origin main --force-with-lease

# ~/.config/systemd/user/eww-github-backup.timer
[Unit]
Description=Daily EWW GitHub Backup

[Timer]
OnCalendar=daily
OnCalendar=03:00:00
Persistent=true

[Install]
WantedBy=timers.target

# Enable
systemctl --user enable eww-github-backup.timer
systemctl --user start eww-github-backup.timer
```

---

## 💻 Development Tools (per workstation)

### Software stack details

| Tool | Purpose | Version | Config location |
|------|---------|---------|----------------|
| **Obsidian** | Vault management, graph view, notes | Latest | `/home/{user}/git/eww/.obsidian/` |
| **VS Code** | Development IDE (Bash, Python, Markdown) | Latest | `/home/{user}/.config/Code/` |
| **Codex** | ??? (document purpose!) | ??? | ??? |
| **GitHub Copilot** | AI code/text suggestions | Latest | VS Code extension + Obsidian plugin? |
| **Git** | Version control | 2.x+ | `/home/{user}/.gitconfig` |
| **Obsidian Git** | Auto-sync plugin | Latest | `.obsidian/plugins/obsidian-git/` |

### GitHub Copilot setup

**VS Code**:
```bash
# Install extension
code --install-extension GitHub.copilot

# Login with GitHub account (jakubc / karinam?)
# Settings → GitHub Copilot → Enable
```

**Obsidian** (if plugin exists):
```
Settings → Community plugins → Browse → "GitHub Copilot"
# Alternative: use Copilot Chat for vault queries?
```

### Codex

**TODO**: Document what Codex is and how it's used!
- Installation method?
- Purpose in workflow?
- Integration with eww project?

---

## 🛡️ Backup strategy

### Layers:

1. **GitHub** (primary remote)
   - Push daily (auto z gerc)
   - Pull before work (oba kompy)

2. **Local snapshots** (gerc)
   - `.obsidian/graph-versions/` (już mamy w planie)
   - Daily snapshot graph.json

3. **External backup** (optional)
   - Syncthing do `/backup/eww/` (read-only sync z gerc)
   - Nie sync z powrotem! (one-way tylko)

---

## 📝 Workflow Examples

### Scenario 1: jakubc pracuje sam

```bash
# gerc (/home/jakubc/git/eww)

# VS Code work (scripts, code):
code dev/scripts/new-feature.sh
# Edit... GitHub Copilot suggests code
git add dev/scripts/new-feature.sh
git commit -m "feat(scripts): add new-feature.sh"
git push  # Git: stable version to GitHub

# Obsidian work (notes, docs):
# Open Obsidian → edit markdown → SAVE
# LiveSync: INSTANT sync to CouchDB (1-2 seconds!)
# Git: hourly auto-commit (backup)
# Manual git push: end of day
```

### Scenario 2: karinam pracuje sama

```bash
# asus-z77 (/home/karinam/git/eww)

# VS Code work (docs, edits):
code docs/new-guide.md
# Edit... GitHub Copilot suggests text
git add docs/new-guide.md
git commit -m "docs: add new-guide.md"
git push  # Git: to GitHub

# Obsidian work (notes, browsing):
# Open Obsidian → browse graph, edit notes → SAVE
# LiveSync: INSTANT sync to CouchDB
# jakubc sees changes on gerc in 1-2 seconds!
# Git: hourly auto-commit (backup)
```

### Scenario 3: Oboje pracują RÓWNOCZEŚNIE (real-time collaboration!) 🔥

**jakubc (gerc)** - edytuje `docs/infra/guide/setup.md`:
```bash
# Obsidian (gerc)
# Edit docs/infra/guide/setup.md → add section "Installation"
# SAVE → LiveSync: 1 second → CouchDB

# Git (end of session):
git pull  # Get karinam's VS Code work
git add .
git commit -m "docs: add setup guide installation section"
git push
```

**karinam (asus-z77)** - edytuje TEN SAM PLIK równocześnie!:
```bash
# Obsidian (asus-z77)
# Edit docs/infra/guide/setup.md → add section "Configuration"
# SAVE → LiveSync: 1 second → CouchDB
# CouchDB: AUTO-MERGE obu zmian (conflict-free!)
# jakubc widzi "Configuration" section w 2 sekundy!

# Git (end of session):
git pull  # Get jakubc's changes
git add .
git commit -m "docs: add setup guide configuration section"
git push
```

**Rezultat** (MAGIC!):
- ✅ **LiveSync**: Oba sections w pliku (auto-merged!)
- ✅ **No conflict**: CouchDB obsłużył merge
- ✅ **Real-time**: Oboje widzą zmiany w sekundach
- ✅ **Git**: Periodic commits (hourly) + manual push (stable versions)

**Konflikt** (rzadki przypadek - różne sekcje tego samego akapitu):
1. **LiveSync**: CouchDB tworzy conflict marker
2. **Obsidian**: Pokazuje notification "Conflict detected"
3. **Resolve**: Ręcznie w Obsidian (choose version lub merge)
4. **Save**: LiveSync sync resolved version---

## 🚨 Common Issues & Solutions

### Problem: "conflict in graph.json"

**LiveSync era**: RARELY happens (CouchDB merges automatically!)

**If Git conflict** (manual push/pull):
```bash
# Favor newer (usually safe)
git checkout --theirs .obsidian/graph.json
git add .obsidian/graph.json

# OR manual merge (preserve physics params)
```### Problem: "diverged branches"
**Solution**:
```bash
git pull --rebase origin main
# Resolve conflicts
git rebase --continue
git push
```

### Problem: "Obsidian Git plugin failed"

**Solution** (Git is backup, LiveSync is primary!):
1. Check LiveSync: Settings → Self-hosted LiveSync → Status (should be green)
2. If LiveSync works: Git can wait (it's hourly backup only)
3. Manual git: `git commit -am "manual backup" && git push`
4. Restart Obsidian if needed

### Problem: "LiveSync not syncing"

**Solution**:
1. Check CouchDB: `curl http://192.168.0.99:5984` (should respond)
2. Check network: `ping 192.168.0.99` (from asus-z77)
3. Check firewall: `sudo ufw status` (port 5984 open?)
4. Restart CouchDB: `docker restart couchdb-eww`
5. Restart Obsidian plugin: Settings → Self-hosted LiveSync → Reload
6. Fallback: Use Git (manual commit/push/pull)

### Problem: "Too many micro-commits"
**Solution**:
```bash
# Squash last 10 commits
git rebase -i HEAD~10
# Mark commits as 'squash'
# Save → force push: git push --force-with-lease
```

---

## 📊 Summary Table

| Feature | Manual Git | Obsidian Git Plugin | Hybrid Git | **Hybrid + LiveSync** ⭐ |
|---------|-----------|-------------------|---------------------|----------------------|
| **Real-time sync** | ❌ No | ❌ Minutes | ❌ Minutes | ✅ **SECONDS!** |
| **Automatyzacja** | ❌ Manual | ✅ Auto | 🟡 Partial | ✅ Auto (LiveSync) + Manual (Git) |
| **Kontrola** | ✅ Full | ❌ Limited | ✅ Full | ✅ Full (dual: LiveSync + Git) |
| **Learning curve** | 🔴 High | 🟢 Low | 🟡 Medium | 🟡 Medium (CouchDB setup) |
| **Konflikt handling** | ✅ Manual | 🟡 Notification | ✅ VS Code | ✅ **Auto-merge** (CouchDB) |
| **Offline work** | ✅ Yes | ✅ Yes | ✅ Yes | 🟡 Limited (LiveSync needs gerc ON) |
| **Multi-user** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ **Real-time collaboration!** |
| **Obsidian-friendly** | 🟡 Manual | ✅ Native | ✅ Native | ✅ **PERFECT** (LiveSync native) |
| **VS Code integration** | ✅ Native | ❌ No | ✅ Native | ✅ Native (Git for code) |
| **GitHub Copilot** | ✅ Works | ✅ Works | ✅ Works | ✅ Works |
| **Codex support** | ✅ Works | ??? | ✅ Works | ✅ Works |
| **Network dependency** | ❌ No | 🟡 GitHub | 🟡 GitHub | 🟡 **Local LAN** (gerc must be ON) |
| **Storage** | Git only | Git only | Git only | **Dual: CouchDB + Git** |
| **Cost** | Free | Free | Free | **Free** (self-hosted!) |

---

## 🎯 Next Steps

### Architecture diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    HYBRID GIT + LIVESYNC                     │
└─────────────────────────────────────────────────────────────┘

REAL-TIME LAYER (LiveSync - seconds):
┌──────────────┐    LiveSync     ┌──────────────┐
│ gerc         │◄───────────────►│ CouchDB      │
│ (jakubc)     │    1-2 sec      │ :5984        │
│ Obsidian     │                 │ (on gerc)    │
└──────────────┘                 └──────────────┘
                                        ▲
                                        │ LiveSync
                                        │ 1-2 sec
                                        ▼
                                 ┌──────────────┐
                                 │ asus-z77     │
                                 │ (karinam)    │
                                 │ Obsidian     │
                                 └──────────────┘

STABLE VERSION LAYER (Git - hourly/daily):
┌──────────────┐                 ┌──────────────┐
│ gerc         │    git push     │ GitHub       │
│ /home/jakubc │────────────────►│ Nairecth/eww │
│ /git/eww     │    (manual)     │ (backup)     │
└──────────────┘                 └──────────────┘
                                        ▲
                                        │ git pull
                                        │ git push
                                        │
                                 ┌──────────────┐
                                 │ asus-z77     │
                                 │ /home/karinam│
                                 │ /git/eww     │
                                 └──────────────┘

WORKFLOW:
- Edit in Obsidian → LiveSync (instant) → CouchDB → other machine
- Hourly: Obsidian Git auto-commit (backup to Git)
- Daily/feature: manual git push → GitHub (stable versions)
- VS Code work → manual git commit/push (code, scripts)
```

### Setup checklist:

- [ ] **CouchDB Server (gerc)** - FIRST!:
  - [ ] Install Docker + docker-compose
  - [ ] Create `/home/jakubc/docker/couchdb/docker-compose.yml`
  - [ ] Start: `docker-compose up -d`
  - [ ] Verify: `curl http://192.168.0.99:5984`
  - [ ] Create database: `eww-vault`
  - [ ] Enable CORS (for Obsidian)
  - [ ] Configure firewall: allow port 5984 from LAN
  - [ ] Test from asus-z77: `curl http://192.168.0.99:5984`

- [ ] **gerc (jakubc)** - PRIMARY workstation:
  - [x] Git repo działa (`/home/jakubc/git/eww`)
  - [x] VS Code installed + GitHub Copilot extension
  - [ ] Codex installed + configured (TODO: document!)
  - [x] Obsidian installed (vault: `/home/jakubc/git/eww`)
  - [ ] Install **Self-hosted LiveSync** plugin (PRIMARY)
  - [ ] Config LiveSync: URL=http://localhost:5984/eww-vault, device=gerc-jakubc
  - [ ] Test LiveSync: Edit note → check CouchDB (should see document)
  - [ ] Install **Obsidian Git** plugin (BACKUP)
  - [ ] Config Git plugin: auto-commit hourly, NO auto-pull/push
  - [ ] Git config: `user.name="jakubc"`, `user.email="jakub@eww.local"`
  - [ ] Test VS Code: commit → push → check GitHub
  - [ ] Test LiveSync: edit → save → check asus-z77 (when ready)

- [ ] **asus-z77 (karinam)** - SECONDARY workstation:
  - [ ] Create user: `sudo adduser karinam`
  - [ ] Clone repo: `su - karinam && git clone git@github.com:Nairecth/eww.git /home/karinam/git/eww`
  - [ ] Setup SSH key dla GitHub (karinam personal account lub shared?)
  - [ ] Install VS Code + GitHub Copilot extension
  - [ ] Install Codex + configure (TODO: document!)
  - [ ] Install Obsidian (vault: `/home/karinam/git/eww`)
  - [ ] Install **Self-hosted LiveSync** plugin (PRIMARY)
  - [ ] Config LiveSync: URL=http://192.168.0.99:5984/eww-vault, device=asus-karinam
  - [ ] Test LiveSync: Edit note → check if synced to gerc (jakubc should see!)
  - [ ] Install **Obsidian Git** plugin (BACKUP)
  - [ ] Config Git plugin: auto-commit hourly, NO auto-pull/push
  - [ ] Git config: `user.name="karinam"`, `user.email="karina@eww.local"`
  - [ ] Setup SSH key (karinam GitHub account - osobne konto!)
  - [ ] Test VS Code: commit → push → check GitHub
  - [ ] Test real-time sync: edit on asus-z77 → jakubc sees on gerc in 1-2s!

- [ ] **Conflict prevention**:
  - [ ] Add `.gitattributes` (merge strategies dla graph.json, workspace.json)
  - [ ] Test LiveSync auto-merge (both edit same file simultaneously)
  - [ ] Document LiveSync conflict resolution (Obsidian UI)
  - [ ] Test Git conflict (rare, manual push/pull)

- [ ] **Backup strategy** (triple redundancy!):
  - [ ] **Layer 1**: CouchDB (real-time, on gerc)
  - [ ] **Layer 2**: Git local (hourly auto-commit via Obsidian Git)
  - [ ] **Layer 3**: GitHub remote (manual push, stable versions)
  - [ ] Systemd timer: daily CouchDB backup (`docker exec couchdb-eww curl ...`)
  - [ ] Local snapshots: `.obsidian/graph-versions/` (daily)
  - [ ] Test recovery: CouchDB down → Git works, LiveSync down → Git fallback- [ ] **Documentation**:
  - [x] git-sync-strategy.md (this file - COMPLETE!)
  - [ ] README-karinam.md (workflow guide dla karinam)
  - [ ] CouchDB-setup.md (installation + configuration)
  - [ ] Document Codex setup + usage
  - [ ] Update [[gerc]] with CouchDB server role
  - [ ] Create [[asus-z77]] workstation doc
  - [ ] LiveSync troubleshooting guide

---

**Status**: 🟢 READY TO IMPLEMENT
**Owner**: jakubc
**Review needed**: karinam (approval + testing real-time sync)
**Implementation time**:
- CouchDB setup: ~1h (Docker + config)
- LiveSync plugin setup: ~30 min (oba kompy)
- Testing: ~1h (parallel editing, conflict scenarios)
- **Total**: ~2.5-3h

**Benefits**:
- 🚀 **Real-time collaboration** (sekundy zamiast minut!)
- 🔒 **Local network** (fast, secure, FREE)
- 💾 **Triple backup** (CouchDB + Git + GitHub)
- 🤝 **Conflict-free** (CouchDB auto-merge)
- 📊 **Best UX** dla Obsidian multi-user

**Powiązane**:
- [[graph-view-plan]] - Auto-commit dla graph.json (now with LiveSync!)
- [[gerc]] - Primary workstation + CouchDB server
- [[docs/infra/hardware/workstations/asus_z77/]] - Secondary workstation (TODO: create)
- CouchDB documentation: https://docs.couchdb.org/
- Self-hosted LiveSync plugin: https://github.com/vrtmrz/obsidian-livesync
