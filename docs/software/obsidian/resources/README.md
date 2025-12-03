---
version: 0.0.2
tags:
  - #obsidian
  - #resources
  - #docs
  - #community
created: 2025-11-24
modified: 2025-11-28
author: jakubc
title: "Zasoby Obsidian - Community & Developer"
owner: jakubc
---

# Zasoby Obsidian - Community & Developer

Kompletna kolekcja zasobów Obsidian z oficjalnych i community źródeł.

## 📁 Struktura

### 1. **api/** - Obsidian API Documentation
Dokumentacja API dla deweloperów pluginów.

- **Źródło:** https://github.com/obsidianmd/obsidian-api
- **Zawartość:**
  - TypeScript definitions
  - API reference
  - Plugin development guide
  - Event handlers
  - Vault API
  - Editor API

**Użycie:** Jeśli tworzysz własne pluginy lub chcesz zrozumieć jak działają.

### 2. **releases/** - Changelogi i Release Notes
Historia wszystkich wersji Obsidian.

- **Źródło:** https://github.com/obsidianmd/obsidian-releases
- **Zawartość:**
  - Release notes dla Desktop
  - Release notes dla Mobile
  - Plugin updates
  - Breaking changes
  - community-plugins.json (lista wszystkich community plugins)
  - community-plugin-stats.json (statystyki downloads)

**Użycie:** 
- Sprawdź co nowego w najnowszej wersji
- Zobacz breaking changes przed upgrade
- Lista ALL community plugins

### 3. **hub/** - Obsidian Hub (Community Wiki)
Ogromne community wiki z 6000+ stron.

- **Źródło:** https://github.com/obsidian-community/obsidian-hub
- **Zawartość:**

#### 📁 02 - Community Expansions/
- **02.01 Plugins by Category/** - Setki pluginów według kategorii
  - Note editing
  - Task management
  - Daily notes
  - Calendar & time
  - Charts & graphs
  - Databases
  - Import/Export
  - Templates
  - i wiele więcej...
  
- **02.02 Themes by Category/** - Setki themes
  - Dark themes
  - Light themes
  - Minimal themes
  - Colorful themes
  
- **02.03 CSS Snippets by Category/** - Gotowe CSS snippets
  - Editor styling
  - Graph view
  - Tables
  - Callouts
  - Checkboxes
  
- **02.04 Auxiliary Tools/** - Narzędzia zewnętrzne
  - Mobile apps
  - CLI tools
  - Web tools
  
- **02.05 All Community Expansions/** - Pełne listy

#### 📁 04 - Guides, Workflows, & Courses/
- **Guides/** - Tutoriale i przewodniki
  - Getting started
  - Advanced workflows
  - Plugin tutorials
  - CSS customization
  
- **Courses/** - Kursy online
  - Free courses
  - Paid courses
  
- **Community Talks/** - Prezentacje i talki

#### 📁 03 - Showcases & Templates/
- **Templates/** - Gotowe szablony
  - Daily notes
  - Meeting notes
  - Project management
  - Zettelkasten
  
- **Vaults/** - Przykładowe vaults
  - PKM vaults
  - Study vaults
  - Work vaults
  
- **Dashboards/** - Przykładowe dashboardy
- **Plugin Showcases/** - Demo pluginów
- **Publish Sites/** - Przykłady Obsidian Publish

#### 📁 01 - Community/
- **People/** - Twórcy, contributors
- **Video Channels/** - YouTube channels
- **Events/** - Community events
- **Obsidian Roundup/** - Newsletter

#### 📁 05 - Concepts/
- PKM concepts
- Note-taking methodologies
- Zettelkasten
- PARA method
- Atomic notes

### 4. **awesome/** - Awesome Obsidian
Kurowana lista najlepszych zasobów.

- **Źródło:** https://github.com/kmaasrud/awesome-obsidian
- **Zawartość:**
  - README.md - główna lista
  - Best plugins
  - Best themes
  - Best tools
  - Learning resources
  - Community resources

## 📊 Statystyki

| Zasób | Rozmiar | Plików | Opis |
|-------|---------|--------|------|
| **api/** | 388 KB | ~50 | API docs |
| **releases/** | ~5 MB | ~100 | Changelogi |
| **hub/** | ~50 MB | ~4000 | Community wiki (selekcja) |
| **awesome/** | 39 MB | 2 | Kurowana lista |
| **RAZEM** | ~95 MB | ~4150 | |

## 🎯 Jak używać

### Dla użytkowników
1. **Szukaj pluginów:** `hub/02 - Community Expansions/02.01 Plugins by Category/`
2. **Szukaj themes:** `hub/02 - Community Expansions/02.02 Themes by Category/`
3. **Gotowe CSS:** `hub/02 - Community Expansions/02.03 CSS Snippets by Category/`
4. **Tutoriale:** `hub/04 - Guides, Workflows, & Courses/Guides/`
5. **Szablony:** `hub/03 - Showcases & Templates/Templates/`

### Dla deweloperów
1. **API docs:** `api/`
2. **Plugin examples:** `hub/02.01 Plugins by Category/`
3. **Changelogi:** `releases/`
4. **Community standards:** `hub/00 - Contribute to the Obsidian Hub/`

## 🔗 Źródła online

- **Obsidian Help:** https://help.obsidian.md/
- **Obsidian Forum:** https://forum.obsidian.md/
- **Obsidian Hub:** https://publish.obsidian.md/hub/
- **Discord:** https://discord.gg/obsidianmd
- **Reddit:** https://reddit.com/r/ObsidianMD

## 🔄 Aktualizacja

```bash
cd /tmp

# Pobierz wszystkie repo
git clone --depth 1 https://github.com/obsidianmd/obsidian-api.git
git clone --depth 1 https://github.com/obsidianmd/obsidian-releases.git
git clone --depth 1 https://github.com/obsidian-community/obsidian-hub.git
git clone --depth 1 https://github.com/kmaasrud/awesome-obsidian.git

# Skopiuj do EWW
cd /home/jakubc/git/eww/docs/infra/software/obsidian/resources
rm -rf api releases hub awesome

cp -r /tmp/obsidian-api ./api/
cp -r /tmp/obsidian-releases ./releases/
cp -r /tmp/awesome-obsidian ./awesome/

# Hub - selekcja (nie wszystko!)
mkdir -p hub
cd /tmp/obsidian-hub
cp -r "02 - Community Expansions" \
      "04 - Guides, Workflows, & Courses" \
      "03 - Showcases & Templates" \
      "01 - Community" \
      "05 - Concepts" \
      "00 - Start here.md" \
      "🗂️ hub.md" \
      README.md \
      /home/jakubc/git/eww/docs/infra/software/obsidian/resources/hub/

# Sprzątanie
rm -rf /tmp/obsidian-*
echo "✅ Zaktualizowano wszystkie zasoby"
```

## 📝 Notatki

- **Hub** - zawiera OGROMNĄ ilość informacji (6000+ plików w oryginale)
- Skopiowaliśmy **najważniejsze katalogi** (~4000 plików)
- Pominęliśmy `06 - Inbox` (work in progress)
- Attachments są współdzielone

## 🔗 Powiązane

- [[../official-en/]] - Oficjalna dokumentacja EN
- [[../official-pl/]] - Polska dokumentacja
- [[../TRANSLATION-STATUS]] - Status tłumaczeń
- [[../README]] - Główna dokumentacja Obsidian

---

**Data pobrania:** 2025-11-22  
**Źródła:** GitHub (obsidianmd, obsidian-community)  
**Wielkość:** ~95 MB (~4150 plików)

## 🔗 Backlinks

- [[docs/software/obsidian/resources/resources]]
- [[docs/docs]]
- [[INDEX]]