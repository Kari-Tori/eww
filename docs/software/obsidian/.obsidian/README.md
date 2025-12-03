---
tags:
  - #obsidian
  - #graph
  - #config
  - #eww
created: 2025-11-22T20:00:00Z
modified: 2025-11-22T20:00:00Z
author: jakubc
title: "Konfiguracja Obsidian dla dokumentacji"
owner: jakubc
---

# Konfiguracja Obsidian dla dokumentacji

Ten katalog `.obsidian/` zawiera **konfigurację grafu i stylów** zoptymalizowaną do przeglądania dokumentacji Obsidian w naszym vault EWW.

## 📁 Zawartość

### 🎨 Graph Configuration
- **graph.json** - Główna konfiguracja grafu z 10 grupami kolorów
- **graph-colors.json** - Rozszerzone kolory
- **graph-exclude.json** - Wykluczenia z grafu
- **graph-local.json** - Ustawienia local graph
- **graph-optimization.json** - Optymalizacje wydajności
- **graph-performance.json** - Performance settings

### 💅 CSS Snippets
```
snippets/
├── graph-colors.css       # Kolory węzłów i strzałek
└── graph-style.css        # Style grafu
```

## 🎨 Grupy kolorów dla dokumentacji

Graf jest skonfigurowany do wizualizacji różnych typów dokumentacji:

| Grupa | Query | Kolor | Zastosowanie |
|-------|-------|-------|-------------|
| **folder_note** | `tag:#folder_note` | Szary | README i indeksy |
| **official** | `tag:#official OR path:official-en/` | Zielony | Oficjalna docs |
| **translation** | `tag:#translation OR path:official-pl/` | Cyjan | Polskie tłumaczenia |
| **resources** | `tag:#resources OR path:resources/` | Niebieski | Community resources |
| **plugins** | `tag:#plugin OR path:plugins/` | Fioletowy | Pluginy |
| **graph-docs** | `tag:#graph OR path:graph/` | Różowy | Graf dokumentacja |
| **api** | `tag:#api OR path:resources/api/` | Pomarańczowy | API docs |
| **guides** | `tag:#guide OR path:resources/hub/04` | Turkusowy | Tutoriale |
| **themes** | `tag:#theme OR path:resources/hub/02.02` | Żółty | Themes |
| **css** | `tag:#css OR path:resources/hub/02.03` | Brązowy | CSS snippets |

## 🔧 Ustawienia grafu

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

### Forces (Physics)
```json
{
  "centerStrength": 0.1,
  "repelStrength": 20,
  "linkStrength": 0.3,
  "linkDistance": 500
}
```

## 🎯 Jak używać

### Otwórz graf dokumentacji
1. Otwórz Obsidian
2. Open folder as vault: `docs/software/obsidian/`
3. Naciśnij `Ctrl+G` lub kliknij ikonę grafu

### Filtrowanie
- **Tylko oficjalna docs:** Search: `path:official-en/`
- **Tylko tłumaczenia:** Search: `path:official-pl/`
- **Tylko resources:** Search: `path:resources/`
- **Tylko pluginy:** Search: `path:plugins/ OR path:official-en/Plugins/`

### Local Graph
- Otwórz dowolny plik (np. `README.md`)
- Kliknij prawym → "Open local graph"
- Zobacz połączenia tego dokumentu

## 💅 Style CSS

### Kolory strzałek
- **Domyślne:** Szary (#888888)
- **Hover:** Pomarańczowy (#ff9900)
- **Plugins:** Fioletowy (#8b5cf6)
- **Resources:** Różowy (#ec4899)
- **Docs:** Niebieski (#3b82f6)

### Efekty węzłów
- **Folder notes:** Większe węzły
- **MOC (Maps of Content):** Pulsujące
- **Orphans:** Przezroczyste, przerywane

## 🔄 Synchronizacja z głównym vault

Ta konfiguracja jest **kopią** z głównego vault EWW (`/home/jakubc/git/eww/.obsidian/`).

### Aktualizacja konfiguracji
```bash
cd /home/jakubc/git/eww

# Skopiuj graph settings
cp .obsidian/graph*.json docs/software/obsidian/.obsidian/

# Skopiuj CSS snippets
cp -r .obsidian/snippets docs/software/obsidian/.obsidian/

# Commit
git add docs/software/obsidian/.obsidian
git commit -m "feat(obsidian): zaktualizowano konfigurację grafu dla docs"
```

## 📊 Optymalizacje

Ten vault dokumentacji zawiera **6473 pliki .md**, więc graf wymaga optymalizacji:

1. **Ukryj orphans** - zmniejsza liczbę węzłów
2. **Ukryj attachments** - tylko pliki .md
3. **hideUnresolved: true** - ukryj nieistniejące linki
4. **repelStrength: 20** - większe rozproszenie węzłów
5. **linkDistance: 500** - większa odległość między węzłami

## 🔗 Powiązane

- [[../graph/graph-rules]] - Zasady konfiguracji grafu w głównym vault
- [[../graph/README]] - Dokumentacja Graph View
- [[../official-en/Plugins/Graph view.md]] - Oficjalna dokumentacja (EN)
- [[../official-pl/Plugins/Graph view.md]] - Polska dokumentacja

## 📝 Notatki

- Ten vault jest **sub-vault** głównego EWW
- Można go otworzyć jako osobny vault w Obsidian
- Konfiguracja jest dostosowana do **dużej liczby plików** (6473)
- CSS snippets muszą być włączone w Settings → Appearance

## ⚠️ Uwaga

**NIE edytuj bezpośrednio** - zmiany rób w głównym vault (`/home/jakubc/git/eww/.obsidian/`), potem synchronizuj tutaj.

---

**Źródło:** Skopiowane z `/home/jakubc/git/eww/.obsidian/`  
**Data:** 2025-11-22  
**Plików w vault:** 6473

## 🔗 Backlinks

- [[INDEX]]
- [[docs]]
- [[EWW-MAP]]
