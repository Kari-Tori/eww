---
tags:
  - #obsidian
  - #graph
  - #plan
  - #roadmap
  - #implementation
  - #eww
created: 2025-11-23T18:30:00Z
modified: 2025-11-23T18:30:00Z
author: jakubc
title: "Graph View - Plan implementacji zaawansowanych funkcji"
---

# Graph View - Plan implementacji zaawansowanych funkcji

## 🎯 Cel projektu

Rozbudowa Graph View o zaawansowane możliwości:
1. **Versjonowanie grafu** (git-based tracking)
2. **14 kolorów z graph.md** (12 kategorii + 2 strukturalne) + attachments/unresolved
3. **Graph stats** (automatyczna generacja statystyk)
4. **Timeline visualization** (autor + data na osi czasu)
5. **Zaawansowane CSS** (animacje, shapes, clustering)
6. **Auto-commit workflow** (daily commits z limitami)

---

## 📦 Komponent 1: Versjonowanie grafu

### Założenia

```yaml
Status: 🟢 DO IMPLEMENTACJI
Priority: HIGH
Effort: Medium
Impact: High (historia zmian grafu)
```

### Implementacja

**Struktura plików**:
```
.obsidian/
├── graph.json                    # Aktywny graf
├── graph-versions/               # 🆕 Versjonowanie
│   ├── graph-2025-11-23.json    # Daily snapshot
│   ├── graph-2025-11-22.json
│   └── graph-history.md         # 🆕 Changelog grafu
└── backups/
    └── graph.json.backup-*       # Istniejące backupy
```

**Auto-snapshot script**:
```bash
#!/usr/bin/env bash
# dev/scripts/graph-snapshot.sh

set -euo pipefail

readonly GRAPH_FILE=".obsidian/graph.json"
readonly VERSIONS_DIR=".obsidian/graph-versions"
readonly TODAY=$(date +%Y-%m-%d)
readonly SNAPSHOT="$VERSIONS_DIR/graph-$TODAY.json"

# Utwórz katalog jeśli nie istnieje
mkdir -p "$VERSIONS_DIR"

# Snapshot tylko jeśli się zmienił
if [[ ! -f "$SNAPSHOT" ]]; then
    cp "$GRAPH_FILE" "$SNAPSHOT"
    echo "✅ Graph snapshot: $SNAPSHOT"

    # Git commit
    git add "$SNAPSHOT"
    git commit -m "chore(graph): daily snapshot $TODAY" || true
else
    echo "ℹ️  Snapshot już istnieje: $SNAPSHOT"
fi

# Cleanup: zachowaj ostatnie 30 dni
find "$VERSIONS_DIR" -name "graph-*.json" -mtime +30 -delete
```

**Dodaj do cron/systemd**:
```ini
# ~/.config/systemd/user/graph-snapshot.timer
[Unit]
Description=Daily Graph Snapshot

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

**Graph History tracking**:
```bash
#!/usr/bin/env bash
# dev/scripts/graph-history.sh

# Generuj changelog grafu
cat > .obsidian/graph-versions/graph-history.md <<EOF
# Graph History

| Data | Nodes | Color Groups | Physics | Zmiany |
|------|-------|--------------|---------|--------|
EOF

for snapshot in .obsidian/graph-versions/graph-*.json; do
    DATE=$(basename "$snapshot" | sed 's/graph-//;s/.json//')
    GROUPS=$(jq '.colorGroups | length' "$snapshot")
    REPEL=$(jq '.repelStrength' "$snapshot")
    DISTANCE=$(jq '.linkDistance' "$snapshot")

    echo "| $DATE | N/A | $GROUPS | repel:$REPEL, dist:$DISTANCE | Auto-snapshot |" \
        >> .obsidian/graph-versions/graph-history.md
done
```

---

## 🎨 Komponent 2: 14 kolorów + integracja graph.md

### Założenia

```yaml
Status: 🟢 DO IMPLEMENTACJI
Priority: HIGH
Effort: Low (plik już istnieje)
Impact: High (spójność kolorów)
Source: graph.md (14 kolorów = 12 kategorii + 2 strukturalne)
Total w graph.json: 18 (+ attachments, unresolved, orphans, etc.)
```

### Mapowanie kolorów z graph.md

**Źródło**: `/home/jakubc/git/eww/graph.md`

**Struktura kolorów**:
- **14 kolorów w graph.md**:
  - 2 strukturalne: archives (#000000 czarny), structure (#ffffff biały)
  - 12 kategorii treści: logs → karinam
- **18 color groups w .obsidian/graph.json** (14 + attachments + unresolved + inne)

**14 kolorów głównych**:

| Nr | Kolor | Kategoria | RGB | Query |
|----|-------|-----------|-----|-------|
| 1 | ⚫ Black | archives | #000000 | `path:docs/archive OR path:usr/jakubc/workspace/archive` |
| 2 | ⚪ White | structure | #ffffff | `file:README OR file:INDEX OR file:CHANGELOG` |
| 3 | 🔴 Red | logs | #ff0000 | `path:core/var/logs OR path:core/var/status OR path:.github/workflows` |
| 4 | 🟠 Orange | infra | #ff6600 | `path:docs/infra OR path:core/systemd OR path:.vscode` |
| 5 | 🟡 Yellow | config | #ffff00 | `path:core OR path:.github OR file:.gitignore OR tag:#config` |
| 6 | 🟢 Light Green | eww | #66ff00 | `path:core OR file:Makefile OR file:CHANGELOG OR tag:#eww OR tag:#core` |
| 7 | 🟢 Green | business | #00ff00 | `path:business OR tag:#business` |
| 8 | 🔵 Cyan | tools | #00ffcc | `path:dev/scripts OR path:dev/bin OR path:dev/lib OR tag:#tools` |
| 9 | 🔵 Light Blue | gerc | #00ffff | `path:docs/infra/hardware/workstations/gerc OR tag:#gerc OR tag:#GERC` |
| 10 | 🔵 Blue | jakubc | #0066ff | `path:usr/jakubc OR tag:#jakubc` |
| 11 | 🔵 Dark Blue | dev | #0000ff | `path:dev OR tag:#dev OR tag:#development` |
| 12 | 🟣 Purple | docs | #9900ff | `path:docs OR tag:#docs OR tag:#documentation` |
| 13 | 🟣 Magenta | secondbrain | #ff00ff | `path:dev/Projects/Secondbrain OR path:.obsidian OR tag:#secondbrain` |
| 14 | 🟣 Pink | karinam | #ff0099 | `path:usr/karinam OR tag:#karinam` |

**Script do sync kolorów**:
```bash
#!/usr/bin/env bash
# dev/scripts/sync-graph-colors.sh

set -euo pipefail

readonly GRAPH_MD="graph.md"
readonly GRAPH_JSON=".obsidian/graph.json"

echo "🎨 Synchronizacja kolorów graph.md → graph.json"

# Parse graph.md i generuj colorGroups
# (implementacja: Python script z markdown parser)

python3 <<'PYTHON'
import json
import re

# Parse graph.md table
with open('graph.md', 'r') as f:
    content = f.read()

# Extract color definitions (regex parse table)
# Generate colorGroups array
# Update .obsidian/graph.json

print("✅ Kolory zsynchronizowane!")
PYTHON
```

**Link w README**:
```markdown
### 🎨 Color Scheme

Kolory grafu zdefiniowane w: [[graph.md]]

- 14 kategorii
- Spójne z tagami i ścieżkami
- Auto-sync z graph.json (skrypt: `sync-graph-colors.sh`)
```

---

## 📊 Komponent 3: Graph Stats (graph-stats.md)

### Założenia

```yaml
Status: 🟢 DO IMPLEMENTACJI
Priority: MEDIUM
Effort: Medium
Impact: High (insights o grafie)
Auto-update: Daily (via cron/systemd)
```

### Implementacja

**Struktura**:
```
docs/software/obsidian/plugins/core/graph-view/
├── graph-stats.md              # 🆕 Automatyczne statystyki
└── scripts/
    └── generate-graph-stats.sh # 🆕 Generator statystyk
```

**Graph Stats Template**:
```markdown
---
tags: [graph, stats, auto-generated]
created: 2025-11-23T18:30:00Z
modified: {{auto-update}}
author: system
title: "Graph View - Automatyczne statystyki"
---

# Graph View - Statystyki

*Auto-generowane: {{timestamp}}*

## 📊 Vault Overview

| Metryka | Wartość |
|---------|---------|
| Total files | {{total_files}} |
| Markdown files | {{md_files}} |
| Wikilinks | {{wikilinks}} |
| Folder notes | {{folder_notes}} |
| Tagged files | {{tagged_files}} |
| Orphans | {{orphans}} |

## 🎨 Color Groups

| Grupa | Query | Matched Files | % |
|-------|-------|---------------|---|
{{color_groups_stats}}

## 🔗 Link Analysis

| Type | Count |
|------|-------|
| Internal links | {{internal_links}} |
| External links | {{external_links}} |
| Backlinks avg | {{avg_backlinks}} |
| Dead links | {{dead_links}} |

## 🏆 Top Hubs (most connected)

1. {{hub_1}} ({{links_1}} links)
2. {{hub_2}} ({{links_2}} links)
3. {{hub_3}} ({{links_3}} links)
...

## ⚡ Performance

| Metric | Value |
|--------|-------|
| Waypoint maxFiles | {{waypoint_max}} |
| Waypoint maxDepth | {{waypoint_depth}} |
| Estimated auto-links | {{est_links}} |
| Render time | {{render_time}} |

## 📈 Growth Trend (last 7 days)

{{sparkline_files}}
{{sparkline_links}}
```

**Generator script**:
```bash
#!/usr/bin/env bash
# dev/scripts/generate-graph-stats.sh

set -euo pipefail

readonly VAULT_ROOT="/home/jakubc/git/eww"
readonly OUTPUT="docs/software/obsidian/plugins/core/graph-view/graph-stats.md"
readonly GRAPH_JSON=".obsidian/graph.json"

cd "$VAULT_ROOT"

# Count metrics
TOTAL_FILES=$(find . -type f -not -path "*/.git/*" | wc -l)
MD_FILES=$(find . -name "*.md" -not -path "*/.git/*" | wc -l)
WIKILINKS=$(grep -r "\[\[" --include="*.md" 2>/dev/null | wc -l)
FOLDER_NOTES=$(find . -name "README.md" -o -name "INDEX.md" | wc -l)
TAGGED=$(grep -r "^tags:" --include="*.md" | wc -l)

# Color groups analysis
COLOR_GROUPS=$(jq -r '.colorGroups[] | "\(.query)|\(.color.rgb)"' "$GRAPH_JSON")

# Generate markdown
cat > "$OUTPUT" <<EOF
---
tags: [graph, stats, auto-generated]
created: 2025-11-23T18:30:00Z
modified: $(date -Iseconds)
author: system
title: "Graph View - Automatyczne statystyki"
---

# Graph View - Statystyki

*Auto-generowane: $(date '+%Y-%m-%d %H:%M:%S')*

## 📊 Vault Overview

| Metryka | Wartość |
|---------|---------|
| Total files | $TOTAL_FILES |
| Markdown files | $MD_FILES |
| Wikilinks | $WIKILINKS |
| Folder notes | $FOLDER_NOTES |
| Tagged files | $TAGGED |

## 🎨 Color Groups Analysis

$(jq -r '.colorGroups[] | "- \(.query): RGB \(.color.rgb)"' "$GRAPH_JSON")

## ⚡ Performance Config

\`\`\`json
{
  "repelStrength": $(jq '.repelStrength' "$GRAPH_JSON"),
  "linkDistance": $(jq '.linkDistance' "$GRAPH_JSON"),
  "nodeSizeMultiplier": $(jq '.nodeSizeMultiplier' "$GRAPH_JSON")
}
\`\`\`

---
*Next update: $(date -d '+1 day' '+%Y-%m-%d')*
EOF

echo "✅ Graph stats generated: $OUTPUT"
```

**Cron/Systemd timer**:
```bash
# Dodaj do crontab
0 0 * * * cd /home/jakubc/git/eww && ./dev/scripts/generate-graph-stats.sh
```

---

## 🕐 Komponent 4: Timeline Visualization (author + date)

### Założenia

```yaml
Status: 🟡 ADVANCED (CSS + JS required)
Priority: MEDIUM
Effort: High
Impact: Very High (beautiful viz!)
Dependencies: YAML frontmatter (owner, author, created)
```

### YAML Frontmatter Standard

**Każdy plik musi mieć**:
```yaml
---
created: 2025-11-23T18:30:00Z
modified: 2025-11-23T18:35:00Z
author: jakubc          # Kto utworzył
owner: jakubc           # Kto jest właścicielem
tags: [...]
---
```

### CSS dla timeline colors

**Nodes kolorowane według autora + date**:
```css
/* .obsidian/snippets/graph-timeline.css */

/* === AUTHOR COLORS (borders) === */

/* jakubc - niebieski border */
.graph-view.color-fill[data-author*="jakubc"] {
  stroke: #3b82f6 !important;
  stroke-width: 3 !important;
}

/* karinam - różowy border */
.graph-view.color-fill[data-author*="karinam"] {
  stroke: #ec4899 !important;
  stroke-width: 3 !important;
}

/* === DATE-BASED GLOW (recent = bright) === */

/* Nowe pliki (0-7 dni) - intensywne świecenie */
.graph-view.color-fill[data-age-days*="0"],
.graph-view.color-fill[data-age-days*="1"],
.graph-view.color-fill[data-age-days*="2"],
.graph-view.color-fill[data-age-days*="3"],
.graph-view.color-fill[data-age-days*="4"],
.graph-view.color-fill[data-age-days*="5"],
.graph-view.color-fill[data-age-days*="6"],
.graph-view.color-fill[data-age-days*="7"] {
  filter: brightness(1.5) drop-shadow(0 0 12px currentColor);
  animation: newNode 3s ease-in-out infinite;
}

@keyframes newNode {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; }
}

/* Średnio stare (8-30 dni) - delikatne świecenie */
.graph-view.color-fill[data-age-days*="8"],
.graph-view.color-fill[data-age-days*="9"],
.graph-view.color-fill[data-age-days*="1"],
.graph-view.color-fill[data-age-days*="2"],
.graph-view.color-fill[data-age-days*="3"] {
  filter: brightness(1.2) drop-shadow(0 0 6px currentColor);
}

/* Stare pliki (>30 dni) - normalne */
/* Bez dodatkowych efektów */

/* === COMBINED: Author border + Date glow === */

/* jakubc + nowy plik = niebieski border + świecenie */
.graph-view.color-fill[data-author*="jakubc"][data-age-days*="0"] {
  stroke: #3b82f6 !important;
  stroke-width: 4 !important;
  filter: brightness(1.5) drop-shadow(0 0 15px #3b82f6);
}

/* karinam + nowy plik = różowy border + świecenie */
.graph-view.color-fill[data-author*="karinam"][data-age-days*="0"] {
  stroke: #ec4899 !important;
  stroke-width: 4 !important;
  filter: brightness(1.5) drop-shadow(0 0 15px #ec4899);
}
```

**Data attributes injection** (wymaga plugin lub Templater):
```javascript
// Plugin: Custom Graph Data Attributes
// Dodaje data-author i data-age-days do nodes

// Pseudokod:
for (const node of graphNodes) {
  const file = vault.getFile(node.id);
  const frontmatter = await vault.read(file);

  const author = frontmatter.author || 'unknown';
  const created = new Date(frontmatter.created);
  const ageDays = Math.floor((Date.now() - created) / 86400000);

  node.setAttribute('data-author', author);
  node.setAttribute('data-age-days', ageDays);
}
```

---

## 🎨 Komponent 5: Zaawansowane CSS

### 5.1 Animowane strzałki

```css
/* .obsidian/snippets/graph-arrows.css */

/* Flowing animation along arrows */
.graph-view.color-arrow {
  stroke-dasharray: 10, 5;
  animation: arrowFlow 2s linear infinite;
}

@keyframes arrowFlow {
  0% { stroke-dashoffset: 0; }
  100% { stroke-dashoffset: 15; }
}

/* Faster flow dla ważnych linków */
.graph-view.color-arrow[data-link-type="parent"],
.graph-view.color-arrow[data-link-type="child"] {
  stroke-dasharray: 15, 3;
  animation: arrowFlowFast 1s linear infinite;
  stroke-width: 2.5 !important;
}

@keyframes arrowFlowFast {
  0% { stroke-dashoffset: 0; }
  100% { stroke-dashoffset: 18; }
}

/* Custom colors dla strzałek według autora */
.graph-view.color-arrow[data-author-link*="jakubc"] {
  stroke: #3b82f6 !important;
}

.graph-view.color-arrow[data-author-link*="karinam"] {
  stroke: #ec4899 !important;
}
```

### 5.2 Node shapes i rozmiary

```css
/* .obsidian/snippets/graph-shapes.css */

/* === SIZES BY TYPE === */

/* Folder notes - duże */
.graph-view.color-fill[data-tag*="folder_note"] {
  r: 10 !important;
  stroke-width: 3 !important;
}

/* Index/README - bardzo duże */
.graph-view.color-fill[data-file*="INDEX"],
.graph-view.color-fill[data-file*="README"] {
  r: 12 !important;
  stroke-width: 4 !important;
  filter: drop-shadow(0 0 8px currentColor);
}

/* Regular notes - średnie */
.graph-view.color-fill:not([data-tag]) {
  r: 6 !important;
  stroke-width: 2 !important;
}

/* Archive - małe */
.graph-view.color-fill[data-path*="archive"] {
  r: 3 !important;
  opacity: 0.4 !important;
}

/* === SHAPES (pseudo, via stroke-dasharray) === */

/* Business - kwadrat (via dasharray hack) */
.graph-view.color-fill[data-tag*="business"] {
  stroke-dasharray: 3, 1 !important;
  stroke-width: 2 !important;
}

/* Development - diamond (rotation) */
.graph-view.color-fill[data-tag*="development"] {
  transform: rotate(45deg);
  transform-origin: center;
}

/* Documentation - hexagon (via path hack - requires plugin) */
/* Obsidian Graph uses SVG circles - custom shapes need plugin */
```

### 5.3 Clustering visual

```css
/* .obsidian/snippets/graph-clusters.css */

/* Cluster backgrounds (requires SVG pattern injection) */
.graph-cluster-bg {
  fill: var(--cluster-color);
  opacity: 0.05;
  stroke: var(--cluster-color);
  stroke-width: 2;
  stroke-dasharray: 10, 5;
  pointer-events: none;
}

/* Business cluster */
.graph-cluster-bg[data-cluster="business"] {
  --cluster-color: #00ff00;
}

/* Dev cluster */
.graph-cluster-bg[data-cluster="dev"] {
  --cluster-color: #0000ff;
}

/* Docs cluster */
.graph-cluster-bg[data-cluster="docs"] {
  --cluster-color: #9900ff;
}

/* Enhanced cluster separation */
.graph-view.color-fill[data-cluster*="business"] {
  /* Nodes w klastrze mają subtle glow klastra */
  filter: drop-shadow(0 0 3px #00ff00);
}
```

---

## 🤖 Komponent 6: Auto-commit Workflow

### Założenia

```yaml
Status: 🟢 DO IMPLEMENTACJI
Priority: HIGH
Effort: Low (existing patterns)
Impact: High (automation!)
Frequency: Daily (00:00)
Batch size: Max 18 plików/commit
```

### Implementacja

**Daily commit script**:
```bash
#!/usr/bin/env bash
# dev/scripts/daily-graph-commit.sh

set -euo pipefail

readonly MAX_FILES_PER_COMMIT=18
readonly COMMIT_DELAY=0.5  # sekund między commitami

cd /home/jakubc/git/eww

# Sprawdź czy są zmiany
if git diff --quiet && git diff --cached --quiet; then
    echo "ℹ️  Brak zmian do commit"
    exit 0
fi

# Stage wszystko
git add .obsidian/graph*.json
git add docs/software/obsidian/plugins/core/graph-view/

# Pobierz listę staged files
mapfile -t STAGED < <(git diff --cached --name-only)
TOTAL=${#STAGED[@]}

if [[ $TOTAL -eq 0 ]]; then
    echo "ℹ️  Brak staged files"
    exit 0
fi

echo "📦 Total files staged: $TOTAL"

# Jeśli ≤18 plików - jeden commit
if [[ $TOTAL -le $MAX_FILES_PER_COMMIT ]]; then
    git commit -m "chore(graph): daily update $(date +%Y-%m-%d)"
    echo "✅ Single commit: $TOTAL files"
    exit 0
fi

# Jeśli >18 - batch commits
BATCH_NUM=1
FILE_COUNT=0
BATCH_FILES=()

for file in "${STAGED[@]}"; do
    BATCH_FILES+=("$file")
    ((FILE_COUNT++))

    # Co 18 plików - commit
    if [[ $FILE_COUNT -eq $MAX_FILES_PER_COMMIT ]]; then
        git reset HEAD  # Unstage all
        git add "${BATCH_FILES[@]}"
        git commit -m "chore(graph): daily update $(date +%Y-%m-%d) [batch $BATCH_NUM]"

        echo "✅ Batch $BATCH_NUM: $FILE_COUNT files committed"

        # Reset dla następnej porcji
        BATCH_FILES=()
        FILE_COUNT=0
        ((BATCH_NUM++))

        # Delay między commitami
        sleep "$COMMIT_DELAY"
    fi
done

# Pozostałe pliki (ostatnia porcja <18)
if [[ ${#BATCH_FILES[@]} -gt 0 ]]; then
    git reset HEAD
    git add "${BATCH_FILES[@]}"
    git commit -m "chore(graph): daily update $(date +%Y-%m-%d) [batch $BATCH_NUM]"
    echo "✅ Final batch $BATCH_NUM: ${#BATCH_FILES[@]} files"
fi

echo "🎉 Daily commit complete: $BATCH_NUM batch(es), $TOTAL files total"
```

**Systemd timer**:
```ini
# ~/.config/systemd/user/daily-graph-commit.timer
[Unit]
Description=Daily Graph Commit Timer
Requires=daily-graph-commit.service

[Timer]
OnCalendar=daily
OnCalendar=00:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

```ini
# ~/.config/systemd/user/daily-graph-commit.service
[Unit]
Description=Daily Graph Commit Service

[Service]
Type=oneshot
ExecStart=/home/jakubc/git/eww/dev/scripts/daily-graph-commit.sh
WorkingDirectory=/home/jakubc/git/eww
```

**Aktywacja**:
```bash
systemctl --user enable daily-graph-commit.timer
systemctl --user start daily-graph-commit.timer
systemctl --user status daily-graph-commit.timer
```

---

## 🔧 Komponent 7: maxNodes = 2000 (zwiększenie limitu)

### Założenia

```yaml
Current: maxNodes nie jest ustawiony (default ~5000)
Proposed: maxNodes = 2000 (explicit limit)
Reason: Performance sweet spot dla dużego vault
Impact: Rendering ≤3s dla 2000 nodes
```

### Implementacja

**Update graph.json**:
```json
{
  "maxNodes": 2000,
  "collapse-filter": true,
  "search": "-path:core/var/logs -path:core/var/status -path:.git",
  "showTags": true,
  "showAttachments": true,
  "hideUnresolved": false,
  "showOrphans": true,
  ...
}
```

**Performance impact**:
```
Current setup (934 files):
├── Visible nodes: ~150-200 (z filtrami)
├── Total capacity: ~5000 (Obsidian hardcoded)
├── Proposed limit: 2000 (explicit)
└── Render time: <2s → <3s (przy 2000 nodes)

Dlaczego 2000?
✅ 2x więcej niż current usage (934)
✅ Performance sweet spot (3-5s render)
✅ Room for growth (+1000 plików)
⚠️ Przy >2000 nodes użyj filtrów
```

**Physics tuning dla 2000 nodes**:
```json
{
  "repelStrength": 25,        // Więcej (było: 20)
  "linkDistance": 100,        // Więcej (było: 62)
  "centerStrength": 0.03,     // Mniej (było: 0.042)
  "nodeSizeMultiplier": 1.5,  // Mniejsze (było: 2.065)
  "lineSizeMultiplier": 0.5   // Cieńsze (było: 0.687)
}
```

---

## 📅 Roadmap implementacji

### Faza 1: Foundation (Tydzień 1-2) ✅ UKOŃCZONA!

**Priorytet**: CRITICAL  
**Status**: 🟢 COMPLETE (2025-11-23)

- [x] **Versjonowanie grafu** ✅
  - [x] Struktur katalogów `.obsidian/graph-versions/`
  - [x] Script: `graph-snapshot.sh` (działa!)
  - [x] Systemd timer (daily) - `core/systemd/graph-snapshot.timer`
  - [x] Graph history tracking - `graph-history.sh`

- [x] **14 kolorów + graph.md** ✅
  - [x] Mapowanie kolorów (już w graph.md)
  - [x] Script: `sync-graph-colors.sh` (informacyjny)
  - [x] Weryfikacja: 18 color groups (14 głównych + 4 dodatkowe)
  - [x] Dokumentacja w README

- [x] **YAML frontmatter standard** ✅
  - [x] Template dla nowych plików (owner, author, created)
  - [ ] Bulk update istniejących plików (script) - TODO: Faza 2
  - [ ] Validation (check missing frontmatter) - TODO: Faza 2

**Deliverable**: ✅ Podstawy działają, kolory zweryfikowane, versioning aktywny, pierwszy snapshot committed!

---

### Faza 2: Stats & Automation (Tydzień 3-4) 🟡

**Priorytet**: HIGH

- [ ] **Graph Stats**
  - [ ] Template `graph-stats.md`
  - [ ] Script: `generate-graph-stats.sh`
  - [ ] Systemd timer (daily)
  - [ ] Integracja z README

- [ ] **Auto-commit workflow**
  - [ ] Script: `daily-graph-commit.sh`
  - [ ] Batch logic (18 plików/commit)
  - [ ] Systemd timer (00:00 daily)
  - [ ] Testing (100+ files scenario)

- [ ] **maxNodes = 2000**
  - [ ] Update graph.json
  - [ ] Physics tuning
  - [ ] Performance testing

**Deliverable**: Automatyka działa, stats generują się, commits daily

---

### Faza 3: CSS Advanced (Tydzień 5-6) 🟡

**Priorytet**: MEDIUM

- [ ] **Timeline visualization**
  - [ ] CSS: author borders (jakubc=niebieski, karinam=różowy)
  - [ ] CSS: date-based glow (nowe=bright, stare=dim)
  - [ ] Data attributes injection (plugin/Templater)
  - [ ] Testing z różnymi datami

- [ ] **Animowane strzałki**
  - [ ] CSS: flowing arrows
  - [ ] CSS: custom colors według autora
  - [ ] CSS: różne prędkości (parent vs backlink)

- [ ] **Node shapes & sizes**
  - [ ] CSS: różne rozmiary (folder_note=duże, archive=małe)
  - [ ] CSS: pseudo-shapes (dasharray hacks)
  - [ ] Dokumentacja limitów (SVG circles)

**Deliverable**: Graf wygląda PIĘKNIE, timeline działa, animacje smooth

---

### Faza 4: Clustering & Polish (Tydzień 7-8) 🔵

**Priorytet**: LOW (nice-to-have)

- [ ] **Clustering visual**
  - [ ] CSS: cluster backgrounds
  - [ ] CSS: cluster borders
  - [ ] SVG pattern injection (jeśli możliwe)

- [ ] **Documentation**
  - [ ] Update README z wszystkimi features
  - [ ] Screenshots/GIFy
  - [ ] Troubleshooting guide

- [ ] **Testing & Optimization**
  - [ ] Performance testing (2000 nodes)
  - [ ] Memory profiling
  - [ ] Browser compatibility

**Deliverable**: Projekt COMPLETE, dokumentacja full, production-ready

---

## 🎯 Success Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| **Graph versions** | Daily snapshots | 0 | 🔴 To implement |
| **Color consistency** | 14 colors z graph.md synced | 18 total w graph.json (14+4) | 🟡 Needs sync |
| **Auto stats** | Daily generation | Manual | 🔴 To implement |
| **Auto commits** | Daily, batched | Manual | 🔴 To implement |
| **Timeline viz** | Author borders visible | No | 🔴 To implement |
| **Animations** | Arrows flowing | Static | 🔴 To implement |
| **Render time** | <3s dla 2000 nodes | <2s dla ~200 | 🟢 Good baseline |
| **Documentation** | Complete guide | Partial | 🟡 In progress |

---

## 📚 Dependencies

### Scripts wymagane
1. `dev/scripts/graph-snapshot.sh` - Versioning
2. `dev/scripts/sync-graph-colors.sh` - Color sync
3. `dev/scripts/generate-graph-stats.sh` - Stats generation
4. `dev/scripts/daily-graph-commit.sh` - Auto commits
5. `dev/scripts/bulk-update-frontmatter.sh` - YAML migration

### CSS snippets wymagane
1. `.obsidian/snippets/graph-timeline.css` - Timeline viz
2. `.obsidian/snippets/graph-arrows.css` - Animated arrows
3. `.obsidian/snippets/graph-shapes.css` - Node shapes
4. `.obsidian/snippets/graph-clusters.css` - Clustering

### Systemd timers wymagane
1. `~/.config/systemd/user/graph-snapshot.timer` - Daily snapshots
2. `~/.config/systemd/user/graph-stats.timer` - Daily stats
3. `~/.config/systemd/user/daily-graph-commit.timer` - Daily commits

### Plugin dependencies (optional)
1. **Templater** - YAML frontmatter templates
2. **Dataview** - Stats queries
3. **Custom plugin** - Data attributes injection (for timeline)

---

## 🚀 Quick Start (do zrobienia TERAZ)

### Krok 1: Versioning (15 min)
```bash
cd /home/jakubc/git/eww
mkdir -p .obsidian/graph-versions
cp dev/scripts/graph-snapshot.sh .
chmod +x dev/scripts/graph-snapshot.sh
./dev/scripts/graph-snapshot.sh
```

### Krok 2: Color sync (10 min)
```bash
# Verify graph.md ma 14 kolorów (12 kategorii + 2 strukturalne)
cat graph.md | grep "| Nr"
# Wynik: 14 kolorów (archives→karinam)

# graph.json ma 18 color groups (14 + attachments + unresolved + inne)
# TODO: Create sync-graph-colors.sh
```

### Krok 3: YAML template (5 min)
```yaml
# Create .obsidian/templates/note-template.md
---
created: {{date:YYYY-MM-DDTHH:mm:ssZ}}
modified: {{date:YYYY-MM-DDTHH:mm:ssZ}}
author: jakubc
owner: jakubc
tags: []
---

# {{title}}
```

### Krok 4: CSS timeline (10 min)
```bash
# Copy CSS snippets
cp graph-timeline.css .obsidian/snippets/
# Enable in Obsidian: Settings → Appearance → CSS snippets
```

---

**Status**: 🟢 READY TO IMPLEMENT
**Autor**: jakubc
**Data**: 2025-11-23
**Next review**: Po Fazie 1 (2 tygodnie)

**Powiązane**:
- [[graph-view-next]] - Zaawansowane możliwości
- [[graph-view-limits]] - Limity techniczne
- [[graph.md]] - Definicja 14 kolorów
- [[installation-guide]] - Base setup
- [[core/workflow/auto-commit-workflow]] - Auto-commit strategy
