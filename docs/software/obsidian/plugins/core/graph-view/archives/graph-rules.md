---
tags:
  - #obsidian
  - #graph
  - #rules
  - #configuration
  - #docs
  - #eww
created: 2025-11-22T19:29:00Z
modified: 2025-11-22T19:29:00Z
author: jakubc
title: "Graph Rules - Zasady konfiguracji grafu Obsidian"
owner: jakubc
---

# Graph Rules - Zasady konfiguracji grafu Obsidian

## 📋 Cel dokumentu

Ten dokument definiuje **kanoniczne zasady konfiguracji grafu** w Obsidian dla projektu E-Waste Workshop. Wszystkie grupy kolorów są oparte o **rzeczywiste użycie tagów** w repo.

## 🎨 Grupy kolorów - Color Groups

### Aktualizacja: 2025-11-22

Grupy są zdefiniowane w oparciu o analizę 1000+ plików markdown w repo.

| # | Nazwa grupy | Query | Kolor (RGB) | Kolor (Hex) | Użycie |
|---|-------------|-------|-------------|-------------|--------|
| 1 | **folder_note** | `tag:#folder_note` | 9127187 | #8B4D93 | 296 plików |
| 2 | **eww/core** | `tag:#eww OR tag:#automation OR tag:#secondbrain` | 65280 | #00FF00 | 1979 wystąpień |
| 3 | **jakubc** | `tag:#jakubc OR path:usr/jakubc/` | 65535 | #00FFFF | 130 plików |
| 4 | **karinam** | `tag:#karinam OR path:usr/karinam/` | 16711935 | #FF00FF | 25 plików |
| 5 | **star-wars** | `tag:#star-wars OR path:usr/jakubc/hobby/star_wars/` | 16776960 | #FFFF00 | 108 plików |
| 6 | **lego** | `tag:#lego OR path:usr/jakubc/hobby/lego/` | 16744192 | #FF9900 | 8 plików |
| 7 | **docs** | `tag:#docs OR tag:#knowledge OR path:docs/` | 5592575 | #5555FF | 916 plików |
| 8 | **infrastructure** | `tag:#infrastructure OR tag:#Asus_Z77 OR tag:#GERC OR tag:#gerc OR path:docs/infra/` | 10824234 | #A52A9B | 122 pliki |
| 9 | **scripts** | `tag:#scripts OR tag:#bash OR tag:#functions OR path:scripts/ OR path:bin/` | 16733525 | #FF6A55 | 26 plików |
| 10 | **development** | `tag:#development OR tag:#git OR tag:#workflow OR path:dev/` | 6737151 | #66CCFF | 462 pliki |
| 11 | **todo** | `tag:#todo OR tag:#productivity OR tag:#planning` | 16753920 | #FFA500 | 81 plików |
| 12 | **config** | `tag:#config OR path:config/` | 5526612 | #546654 | 10 plików |

## 🎨 Kolory strzałek (Links & Arrows)

### Bazowe kolory
- **Domyślne:** Jasnoszary (#888888, opacity 0.4)
- **Hover:** Pomarańczowy (#ff9900, opacity 0.9)
- **Strzałki:** Jasnoszary (#888888, opacity 0.6)

### Kolorowe strzałki wg kategorii
- **Business:** Fioletowy (#8b5cf6)
- **Infrastructure:** Różowy (#ec4899)
- **Docs/Knowledge:** Niebieski (#3b82f6)
- **Automation:** Zielony (#10b981)
- **TODO/Tasks:** Pomarańczowy (#f59e0b)

### Specjalne
- **Archiwum:** Bardzo cienkie i przezroczyste (opacity 0.2)
- **Hierarchiczne (parent/child):** Pogrubione (width 2.5)

Konfiguracja w: `.obsidian/snippets/graph-style.css`

## 🔧 Inne ustawienia grafu

### Display
```json
{
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1.2,
  "lineSizeMultiplier": 1
}
```

### Forces (Fizyka)
```json
{
  "centerStrength": 0.1,
  "repelStrength": 20,
  "linkStrength": 0.3,
  "linkDistance": 500
}
```

## 📊 Top 40 tagów w repo (2025-11-22)

```
689  #eww
674  #automation
660  #linux
616  #secondbrain
605  #knowledge
431  #development
311  #docs
296  #folder_note
130  #jakubc
129  #obsidian
108  #star-wars
 79  #infrastructure
 55  #productivity
 36  #graph
 30  #shared
 30  #house
 25  #karinam
 23  #Asus_Z77
 22  #git
 21  #todo
 20  #GERC
 17  #notes
 16  #books
 13  #templates
 11  #scripts
 10  #config
  9  #workflow
  8  #lego
  8  #bash
  7  #rules
  7  #raci
  7  #functions
  6  #Lenovo_Y700
  6  #general
  5  #testing
  5  #planning
  5  #ops
  5  #Lenovo_M710q
  5  #gerc
  5  #Dell_T140
```

## 📁 Struktura folderów głównych

```
eww/
├── core/          # Rdzeń systemu
├── config/        # Konfiguracja
├── business/      # Biznes
├── docs/          # Dokumentacja
├── scripts/       # Skrypty
├── tools/         # Narzędzia
├── usr/           # Użytkownicy
│   ├── jakubc/
│   └── karinam/
├── dev/           # Development
├── bin/           # Binaria
├── var/           # Zmienne dane
├── yaml/          # YAML files
├── systemd/       # Systemd units
└── archive/       # Archiwum
```

## 🔄 Procedura aktualizacji

### Jak zaktualizować grupy kolorów:

1. **Analiza tagów:**
   ```bash
   cd /home/jakubc/git/eww
   grep -r "^  - #" --include="*.md" . | sed 's/.*- //' | sort | uniq -c | sort -rn
   ```

2. **Backup aktualnego graph.json:**
   ```bash
   cp .obsidian/graph.json .obsidian/backups/graph.json.$(date +%Y%m%d_%H%M%S)
   ```

3. **Aktualizacja konfiguracji:**
   - Edytuj `colorGroups` w `.obsidian/graph.json`
   - Lub użyj GUI Obsidian: Settings → Graph View → Color Groups

4. **Weryfikacja:**
   ```bash
   cat .obsidian/graph.json | jq '.colorGroups | length'
   ```

5. **Commit zmian:**
   ```bash
   git add .obsidian/graph.json
   git commit -m "feat(graph): zaktualizowano grupy kolorów"
   ```

## 📝 Zasady tworzenia grup

1. **Jeden kolor na główny obszar tematyczny** (nie rozdrabniać)
2. **Łączyć powiązane tagi** (`tag:#foo OR tag:#bar`)
3. **Uwzględnić ścieżki** (`OR path:folder/`)
4. **Sortować według ważności** (najważniejsze na górze)
5. **Testować na rzeczywistych danych** (nie teoretycznych)

## 🔗 Powiązane pliki

- [[.obsidian/graph.json]] - Aktualna konfiguracja
- [[.obsidian/graph-colors.json]] - Extended colors
- [[.obsidian/backups/]] - Backupy konfiguracji
- [[docs/infra/software/obsidian/graph/]] - Ta dokumentacja

## 📋 Historia zmian

| Data | Zmiana | Autor |
|------|--------|-------|
| 2025-11-22 | Utworzono graph-rules.md z aktualnymi grupami | jakubc |
| 2025-11-21 | Ostatnia ręczna konfiguracja | jakubc |

## 🎯 TODO

- [ ] Automatyzacja generowania kolorów z analizy tagów
- [ ] Skrypt do walidacji graph.json
- [ ] Monitor zmian w tagach (CI/CD check)
- [ ] Dashboard pokazujący statystyki grafu
