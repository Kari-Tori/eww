---
tags:
  - #obsidian
  - #docs
  - #translation
  - #eww
created: 2025-11-22T19:47:00Z
modified: 2025-11-22T19:47:00Z
author: jakubc
title: "Dokumentacja Obsidian - EN/PL"
owner: jakubc
---

# Dokumentacja Obsidian - EN/PL

Pełna dokumentacja Obsidian w dwóch wersjach językowych:
- **`official-en/`** - Oryginalna dokumentacja angielska (referencja)
- **`official-pl/`** - Polska wersja (tłumaczenie + dostosowanie do EWW)

## 📚 Struktura dokumentacji

### ✅ Pełna dokumentacja (203 pliki)

```
official-en/                           official-pl/
├── Getting started/   (11 plików)    ├── Getting started/   (TODO)
├── Editing and formatting/  (12)     ├── Editing and formatting/  (TODO)
├── User interface/    (10)           ├── User interface/    (TODO)
├── Files and folders/ (6)            ├── Files and folders/ (TODO)
├── Linking notes and files/ (3)      ├── Linking notes and files/ (TODO)
├── Plugins/           (27)           ├── Plugins/           (1/27) ✅ Graph
├── Import notes/      (13)           ├── Import notes/      (TODO)
├── Extending Obsidian/ (5)           ├── Extending Obsidian/ (TODO)
├── Obsidian/          (8)            ├── Obsidian/          (TODO)
├── Obsidian Sync/     (14)           ├── Obsidian Sync/     (TODO)
├── Obsidian Publish/  (15)           ├── Obsidian Publish/  (TODO)
├── Obsidian Web Clipper/ (8)         ├── Obsidian Web Clipper/ (TODO)
├── Bases/             (7)            ├── Bases/             (TODO)
├── Teams/             (6)            ├── Teams/             (TODO)
├── Licenses and payment/ (6)         ├── Licenses and payment/ (TODO)
├── Contributing to Obsidian/ (4)     ├── Contributing to Obsidian/ (TODO)
└── Attachments/       (46 obrazów)   └── Attachments/       (współdzielone)
```

## 🎯 Priorytet tłumaczenia

### 1. **Getting started** (11 plików) 🔴 WYSOKI
- [ ] Download and install Obsidian.md
- [ ] Create a vault.md
- [ ] Create your first note.md
- [ ] Link notes.md
- [ ] Sync your notes across devices.md
- [ ] Import notes.md
- [ ] Update Obsidian.md
- [ ] Back up your Obsidian files.md
- [ ] Use the mobile app.md
- [ ] Sandbox vault.md
- [ ] Glossary.md

### 2. **Plugins (Core)** (27 plików) 🔴 WYSOKI
- [x] Graph view.md ✅
- [ ] Search.md (11 KB - duży!)
- [ ] Quick switcher.md
- [ ] Templates.md
- [ ] Backlinks.md
- [ ] File explorer.md
- [ ] Command palette.md
- [ ] Daily notes.md
- [ ] Canvas.md
- [ ] + 18 innych

### 3. **Editing and formatting** (12 plików) 🟡 ŚREDNI
- [ ] Basic formatting syntax.md
- [ ] Advanced formatting syntax.md
- [ ] Properties.md
- [ ] Tags.md
- [ ] Callouts.md
- [ ] + 7 innych

### 4. **User interface** (10 plików) 🟡 ŚREDNI
- [ ] Workspace.md
- [ ] Hotkeys.md
- [ ] Appearance.md
- [ ] + 7 innych

### 5. **Pozostałe** (143 pliki) 🟢 NISKI
- Import notes/ (13)
- Obsidian Sync/ (14) - opcjonalne (nie używamy)
- Obsidian Publish/ (15) - opcjonalne
- Bases/ (7) - nowa funkcja
- Teams/ (6) - komercyjne
- i inne...

## 🔄 Workflow tłumaczenia

### Krok 1: Wybierz plik z `official-en/`
```bash
cd /home/jakubc/git/eww/docs/infra/software/obsidian/official-en/Plugins
cat "Search.md"
```

### Krok 2: Utwórz plik PL w `official-pl/`
```bash
cd /home/jakubc/git/eww/docs/infra/software/obsidian/official-pl/Plugins
nano "Search.md"
```

### Krok 3: Przetłumacz i dostosuj
- Przetłumacz tekst na polski
- Dodaj frontmatter YAML:
  ```yaml
  ---
  tags:
    - #obsidian
    - #plugin
    - #core
    - #search
  created: YYYY-MM-DDTHH:MM:SSZ
  modified: YYYY-MM-DDTHH:MM:SSZ
  author: jakubc
  title: "Nazwa pluginu po polsku"
  original: "../official-en/Plugins/Search.md"
  ---
  ```
- Dostosuj do kontekstu EWW (przykłady, screenshoty)
- Dodaj sekcję "🔗 Powiązane" z linkami do innych naszych docs

### Krok 4: Commit
```bash
git add official-pl/Plugins/Search.md
git commit -m "docs(obsidian): przetłumaczono plugin Search"
```

## 📊 Postęp tłumaczenia

### Statystyki
- **Razem plików:** 203
- **Przetłumaczone:** 1 (0.5%)
- **W trakcie:** 0
- **Do zrobienia:** 202

### Gotowe
- ✅ Plugins/Graph view.md

### W trakcie
- (puste)

### Następne w kolejce
1. Getting started/Download and install Obsidian.md
2. Getting started/Create a vault.md
3. Plugins/Search.md
4. Plugins/Quick switcher.md
5. Plugins/Templates.md

## 🔗 Źródło

- **Repo:** https://github.com/obsidianmd/obsidian-help
- **Data pobrania:** 2025-11-22
- **Branch:** main
- **Commit:** Latest (Nov 2025)

## 🔄 Aktualizacja dokumentacji EN

```bash
cd /tmp
rm -rf obsidian-docs-official
git clone --depth 1 https://github.com/obsidianmd/obsidian-help.git obsidian-docs-official

cd /home/jakubc/git/eww/docs/infra/software/obsidian
rm -rf official-en
cp -r /tmp/obsidian-docs-official/en official-en

rm -rf /tmp/obsidian-docs-official
echo "✅ Zaktualizowano dokumentację EN"
```

## 📝 Zasady tłumaczenia

1. **Zachowaj strukturę** - katalogi i nazwy plików identyczne jak EN
2. **Dodaj frontmatter** - każdy plik PL ma YAML z tagami
3. **Link do oryginału** - `original: "../official-en/..."`
4. **Polskie terminy** - vault = skarbiec, note = notatka, plugin = wtyczka
5. **Kontekst EWW** - przykłady z naszego vault
6. **Linki wewnętrzne** - [[plugin-name]] zamiast plain links
7. **Code blocks** - zostawiamy po angielsku (JSON, CSS, etc)
8. **Hotkeys** - zostawiamy (`Ctrl+P`, nie `Ctrl+Szukaj`)

## 🛠️ Narzędzia pomocnicze

### Sprawdź postęp
```bash
# Ile plików przetłumaczonych
find official-pl -name "*.md" | wc -l

# Jakie brakują w danym katalogu
diff <(ls official-en/Plugins) <(ls official-pl/Plugins)
```

### Wyszukaj angielski termin
```bash
grep -r "vault" official-en/Getting\ started/
```

## 🔗 Powiązane

- [[README]] - Główna dokumentacja Obsidian
- [[plugins/core/README]] - Core plugins index
- [[graph/graph-rules]] - Zasady grafu

---

**Status:** 🟡 W trakcie  
**Priorytet:** 1. Getting started, 2. Core plugins, 3. Reszta  
**Następny:** Getting started/Download and install Obsidian.md
