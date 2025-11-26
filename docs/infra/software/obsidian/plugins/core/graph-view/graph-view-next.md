---
tags:
  - #obsidian
  - #graph
  - #advanced
  - #customization
  - #future
  - #community
created: 2025-11-23T18:00:00Z
modified: 2025-11-23T18:00:00Z
author: jakubc
title: "Obsidian Graph View - Zaawansowane możliwości i przyszłość"
owner: jakubc
---

# Obsidian Graph View - Zaawansowane możliwości i przyszłość

## 🎯 Wprowadzenie

Ten dokument opisuje **zaawansowane techniki customizacji** Graph View oraz **przyszłe kierunki rozwoju** oparte na:
- Analizie społeczności Obsidian (Reddit, Discord, Forum)
- Dostępnych CSS snippets i community plugins
- Praktycznych implementacjach w projekcie eww
- Feature requests i roadmap Obsidian

## 🎨 POZIOM 1: CSS Customization (DOSTĘPNE TERAZ)

### 1.1 Animacje i efekty wizualne

#### Pulsujące nodes dla aktywnych projektów
```css
/* .obsidian/snippets/graph-animations.css */
.graph-view.color-fill[data-tag*="active"],
.graph-view.color-fill[data-tag*="current"] {
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
    r: 6;
  }
  50% {
    opacity: 0.7;
    r: 7;
  }
}
```

**Zastosowanie**: Wizualne wyróżnienie projektów w toku

#### Świecące ważne nodes
```css
.graph-view.color-fill[data-tag*="important"],
.graph-view.color-fill[data-tag*="priority"] {
  filter: drop-shadow(0 0 8px currentColor);
  stroke-width: 3 !important;
}
```

**Efekt**: Nodes "świecą" swoim kolorem (glow effect)

#### Gradient backgrounds dla kategorii
```css
.graph-view.color-fill[data-tag*="business"] {
  fill: url(#business-gradient) !important;
}

/* Definicja gradientu (dodać do SVG) */
<defs>
  <linearGradient id="business-gradient">
    <stop offset="0%" stop-color="#8b5cf6"/>
    <stop offset="100%" stop-color="#ec4899"/>
  </linearGradient>
</defs>
```

**Efekt**: Piękne przejścia kolorów zamiast flat colors

### 1.2 Linki i strzałki

#### Kolorowe strzałki według typu relacji
```css
/* Parent-child - gruby niebieski */
.graph-view.color-line[data-link-type="parent"],
.graph-view.color-line[data-link-type="child"] {
  stroke: #3b82f6 !important;
  stroke-width: 2.5 !important;
  opacity: 0.8 !important;
}

/* Backlinks - cienki szary */
.graph-view.color-line[data-link-type="backlink"] {
  stroke: #888888 !important;
  stroke-width: 0.8 !important;
  stroke-dasharray: 5,3 !important;
  opacity: 0.3 !important;
}

/* Tags - przerywany zielony */
.graph-view.color-line[data-link-type="tag"] {
  stroke: #10b981 !important;
  stroke-dasharray: 3,2 !important;
  opacity: 0.5 !important;
}
```

**Rezultat**: Każdy typ relacji ma unikalny styl

#### Animowane strzałki (flow effect)
```css
.graph-view.color-arrow {
  animation: flow 3s linear infinite;
}

@keyframes flow {
  0% { stroke-dashoffset: 0; }
  100% { stroke-dashoffset: 20; }
}
```

**Efekt**: Animacja "przepływu" wzdłuż strzałek

### 1.3 Node shapes i rozmiary

#### Różne rozmiary według typu
```css
/* MOC/Dashboards - duże */
.graph-view.color-fill[data-tag*="moc"],
.graph-view.color-fill[data-tag*="dashboard"],
.graph-view.color-fill[data-tag*="index"] {
  r: 10 !important;
  stroke-width: 3 !important;
}

/* Folder notes - średnie */
.graph-view.color-fill[data-tag*="folder_note"] {
  r: 6 !important;
  stroke-width: 2 !important;
}

/* Regular notes - małe */
.graph-view.color-fill:not([data-tag]) {
  r: 4 !important;
  stroke-width: 1 !important;
}

/* Archive - bardzo małe */
.graph-view.color-fill[data-tag*="archive"] {
  r: 2 !important;
  opacity: 0.3 !important;
}
```

**Hierarchia wizualna**: Wielkość = ważność

#### Kształty według kategorii (requires SVG hack)
```css
/* Biznes - kwadraty */
.graph-view.color-fill[data-tag*="business"] {
  border-radius: 0 !important; /* próba kwadratów */
}

/* Development - diamenty */
.graph-view.color-fill[data-tag*="development"] {
  transform: rotate(45deg);
}
```

**Ograniczenie**: Graph View używa SVG circles - pełne shapes wymagają plugin

### 1.4 Hover effects i interaktywność

#### Highlight połączonych nodes przy hover
```css
.graph-view.color-fill:hover {
  stroke-width: 4 !important;
  filter: brightness(1.3) drop-shadow(0 0 10px currentColor);
  cursor: pointer;
  z-index: 999;
}

/* Połączone nodes */
.graph-view.color-fill:hover ~ .graph-view.color-line {
  stroke-width: 3 !important;
  opacity: 1 !important;
}
```

**UX**: Łatwiej śledzić połączenia

#### Tooltip rozszerzony (wymaga JavaScript)
```css
.graph-view-tooltip {
  background: rgba(30, 30, 30, 0.95) !important;
  border: 2px solid var(--interactive-accent);
  border-radius: 8px;
  padding: 12px;
  font-size: 14px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.5);
}

.graph-view-tooltip::before {
  content: "📄 ";
}
```

### 1.5 Clustering visual

#### Wyraźne granice klastrów
```css
.graph-view.color-fill[data-tag*="business"] {
  /* Wszystkie business nodes w jednym "obszarze" */
  --cluster-color: #8b5cf6;
}

/* Background dla klastra (SVG pattern) */
.graph-cluster-background[data-cluster="business"] {
  fill: var(--cluster-color);
  opacity: 0.1;
  stroke: var(--cluster-color);
  stroke-width: 2;
  stroke-dasharray: 5,5;
}
```

**Efekt**: Wizualne "strefy" dla kategorii

## 🔌 POZIOM 2: Community Plugins Integration

### 2.1 Graph Analysis Plugin

**Repo**: `SkepticMystic/graph-analysis`
**Status**: ✅ Dostępny w Community Plugins

**Możliwości**:
```javascript
// Community detection (Louvain algorithm)
- Auto-wykrywanie klastrów tematycznych
- Centrality analysis (które notes są "hubami")
- Bridge detection (które notes łączą różne obszary)
- Clustering coefficient (gęstość połączeń)

// Page Rank
- Ranking ważności notes (jak Google PageRank)
- Top 10 most important notes in vault

// Shortest Path
- Znajdź najkrótszą ścieżkę między dwoma notes
- Wizualizacja "drogi myślowej"
```

**Przykładowa konfiguracja**:
```json
{
  "enableCommunityDetection": true,
  "showCentrality": true,
  "hubThreshold": 5,
  "colorByCluster": true,
  "minClusterSize": 3
}
```

**Zastosowanie w eww**:
- Auto-wykryj klastry: business/, dev/, docs/, usr/
- Ranking: TOP 10 folder notes według centrality
- Bridges: które notes łączą business z dev?

### 2.2 Extended Graph Plugin

**Repo**: `SkepticMystic/obsidian-extended-graph`
**Status**: ✅ Już używane w eww

**Zaawansowane features**:
```json
{
  // Filtrowanie po properties
  "filterByProperties": {
    "status": "active",
    "priority": ["high", "medium"]
  },

  // Layers (warstwy grafu)
  "enableLayers": true,
  "layers": [
    {"name": "Core", "filter": "path:core/"},
    {"name": "Business", "filter": "path:business/"},
    {"name": "Users", "filter": "path:usr/"}
  ],

  // Dynamic clustering
  "clusterByColor": true,
  "clusterStrength": 0.8,
  "interClusterRepulsion": 50,

  // Image support
  "imagesFromProperty": true,
  "imageProperty": "thumbnail",
  "showImagesOnNodes": true
}
```

**NEXT LEVEL dla eww**:
1. **Layers**: Przełączaj między core/business/usr jednym kliknięciem
2. **Properties filtering**: Pokaż tylko notes ze status:active
3. **Images on nodes**: Dodaj ikony/thumbnails do folder notes

### 2.3 Breadcrumbs Plugin

**Repo**: `SkepticMystic/breadcrumbs`
**Status**: ✅ Dostępny

**Hierarchia w grafie**:
```yaml
---
parent: [[Business Overview]]
child:
  - [[Project A]]
  - [[Project B]]
sibling:
  - [[Related Project]]
---
```

**Graph View enhancement**:
- Pogrubione linki parent → child
- Specjalne kolory dla sibling relations
- Breadcrumb trail visualization

**Implementacja**:
```css
/* CSS dla breadcrumbs */
.graph-view.color-line[data-breadcrumb="parent"] {
  stroke: #3b82f6 !important;
  stroke-width: 3 !important;
}

.graph-view.color-line[data-breadcrumb="sibling"] {
  stroke: #10b981 !important;
  stroke-dasharray: 5,3 !important;
}
```

### 2.4 Journey Plugin

**Repo**: `akaalias/obsidian-journey-plugin`
**Status**: ✅ Dostępny

**Story-based navigation**:
- Definicja "podróży" przez notes
- Wizualizacja flow diagramów w grafie
- Step-by-step guidance

**Use case dla eww**:
```markdown
# Business Process Flow
journey-start: [[Idea]]
journey-steps:
  1. [[Planning]]
  2. [[Development]]
  3. [[Testing]]
  4. [[Deployment]]
journey-end: [[Production]]
```

**Graph visualization**: Podświetlona ścieżka przez graf

### 2.5 Strange New Worlds Plugin

**Repo**: `TfTHacker/obsidian42-strange-new-worlds`
**Status**: ✅ Dostępny

**Smart connections**:
- Auto-sugestie podobnych notes
- "You might also like..." w grafie
- Semantic similarity (nie tylko linki)

**AI-powered linking**:
```json
{
  "enableSemanticSimilarity": true,
  "similarityThreshold": 0.7,
  "showSuggestionsInGraph": true,
  "maxSuggestions": 5
}
```

**Efekt**: Graf pokazuje nie tylko istniejące linki, ale i **potencjalne** połączenia

## 🚀 POZIOM 3: Advanced Techniques (Hacki i workarounds)

### 3.1 Multi-dimensional Graph (3D simulation)

**Technika**: Używaj Z-index jako "trzeciego wymiaru"

```css
/* Layer 1: Core (dół) */
.graph-view.color-fill[data-tag*="core"] {
  z-index: 10;
  opacity: 0.6;
}

/* Layer 2: Business (środek) */
.graph-view.color-fill[data-tag*="business"] {
  z-index: 20;
  opacity: 0.8;
}

/* Layer 3: Users (góra) */
.graph-view.color-fill[data-tag*="jakubc"],
.graph-view.color-fill[data-tag*="karinam"] {
  z-index: 30;
  opacity: 1;
}
```

**Pseudo-3D effect**: Nodes "unoszą się" nad innymi

### 3.2 Time-based visualization

**Idea**: Kolor nodes według daty utworzenia/modyfikacji

```javascript
// Wymaga custom plugin lub Templater
// W YAML frontmatter:
created: 2025-11-23
age_days: <% (Date.now() - new Date('2025-11-23')) / 86400000 %>
```

```css
/* Stare notes - szare */
.graph-view.color-fill[data-age-days*="365"] {
  filter: grayscale(0.8);
  opacity: 0.5;
}

/* Nowe notes (0-30 dni) - intensywne kolory */
.graph-view.color-fill[data-age-days*="30"] {
  filter: brightness(1.3) saturate(1.5);
}
```

**Rezultat**: "Mapa cieplna" aktywności w vault

### 3.3 Dataview-powered dynamic colors

**Integracja z Dataview**:

```dataview
TABLE
  file.name AS "Note",
  length(file.outlinks) AS "Outlinks",
  choice(length(file.outlinks) > 20, "🔴 Hub",
         length(file.outlinks) > 10, "🟡 Important",
         "🟢 Regular") AS "Status"
WHERE file.name
SORT length(file.outlinks) DESC
```

**Auto-tag hubs**:
```javascript
// Templater script
<%*
const outlinks = tp.file.cursor_position.line.match(/\[\[/g)?.length || 0;
if (outlinks > 20) {
  tp.file.create_new.append("tags: [hub, important]");
}
%>
```

**Graph CSS**:
```css
.graph-view.color-fill[data-tag*="hub"] {
  r: 12 !important;
  stroke: #ff0000 !important;
  stroke-width: 4 !important;
  filter: drop-shadow(0 0 10px #ff0000);
}
```

### 3.4 Export to external tools

**Graphviz export**:
```bash
# Skrypt eww-graph generuje DOT format
./tools/bin/eww-graph

# Output:
# - eww-full.svg (hierarchical)
# - eww-force.svg (force-directed)
# - eww-spring.svg (spring layout)
# - index.html (interactive viewer)
```

**D3.js integration**:
```javascript
// Możliwość: Export graph.json → D3.js visualization
// Custom HTML z interaktywnością:
// - Zoom/Pan
// - Search nodes
// - Filter by tags
// - Time-lapse animation
```

**Neo4j graph database**:
```cypher
// Import Obsidian vault do Neo4j
// Query: Znajdź wszystkie ścieżki między dwoma notes
MATCH path = shortestPath(
  (a:Note {name: "Core"})-[*]-(b:Note {name: "Business"})
)
RETURN path
```

### 3.5 Live collaboration colors

**Multi-user vault**: Różne kolory według autora

```yaml
---
author: jakubc
last_editor: karinam
---
```

```css
/* jakubc - niebieski border */
.graph-view.color-fill[data-author*="jakubc"] {
  stroke: #3b82f6 !important;
  stroke-width: 2 !important;
}

/* karinam - różowy border */
.graph-view.color-fill[data-author*="karinam"] {
  stroke: #ec4899 !important;
  stroke-width: 2 !important;
}

/* Współautorstwo - gradient border */
.graph-view.color-fill[data-author*="jakubc"][data-editor*="karinam"] {
  stroke: url(#collab-gradient) !important;
  stroke-width: 3 !important;
}
```

## 🔮 POZIOM 4: Future Features (Community wishlist)

### 4.1 Native 3D Graph View

**Status**: 🔶 Highly requested, not confirmed

**Potencjał**:
- Prawdziwa wizualizacja 3D (nie pseudo)
- WebGL rendering (lżejsze niż SVG)
- VR support (Obsidian w VR!)
- Layers jako fizyczne poziomy

**Inspiracje**:
- Roam Research 3D graph experiments
- Notion timeline view
- Obsidian Canvas (już 2D infinite canvas)

**Plugin opportunity**: `obsidian-3d-graph` (community może zbudować)

### 4.2 AI-powered graph insights

**Status**: 🟢 Możliwe z API

**Features**:
```javascript
// GPT-4 analysis grafu:
- "Which notes are conceptually similar but not linked?"
- "Suggest missing links based on content"
- "Auto-generate folder notes from graph structure"
- "Detect isolated knowledge silos"
- "Recommend daily note based on graph traversal"
```

**Implementacja**:
```python
# Python script + Obsidian API
import openai
import json

# Load graph.json
with open('.obsidian/graph.json') as f:
    graph = json.load(f)

# Analyze
prompt = f"Analyze this knowledge graph and suggest improvements: {graph}"
suggestions = openai.ChatCompletion.create(
    model="gpt-4",
    messages=[{"role": "user", "content": prompt}]
)
```

### 4.3 Timeline Graph View

**Status**: 🔶 Community plugin możliwy

**Koncept**:
- Oś X = czas (created/modified date)
- Oś Y = kategoria (business/dev/docs)
- Nodes = events
- Links = chronological flow

**Visualizations**:
- Project timeline
- Evolution of ideas
- Knowledge growth over time
- Git-like branch visualization

**CSS mockup**:
```css
.graph-view-timeline {
  display: grid;
  grid-template-columns: auto 1fr;
  grid-template-rows: repeat(12, 1fr); /* 12 months */
}

.timeline-node {
  position: absolute;
  left: calc(var(--days-since-start) * 1px);
  top: calc(var(--category-index) * 50px);
}
```

### 4.4 Graph Diff View

**Status**: 🟡 Experimental

**Use case**: Wizualizacja zmian w grafie

```bash
# Porównaj graf dzisiaj vs 30 dni temu
git diff HEAD~30 .obsidian/graph.json

# Wizualizacja:
# - Zielone nodes = nowe notes
# - Czerwone nodes = usunięte notes
# - Żółte nodes = zmodyfikowane notes
# - Grubsze linki = nowe połączenia
```

**Implementacja**:
```javascript
// Plugin: Graph History
- Snapshot graph.json codziennie
- Slider: "View graph as of [date]"
- Animation: "Play" evolution of graph
- Heatmap: most active areas of vault
```

### 4.5 Collaborative real-time graph

**Status**: 🔴 Requires major infrastructure

**Vision**:
- Multi-user editing w real-time
- Live cursors na grafie (jak Figma)
- Comment threads na nodes/links
- Version control integrated

**Tech stack**:
```
- Obsidian Sync (backend)
- WebSocket (real-time)
- CRDT (conflict resolution)
- Canvas API (for cursors)
```

**Use case**: Team knowledge management

## 📋 Roadmap dla eww project

### Faza 1: CSS Mastery (TERAZ - 2025 Q4)
- [ ] Implementacja animacji (pulse, glow)
- [ ] Kolorowe strzałki według typu relacji
- [ ] Różne rozmiary nodes (MOC > folder_note > regular)
- [ ] Hover effects z highlight
- [ ] Clustering backgrounds

**Effort**: Low (tylko CSS)
**Impact**: High (lepsze UX)

### Faza 2: Plugins Integration (2025 Q4 - 2026 Q1)
- [ ] Graph Analysis: community detection
- [ ] Extended Graph: layers dla core/business/usr
- [ ] Breadcrumbs: hierarchia parent/child
- [ ] Strange New Worlds: semantic suggestions
- [ ] Journey: process flows

**Effort**: Medium (instalacja + config)
**Impact**: Very High (nowe możliwości)

### Faza 3: Advanced Techniques (2026 Q1-Q2)
- [ ] Pseudo-3D z z-index layers
- [ ] Time-based colors (age of notes)
- [ ] Dataview integration (auto-tag hubs)
- [ ] Export do D3.js/Graphviz
- [ ] Live collaboration colors (jakubc/karinam)

**Effort**: Medium-High (scripting)
**Impact**: Medium (nice-to-have)

### Faza 4: Eksperymentalna (2026 Q2+)
- [ ] 3D Graph plugin (community?)
- [ ] AI insights script (GPT-4 analysis)
- [ ] Timeline view experiment
- [ ] Graph diff visualization
- [ ] Custom interactive HTML export

**Effort**: Very High (development)
**Impact**: High (cutting edge)

## 🎓 Najlepsze praktyki społeczności

### 1. Reddit r/ObsidianMD

**Top insights**:
- "Color groups limit: 18 max for performance"
- "Local graph > Global graph for big vaults"
- "CSS animations: keep it subtle (accessibility)"
- "Export to SVG for presentations"

### 2. Obsidian Discord #graph-view

**Pro tips**:
- Use `collapse-display: true` dla lepszej organizacji color groups
- `textFadeMultiplier: -1` = tekst zawsze widoczny
- Regex w queries: `path:/docs\/(guide|setup)/`
- Physics tuning: start z MEDIUM, potem dostosuj

### 3. Obsidian Forum Feature Requests

**Most wanted**:
1. Native 3D graph (500+ votes)
2. Graph timeline view (300+ votes)
3. Better mobile graph (250+ votes)
4. Export to other formats (200+ votes)
5. Graph animations (150+ votes)

### 4. GitHub - obsidianmd/obsidian-releases

**Planned features** (z issues):
- Improved graph performance (in progress)
- Better color picker (planned)
- Node shapes (under consideration)
- Graph API for plugins (discussed)

## 🛠️ Narzędzia i zasoby

### CSS Snippets Libraries
1. **Obsidian Hub** - https://publish.obsidian.md/hub/
2. **GitHub Topic: obsidian-css** - Community snippets
3. **Obsidian Roundup** - Newsletter z new CSS tricks

### Plugins do eksploracji
1. **Graph Analysis** - SkepticMystic/graph-analysis
2. **Extended Graph** - SkepticMystic/obsidian-extended-graph
3. **Breadcrumbs** - SkepticMystic/breadcrumbs
4. **Journey** - akaalias/obsidian-journey-plugin
5. **Strange New Worlds** - TfTHacker/obsidian42-strange-new-worlds
6. **Juggl** - HEmile/juggl (alternative graph view)
7. **Excalidraw** - zsviczian/obsidian-excalidraw-plugin (drawing on graph)

### External Tools Integration
1. **Graphviz** - DOT language export (już w eww)
2. **D3.js** - Interactive web graphs
3. **Neo4j** - Graph database queries
4. **Gephi** - Advanced graph analysis desktop app
5. **Cytoscape** - Biological network viz (adaptable)

### Inspiration Galleries
1. **Obsidian Showcase** - Community graph screenshots
2. **Roam Research graphs** - Alternative approaches
3. **Notion relation graphs** - Simplified but elegant
4. **Logseq graphs** - Outliner-based networks

## 💡 Kreatywne zastosowania

### 1. "Knowledge Heatmap"
Kolor nodes = częstotliwość edycji

### 2. "Idea Evolution Timeline"
Graf z osią czasu pokazujący rozwój konceptów

### 3. "Project Dependency Visualizer"
Business processes jako flow diagram

### 4. "Team Collaboration Map"
Kto pracuje nad czym (multi-author colors)

### 5. "Learning Path Graph"
Journey przez materiały edukacyjne

### 6. "Decision Tree Navigator"
If-then logic jako rozgałęzienia grafu

### 7. "Second Brain Dashboard"
Central hub łączący wszystkie obszary życia

### 8. "Zettelkasten Atomic Notes"
Graf atomic notes z emergent structures

## 📊 Metryki sukcesu

Jak mierzyć "dobry" graf:

1. **Performance**: Render time <2s dla >500 nodes
2. **Clarity**: Wyraźne klastry, minimal overlap
3. **Navigation**: Łatwo znaleźć related notes
4. **Aesthetics**: Przyjemny wizualnie, spójne kolory
5. **Utility**: Faktycznie używany daily (nie tylko cool)

**Narzędzia pomiarowe**:
```javascript
// Graph metrics
- Clustering coefficient (gęstość)
- Average path length (łatwość nawigacji)
- Modularity (separacja klastrów)
- Centrality distribution (hubs vs leaves)
- Render performance (FPS, memory)
```

## 🎯 Rekomendacje finalne

### Dla małych vault (<100 notes):
✅ **Zacznij od**: CSS animations, color groups
⚠️ **Unikaj**: Over-engineering, zbyt wiele plugins

### Dla średnich vault (100-500 notes):
✅ **Dodaj**: Graph Analysis, Extended Graph, Breadcrumbs
✅ **Eksperymentuj**: Pseudo-3D layers, time-based colors
⚠️ **Zachowaj**: Performance (filtry obowiązkowo)

### Dla dużych vault (500-1000 notes):
✅ **Must-have**: Multi-graph strategy, advanced filtering
✅ **Consider**: External tools (D3.js, Neo4j)
✅ **Optimize**: Physics params, CSS performance
❌ **Nie próbuj**: Global graph bez filtrów

### Dla bardzo dużych vault (>1000 notes):
✅ **Strategia**: Dashboards + local graphs only
✅ **Tooling**: Custom export scripts, external visualization
✅ **Team**: Multi-user collaboration features
❌ **Forget**: Single global graph (nieużywalny)

## 🚀 Call to Action - Co zrobić TERAZ

### Quick Wins (1-2 godziny):
1. Dodaj CSS animations do `.obsidian/snippets/graph-animations.css`
2. Skonfiguruj kolorowe strzałki według typu relacji
3. Dostosuj rozmiary nodes (MOC > folder_note > regular)
4. Włącz Graph Analysis plugin i uruchom community detection

### Weekend Project (1-2 dni):
1. Zainstaluj Extended Graph i skonfiguruj layers
2. Dodaj Breadcrumbs z parent/child relations
3. Stwórz custom export do D3.js (interactive HTML)
4. Zbuduj Timeline view experiment

### Long-term (1-3 miesiące):
1. Develop custom plugin dla eww-specific needs
2. Integracja z AI (GPT-4 graph insights)
3. Build collaborative features (jakubc + karinam)
4. Contribute to community (share snippets/plugins)

---

**Autor**: jakubc
**Data utworzenia**: 2025-11-23
**Źródła**: Obsidian community (Reddit, Discord, Forum), GitHub, eww project experience
**Status**: 🚀 Living document - będzie aktualizowany

**Powiązane dokumenty**:
- [[graph-view-limits]] - Limity techniczne
- [[installation-guide]] - Jak zainstalować base setup
- [[presets]] - Gotowe presety
- [[colors]] - System kolorów (18 grup)
- [[CHANGELOG]] - Historia rozwoju

**Community**:
- Reddit: r/ObsidianMD
- Discord: https://discord.gg/obsidianmd
- Forum: https://forum.obsidian.md/c/graph-view
- GitHub: https://github.com/obsidianmd/obsidian-releases
