---
version: 0.0.2
title: "STUDY-NOTES"
created: 2025-11-24
modified: 2025-11-28
tags:
  - auto-versioned
---

# OBSIDIAN - Notatki ze studiowania dokumentacji

## 📚 KLUCZOWE KONCEPTY

### 1. VAULT (Skarbiec)
- Folder lokalny gdzie Obsidian przechowuje notatki
- Plain text markdown files
- Można mieć wiele vaultów (jeden na projekt)
- Vault = folder + .obsidian/ (konfiguracja)

### 2. CORE PLUGINS (27 wbudowanych)

#### Search (Wyszukiwarka) - KLUCZOWY!
**Operators:**
- `file:` - szukaj w nazwie pliku
- `path:` - szukaj w ścieżce
- `content:` - szukaj w treści
- `tag:` - szukaj tagu (szybsze niż full-text)
- `line:` - linie pasujące do wzorca
- `block:` - w tym samym bloku
- `section:` - w sekcji (między headingami)
- `task:` / `task-todo:` / `task-done:` - zadania
- `[property]` - szukaj po properties
- `[property:value]` - property z wartością

**Search terms:**
- `word1 word2` - oba słowa (AND)
- `word1 OR word2` - którekolwiek (OR)
- `"exact phrase"` - dokładna fraza
- `-word` - negacja (NOT)
- `meeting (work OR meetup)` - grupowanie ()
- `[duration:<5]` - operatory < >

**Przykłady:**
- `tag:#obsidian path:docs/` - tagi obsidian w docs
- `task-todo:call` - nieukończone zadania z "call"
- `[status:Draft OR Published]` - property status = Draft lub Published
- `meeting -work` - meeting ale nie work

#### Quick Switcher (Ctrl+O)
- Szybkie przełączanie między notatkami
- Search by name or alias
- `Enter` - otwórz
- `Shift+Enter` - utwórz nową (nawet jeśli podobne istnieją)
- `Ctrl+Enter` - otwórz w nowym tabie
- Pusta fraza = ostatnie notatki
- Vault >10k items = prostszy algorytm (performance)

#### Templates
**Template variables:**
- `{{title}}` - tytuł aktywnej notatki
- `{{date}}` - dzisiejsza data (YYYY-MM-DD)
- `{{time}}` - obecny czas (HH:mm)
- `{{date:YYYY-MM-DD}}` - custom format (Moment.js)
- `{{time:HH:mm:ss}}` - custom time format

**Użycie:**
1. Ustaw folder z templates (Settings → Templates)
2. Ribbon → "Insert template"
3. Wybierz template
4. Variables są automatycznie zastępowane

#### Graph View
- Wizualizacja połączeń między notatkami
- Color groups (tagi, ścieżki)
- Forces (physics simulation)
- Global vs Local graph
- Filters (tags, attachments, orphans, path)

### 3. PROPERTIES (Front Matter)

**Typy:**
- Text
- List
- Number
- Checkbox
- Date
- Date & time
- Tags

**Default properties:**
- `tags:` - tagi
- `aliases:` - aliasy nazwy notatki
- `cssclasses:` - custom CSS classes

**Użycie:**
- `Ctrl+;` - dodaj property
- `---` na początku pliku
- Merge z templates
- Search: `[property:value]`
- Display modes: Visible / Hidden / Source

**Przykład:**
```yaml
---
tags:
  - #project
  - #urgent
aliases:
  - "Project Alpha"
status: Draft
due: 2025-12-31
priority: 1
---
```

### 4. MARKDOWN OBSIDIAN FLAVORED

#### Links
- `[[Note name]]` - internal link
- `[[Note name|Alias]]` - link z aliasem
- `[[Note name#Heading]]` - link do heading
- `[[Note name#^block-id]]` - link do bloku
- `![[Note name]]` - embed notatki

#### Tags
- `#tag` - prosty tag
- `#tag/subtag` - zagnieżdżony tag
- Nested tags: `#work/project/alpha`

#### Callouts (Admonitions)
```markdown
> [!note] Title
> Content

> [!tip]
> [!warning]
> [!error]
> [!info]
> [!question]
> [!example]
> [!quote]
```

#### Tasks
```markdown
- [ ] Zadanie do zrobienia
- [x] Zadanie wykonane
- [>] Przekazane
- [<] Zaplanowane
```

### 5. EDITING & FORMATTING

**Live Preview vs Source Mode:**
- Live Preview - WYSIWYG-like editing
- Source Mode - raw markdown
- `Ctrl+E` - toggle

**Multiple cursors:**
- `Ctrl+Click` - dodaj cursor
- `Alt+Shift+Up/Down` - duplikuj linię

**Folding:**
- Headings można zwijać
- Lists można zwijać
- Fold/Unfold all

**Shortcuts:**
- `Ctrl+B` - bold
- `Ctrl+I` - italic
- `Ctrl+K` - insert link
- `Ctrl+]` - indent
- `Ctrl+[` - unindent

### 6. ORGANIZATION

**Folders:**
- Plain filesystem folders
- No special meaning to Obsidian
- Organization = twoja sprawa

**Tags vs Folders:**
- Folders - physical organization
- Tags - logical categories
- Can use both!

**MOC (Maps of Content):**
- Index notes linking to related notes
- Hub notes for topics
- Dashboard notes

### 7. OBSIDIAN ARCHITECTURE

**Vault structure:**
```
MyVault/
├── .obsidian/           # Configuration
│   ├── graph.json       # Graph settings
│   ├── workspace.json   # Layout
│   ├── plugins/         # Community plugins
│   └── snippets/        # CSS snippets
├── Notes/               # Your folders
├── Attachments/         # Images, PDFs
└── Templates/           # Templates
```

**Data storage:**
- Plain text `.md` files
- Human-readable
- Git-friendly
- No lock-in
- Portable

### 8. EXTENDING OBSIDIAN

**Community Plugins:**
- Dataview - query language
- Templater - advanced templates
- Calendar - calendar view
- Tasks - task management
- Kanban - kanban boards
- Excalidraw - drawings
- i setki innych...

**CSS Snippets:**
- Custom styling
- `.obsidian/snippets/`
- Toggle in Settings → Appearance

**Themes:**
- Complete UI redesign
- Community themes
- Light/Dark modes

### 9. WORKFLOW PATTERNS

**Zettelkasten:**
- Atomic notes (one idea per note)
- Unique IDs
- Heavy linking
- Evergreen notes

**PARA:**
- Projects
- Areas
- Resources
- Archives

**Johnny Decimal:**
- 10.00-19.99 kategorie
- 10.01, 10.02 podkategorie
- Numeryczna organizacja

**Daily Notes:**
- Jedna notatka na dzień
- Template z date
- Journal entries
- Links do projektów

### 10. PERFORMANCE TIPS

**Large vaults (>10k notes):**
- Disable orphans in graph
- Disable attachments in graph
- Use filters in search
- Increase repelStrength
- Consider multiple vaults

**Search optimization:**
- Use `tag:` zamiast full-text dla tagów
- Use `path:` do ograniczenia scope
- Use operators przed full-text
- Specific queries = faster

**Graph optimization:**
- hideUnresolved: true
- showOrphans: false
- Increase linkDistance
- Decrease nodeSizeMultiplier

## 🎯 NAJWAŻNIEJSZE DLA EWW

1. **Search operators** - master tego!
2. **Properties** - structured data
3. **Templates** - consistency
4. **Graph color groups** - visual organization
5. **Tags + Folders** - dual organization
6. **Quick Switcher** - speed
7. **Callouts** - structured content
8. **Links + Embeds** - connections

## 🔧 DO PRZETŁUMACZENIA NAJPIERW

1. Getting started (11) - podstawy
2. Search - kluczowy plugin
3. Quick switcher - codzienne użycie
4. Templates - consistency
5. Properties - structured data
6. Graph view - już mamy!
7. Editing and formatting - markdown
8. Tags - organization

## 📝 CUSTOM DLA EWW

- Properties dla urządzeń (specs, location, status)
- Templates dla: TODO, hardware docs, network docs
- Tags hierarchy: #eww #core #infra #jakubc #karinam
- MOC notes dla każdego głównego obszaru
- Graph groups dopasowane do naszej struktury

## 🔗 Backlinks

- [[docs/software/obsidian/obsidian]]
- [[docs/docs]]
- [[INDEX]]