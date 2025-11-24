---
tags:
  - #obsidian
  - #graph
  - #presets
  - #documentation
created: 2025-11-23T17:00:00Z
modified: 2025-11-23T17:00:00Z
author: jakubc
title: "Obsidian Graph View - Presety konfiguracyjne"
owner: jakubc
---

# Obsidian Graph View - Presety konfiguracyjne

## 🎯 Aktywny preset: **ULTIMATE PERFORMANCE**

### Parametry zoptymalizowane pod 927 plików markdown

```json
{
  "search": "-path:core/var/logs -path:core/var/status -path:.git",
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "textFadeMultiplier": -0.5,
  "nodeSizeMultiplier": 1.5,
  "lineSizeMultiplier": 2,
  "centerStrength": 0.4,
  "repelStrength": 12,
  "linkStrength": 0.6,
  "linkDistance": 280
}
```

### Co daje ten preset:
- ✅ **Wykluczenie logów i cache** - przyspiesza graf o ~15%
- ✅ **Bez załączników** - czytelniejszy, szybszy
- ✅ **Ukryte martwe linki** - bez śmieci
- ✅ **Ukryte osierocone** - tylko połączone notatki
- ✅ **Widoczne etykiety** (`-0.5`) - zawsze widoczne nazwy
- ✅ **Większe węzły** (1.5x) - lepiej widoczne
- ✅ **Grubsze linie** (2x) - wyraźniejsze połączenia
- ✅ **Kompaktowy układ** (280px) - mniej rozciągnięty
- ✅ **Silniejsze centrum** (0.4) - uporządkowany
- ✅ **Zbalansowana fizyka** (12/0.6) - stabilny

---

## 📦 Inne presety do wypróbowania

### 🎨 PRESET 1: Minimalistyczny (tylko indexy)
```json
{
  "search": "file:INDEX OR file:README OR tag:#folder_note",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "nodeSizeMultiplier": 2.0,
  "textFadeMultiplier": -1
}
```
**Cel**: Widok tylko struktury głównej (READMEs i folder notes)

### 🔥 PRESET 2: Focus Mode (jakubc + secondbrain)
```json
{
  "search": "path:usr/jakubc/ OR tag:#secondbrain OR tag:#jakubc",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "repelStrength": 8,
  "linkDistance": 200
}
```
**Cel**: Tylko Twoje notatki i projekty SecondBrain

### 📊 PRESET 3: Business Intelligence
```json
{
  "search": "path:business/ OR tag:#business OR tag:#governance",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "colorGroups": [
    {
      "query": "tag:#governance",
      "color": {"a": 1, "rgb": 16711680}
    },
    {
      "query": "tag:#processes",
      "color": {"a": 1, "rgb": 65280}
    },
    {
      "query": "tag:#methodologies",
      "color": {"a": 1, "rgb": 255}
    }
  ]
}
```
**Cel**: Analiza procesów biznesowych i governance

### 🛠️ PRESET 4: DevOps View
```json
{
  "search": "path:dev/ OR path:docs/infra/ OR tag:#tools OR tag:#ansible",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "nodeSizeMultiplier": 1.2,
  "linkDistance": 250
}
```
**Cel**: Narzędzia, infrastruktura, playbooki

### 🌟 PRESET 5: Knowledge Graph (wszystko połączone)
```json
{
  "search": "-path:archive/ -path:tmp/",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "repelStrength": 15,
  "linkDistance": 350,
  "centerStrength": 0.5
}
```
**Cel**: Pełny widok Second Brain (bez archiwów i temp)

### ⚡ PRESET 6: Performance Max (szybki laptop)
```json
{
  "search": "tag:#folder_note OR file:INDEX",
  "showTags": false,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "nodeSizeMultiplier": 1.0,
  "lineSizeMultiplier": 0.5,
  "textFadeMultiplier": 1,
  "repelStrength": 5,
  "linkDistance": 150
}
```
**Cel**: Maksymalna wydajność - tylko szkielet struktury

---

## 🎯 Jak używać presetów?

### Metoda 1: Kopiuj-wklej do `.obsidian/graph.json`
1. Skopiuj wybrany preset
2. Otwórz `.obsidian/graph.json`
3. Zastąp odpowiednie sekcje
4. Zrestartuj Obsidiana (lub przeładuj graf: Ctrl+P → "Reload graph")

### Metoda 2: Workspaces (REKOMENDOWANE)
1. Ustaw graf według presetu
2. Ctrl+P → "Manage workspace layouts"
3. Zapisz jako: "Graph: Minimalist", "Graph: Focus", etc.
4. Przełączaj między layoutami jednym klikiem

### Metoda 3: Hotkeys
Możesz ustawić skróty klawiszowe dla często używanych presetów:
- Settings → Hotkeys → "Open graph view: local" (Alt+G)
- Settings → Hotkeys → "Open graph view: global" (Ctrl+G)

---

## 🧪 Parametry do eksperymentowania

### Fizyka grafu (Forces)
```json
"centerStrength": 0.1-0.9    // Siła grawitacji do centrum (0.4 optimal)
"repelStrength": 5-30        // Odpychanie węzłów (12 dla 900 plików)
"linkStrength": 0.1-1.0      // Siła połączeń (0.6 stabilny)
"linkDistance": 100-600      // Odległość między węzłami (280 kompakt)
```

### Wygląd
```json
"nodeSizeMultiplier": 0.5-3.0      // Rozmiar węzłów (1.5 czytelny)
"lineSizeMultiplier": 0.5-5.0      // Grubość linii (2 wyraźny)
"textFadeMultiplier": -2 do 3      // Etykiety: -2=zawsze, 3=nigdy
```

### Filtry (Search Query Syntax)
```
path:folder/          - ścieżka
file:nazwa            - nazwa pliku
tag:#tag              - tag
-path:folder/         - wykluczenie ścieżki
OR                    - lub
```

---

## 📈 Monitoring wydajności grafu

### Sprawdź ile plików jest wyświetlanych:
1. Otwórz graf (Ctrl+G)
2. Górny prawy róg - licznik węzłów
3. Optymalnie: **100-300 węzłów** dla płynności
4. Max: **1000 węzłów** (ustawione w `app.json`)

### Jeśli graf jest wolny:
1. Zmniejsz `graphMaxFileCount` w `.obsidian/app.json`
2. Użyj węższych filtrów w `search`
3. Wyłącz `showOrphans` i `showAttachments`
4. Zmniejsz `nodeSizeMultiplier` i `lineSizeMultiplier`

---

## 🎨 Customizacja kolorów

### Twoje obecne grupy (18):
1. `#folder_note` - RGB: 5227511 (niebieskozielony)
2. Archiwa - RGB: 0 (czarny)
3. Struktura (README/INDEX) - RGB: 16777215 (biały)
4. Logi/CI - RGB: 16711680 (czerwony)
5. Infrastruktura - RGB: 16737280 (pomarańczowy)
6. Config - RGB: 16776960 (żółty)
7. EWW Core - RGB: 6748928 (jasna zieleń)
8. Business - RGB: 65280 (pure green)
9. Tools - RGB: 65484 (turkus)
10. GERC - RGB: 65535 (cyan)
11. Jakubc - RGB: 26367 (niebieski)
12. Dev - RGB: 255 (pure blue)
13. Docs - RGB: 10027007 (fioletowy)
14. SecondBrain - RGB: 16711935 (magenta)
15. Karinam - RGB: 16711833 (różowy)
16. Star Wars - RGB: 14263361
17. Lego - RGB: 16040461
18. Asus Z77 - RGB: 12604881

### Generator kolorów RGB:
```bash
# Python one-liner do konwersji HEX → RGB (decimal)
python3 -c "print(int('ff0000', 16))"  # → 16711680 (czerwony)
```

---

## 🚀 Pro Tips dla fanów Graph View

### 1. Local Graph (na konkretną notatkę)
- Prawy klik na notatce → "Open local graph"
- Pokazuje tylko bezpośrednie połączenia
- Szybsze niż global graph

### 2. Depth Control (głębokość)
W local graph możesz ustawić głębokość:
- Depth 1: bezpośrednie linki
- Depth 2: linki drugiego stopnia
- Depth 3: cała sieć (może być wolne)

### 3. Canvas + Graph
Używaj Canvas do wizualizacji projektów, Graph do eksploracji

### 4. Tags jako kategorie
Dodawaj konsekwentnie tagi do plików:
```yaml
---
tags:
  - #folder_note
  - #secondbrain
  - #jakubc
---
```

### 5. Backlinks Panel
- Ctrl+P → "Toggle backlinks"
- Uzupełnia graph view - pokazuje kto linkuje do aktywnej notatki

### 6. Hotkeys dla efektywności
```
Ctrl+G         - Global graph
Ctrl+Shift+G   - Local graph (jeśli ustawisz)
Ctrl+O         - Quick switcher
Ctrl+Shift+F   - Search in all files
```

---

## 🔧 Troubleshooting

### Graf się nie ładuje / wiesza:
1. Sprawdź `graphMaxFileCount` w `app.json` (zmniejsz do 500)
2. Dodaj wykluczenia: `-path:.obsidian -path:core/var`
3. Wyłącz `showOrphans` i `showAttachments`

### Kolory się nie zmieniają:
1. Sprawdź kolejność w `colorGroups` (pierwsze mają priorytet)
2. Usuń cache: zamknij Obsidian, usuń `.obsidian/workspace`
3. Zrestartuj Obsidiana

### Zbyt gęsty/rozrzucony:
- Gęsty: zwiększ `repelStrength` (15-20)
- Rozrzucony: zmniejsz `linkDistance` (200-250)

### Niewidoczne etykiety:
- Ustaw `textFadeMultiplier: -1` (zawsze widoczne)
- Zwiększ zoom w grafie (scroll)

---

## 📚 Zasoby

- [Obsidian Graph View Docs](https://help.obsidian.md/Plugins/Graph+view)
- [CSS Snippets dla Graph](https://forum.obsidian.md/t/graph-view-css-snippets/)
- [Community Presets](https://github.com/obsidianmd/obsidian-releases/discussions)

---

**Ostatnia aktualizacja**: 2025-11-23
**Aktualna konfiguracja**: `ULTIMATE PERFORMANCE` dla 927 plików
