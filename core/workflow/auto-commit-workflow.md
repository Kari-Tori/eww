---
version: 0.0.1
tags:
  - #workflow
  - #git
  - #automation
  - #commits
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "Auto-commit Workflow - Automatyzacja commitów"
owner: jakubc
---

# Auto-commit Workflow - Automatyzacja commitów

Strategia automatycznych commitów dla projektu EWW z batchingiem i limitami.

## 🎯 Cele

- ✅ Automatyczne backupy vault (Obsidian)
- ✅ Ograniczenie liczby plików/commit (max 18)
- ✅ Periodic commits (hourly dla Obsidian, daily dla snapshots)
- ✅ Conventional commit messages
- ✅ Systemd timers (Linux automation)

## 📦 Komponenty

### 1. Obsidian Git Plugin (hourly backup)

**Config** (oba workstations):
```yaml
Auto pull: DISABLED (LiveSync handles real-time)
Auto commit: 60 minutes
Auto push: DISABLED (manual only)
Commit message template: "chore(vault): {username} backup {date}"
Commit author: {username} <{email}>
```

**Obsidian Settings** → Community plugins → Obsidian Git:
- Pull on startup: NO
- Auto pull interval: 0 (disabled)
- Auto commit interval: 60 (minutes)
- Auto push interval: 0 (disabled)
- Commit message: `chore(vault): {{hostname}} backup {{date}}`

### 2. Daily Graph Snapshot (systemd timer)

**Script**: `dev/scripts/graph-snapshot.sh`

```bash
#!/usr/bin/env bash
# Auto-snapshot graph.json daily

set -euo pipefail

readonly GRAPH_FILE=".obsidian/graph.json"
readonly VERSIONS_DIR=".obsidian/graph-versions"
readonly TODAY=$(date +%Y-%m-%d)
readonly SNAPSHOT="$VERSIONS_DIR/graph-$TODAY.json"

mkdir -p "$VERSIONS_DIR"

if [[ ! -f "$SNAPSHOT" ]]; then
    cp "$GRAPH_FILE" "$SNAPSHOT"
    echo "✅ Graph snapshot: $SNAPSHOT"

    git add "$SNAPSHOT"
    git commit -m "chore(graph): daily snapshot $TODAY" || true
else
    echo "ℹ️  Snapshot już istnieje: $SNAPSHOT"
fi

# Cleanup: zachowaj ostatnie 30 dni
find "$VERSIONS_DIR" -name "graph-*.json" -mtime +30 -delete
```

**Systemd timer**: `~/.config/systemd/user/graph-snapshot.timer`

```ini
[Unit]
Description=Daily Graph Snapshot Timer

[Timer]
OnCalendar=daily
OnCalendar=00:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

**Service**: `~/.config/systemd/user/graph-snapshot.service`

```ini
[Unit]
Description=Daily Graph Snapshot

[Service]
Type=oneshot
WorkingDirectory=/home/%u/git/eww
ExecStart=/home/%u/git/eww/dev/scripts/graph-snapshot.sh
```

**Enable**:
```bash
systemctl --user enable graph-snapshot.timer
systemctl --user start graph-snapshot.timer
systemctl --user status graph-snapshot.timer
```

### 3. Daily GitHub Backup (systemd timer)

**Purpose**: Ensure GitHub ma wszystkie zmiany (backup layer)

**Script**: `dev/scripts/daily-github-backup.sh`

```bash
#!/usr/bin/env bash
# Daily push to GitHub

set -euo pipefail

cd /home/jakubc/git/eww

# Check if changes exist
if git diff --quiet && git diff --cached --quiet; then
    echo "ℹ️  Brak zmian do push"
    exit 0
fi

# Commit any uncommitted changes
if ! git diff --quiet; then
    git add .
    git commit -m "chore(vault): daily auto-backup $(date +%Y-%m-%d)" || true
fi

# Push to GitHub
git push origin main --force-with-lease

echo "✅ GitHub backup complete: $(date)"
```

**Systemd timer**: `~/.config/systemd/user/github-backup.timer`

```ini
[Unit]
Description=Daily GitHub Backup Timer

[Timer]
OnCalendar=daily
OnCalendar=03:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

**Service**: `~/.config/systemd/user/github-backup.service`

```ini
[Unit]
Description=Daily GitHub Backup

[Service]
Type=oneshot
WorkingDirectory=/home/%u/git/eww
ExecStart=/home/%u/git/eww/dev/scripts/daily-github-backup.sh
```

### 4. Batched Commits (18 files max)

**Script**: `dev/scripts/batched-commit.sh`

```bash
#!/usr/bin/env bash
# Commit files in batches (max 18 per commit)

set -euo pipefail

readonly MAX_FILES_PER_COMMIT=18
readonly COMMIT_DELAY=0.5  # seconds between commits

cd /home/jakubc/git/eww

# Get list of staged/modified files
mapfile -t FILES < <(git diff --name-only --cached 2>/dev/null || git diff --name-only)
TOTAL=${#FILES[@]}

if [[ $TOTAL -eq 0 ]]; then
    echo "ℹ️  No files to commit"
    exit 0
fi

echo "📦 Total files: $TOTAL"

# If ≤18 files - single commit
if [[ $TOTAL -le $MAX_FILES_PER_COMMIT ]]; then
    git add .
    git commit -m "${1:-chore: batched commit $(date +%Y-%m-%d)}"
    echo "✅ Single commit: $TOTAL files"
    exit 0
fi

# If >18 - batch commits
BATCH_NUM=1
FILE_COUNT=0
BATCH_FILES=()

for file in "${FILES[@]}"; do
    BATCH_FILES+=("$file")
    ((FILE_COUNT++))

    if [[ $FILE_COUNT -eq $MAX_FILES_PER_COMMIT ]]; then
        git add "${BATCH_FILES[@]}"
        git commit -m "${1:-chore: batched commit $(date +%Y-%m-%d)} [batch $BATCH_NUM/$((TOTAL / MAX_FILES_PER_COMMIT + 1))]"

        echo "✅ Batch $BATCH_NUM: $FILE_COUNT files committed"

        BATCH_FILES=()
        FILE_COUNT=0
        ((BATCH_NUM++))

        sleep "$COMMIT_DELAY"
    fi
done

# Remaining files (last batch <18)
if [[ ${#BATCH_FILES[@]} -gt 0 ]]; then
    git add "${BATCH_FILES[@]}"
    git commit -m "${1:-chore: batched commit $(date +%Y-%m-%d)} [batch $BATCH_NUM/$BATCH_NUM]"
    echo "✅ Final batch $BATCH_NUM: ${#BATCH_FILES[@]} files"
fi

echo "🎉 Batched commit complete: $BATCH_NUM batch(es), $TOTAL files total"
```

**Usage**:
```bash
# Auto-batch current changes
./dev/scripts/batched-commit.sh

# With custom message
./dev/scripts/batched-commit.sh "feat(docs): add new documentation"
```

## 📅 Schedule

| Time | Action | Script | Trigger |
|------|--------|--------|---------|
| **Continuous** | LiveSync | Obsidian plugin | On save |
| **Hourly** | Vault backup | Obsidian Git | Auto (60 min) |
| **00:00** | Graph snapshot | graph-snapshot.sh | systemd timer |
| **03:00** | GitHub backup | daily-github-backup.sh | systemd timer |
| **Manual** | Batched commit | batched-commit.sh | On demand |

## 🔧 Setup Instructions

### 1. Create scripts directory
```bash
mkdir -p ~/git/eww/dev/scripts
chmod +x ~/git/eww/dev/scripts/*.sh
```

### 2. Install systemd timers
```bash
# Copy timer/service files
mkdir -p ~/.config/systemd/user/

# Enable timers
systemctl --user enable graph-snapshot.timer
systemctl --user enable github-backup.timer

# Start timers
systemctl --user start graph-snapshot.timer
systemctl --user start github-backup.timer

# Check status
systemctl --user list-timers
```

### 3. Configure Obsidian Git plugin
```
Settings → Community plugins → Obsidian Git
- Auto commit interval: 60
- Commit message: chore(vault): {{hostname}} backup {{date}}
- Auto pull: disabled
- Auto push: disabled
```

### 4. Test
```bash
# Test graph snapshot
~/git/eww/dev/scripts/graph-snapshot.sh

# Test GitHub backup
~/git/eww/dev/scripts/daily-github-backup.sh

# Test batched commit
echo "test" > test.md
~/git/eww/dev/scripts/batched-commit.sh "test: batching"
```

## 📊 Monitoring

### Check systemd timers
```bash
# List all timers
systemctl --user list-timers

# Check specific timer
systemctl --user status graph-snapshot.timer
systemctl --user status github-backup.timer

# View logs
journalctl --user -u graph-snapshot.service
journalctl --user -u github-backup.service
```

### Check Git history
```bash
# Auto-commits today
git log --since="midnight" --grep="chore(vault)" --oneline

# Graph snapshots
ls -lh .obsidian/graph-versions/

# GitHub last push
git log origin/main..HEAD
```

### Obsidian Git status
- Settings → Obsidian Git → Show status
- Last auto-commit timestamp
- Uncommitted changes count

## 🚨 Troubleshooting

### Timer not running
```bash
# Check if timer is enabled
systemctl --user is-enabled graph-snapshot.timer

# Check timer status
systemctl --user status graph-snapshot.timer

# Restart timer
systemctl --user restart graph-snapshot.timer
```

### Script permission denied
```bash
# Fix permissions
chmod +x ~/git/eww/dev/scripts/*.sh
```

### Git conflicts
```bash
# Auto-commits shouldn't conflict (LiveSync handles real-time)
# If conflict: manual resolve
git status
git mergetool
```

### Too many commits
```bash
# Squash last 24 hourly commits (optional)
git rebase -i HEAD~24
# Mark commits as 'squash'
git push --force-with-lease
```

## 📈 Best Practices

1. **Obsidian work**: Let plugin auto-commit (hands-off)
2. **VS Code work**: Manual commits (meaningful messages)
3. **End of day**: Manual push to GitHub (stable versions)
4. **Big refactors**: Use batched-commit.sh (avoid huge commits)
5. **Review logs**: Check `git log` weekly (cleanup if needed)

## 🔗 Related

- [[git-sync-strategy]] - Git + LiveSync workflow
- [[graph-workflow]] - Graph versioning
- [[dev-workflow]] - Development workflow
- [[core/systemd/]] - Systemd units

---

**Status**: 🟡 PLANNED (scripts exist, timers TODO)
**Owner**: jakubc
**Implementation**: ~2h (scripts + timers + testing)

## 🔗 Backlinks

- [[core/workflow/workflow]]
- [[core/core]]
- [[core/config]]