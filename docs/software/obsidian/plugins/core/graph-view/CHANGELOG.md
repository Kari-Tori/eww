---
version: 0.0.3
tags:
  - #obsidian
  - #graph
  - #changelog
  - #documentation
created: 2025-11-24
modified: 2025-12-01
author: jakubc
title: "Obsidian Graph - Historia zmian i konfiguracji"
owner: jakubc
---

# Obsidian Graph - Historia zmian i konfiguracji

[← Powrót do README](README.md)

---

## 📅 2025-11-23 17:45 - Finalna konfiguracja

### ✅ Ustawienia aktywne

```json
{
  "showTags": true,
  "showAttachments": true,
  "hideUnresolved": false,
  "showOrphans": true
}
```

### 🎯 Parametry fizyki

```json
{
  "nodeSizeMultiplier": 2.065,
  "lineSizeMultiplier": 0.687,
  "textFadeMultiplier": -0.5,
  "centerStrength": 0.042,
  "repelStrength": 20,
  "linkStrength": 0.552,
  "linkDistance": 62
}
```

### 🔍 Filtry

```json
{
  "search": "-path:core/var/logs -path:core/var/status -path:.git"
}
```

### 📊 Statystyki

- **Plików markdown**: 927
- **Grup kolorów**: 18
- **Widoczne**: Wszystkie pliki (+ sieroty + martwe linki)
- **Layout**: Bardzo kompaktowy (62px), silne odpychanie (20)

### 💡 Zmiana względem poprzedniej wersji

**Przed (17:00)**:
- `hideUnresolved: true` - ukryte martwe linki
- `showOrphans: false` - ukryte sieroty

**Teraz (17:45)**:
- `hideUnresolved: false` - ✅ **POKAZUJ martwe linki**
- `showOrphans: true` - ✅ **POKAZUJ sieroty**

**Powód**: Użytkownik chce widzieć wszystkie pliki i planować co utworzyć

---

## 📅 2025-11-23 17:00 - ULTIMATE PERFORMANCE Setup

### ✅ Ustawienia aktywne

```json
{
  "showTags": true,
  "showAttachments": true,
  "hideUnresolved": true,
  "showOrphans": false
}
```

### 🎯 Parametry fizyki (zalecane)

```json
{
  "nodeSizeMultiplier": 1.5,
  "lineSizeMultiplier": 2.0,
  "textFadeMultiplier": -0.5,
  "centerStrength": 0.4,
  "repelStrength": 12,
  "linkStrength": 0.6,
  "linkDistance": 280
}
```

### 🔍 Filtry

```json
{
  "search": "-path:core/var/logs -path:core/var/status -path:.git"
}
```

### 📦 Co zainstalowano

1. **Główna konfiguracja**: `.obsidian/graph.json`
2. **3 presety specjalistyczne**:
   - `graph-business.json` - tylko business/
   - `graph-jakubc.json` - usr/jakubc/ + #secondbrain
   - `graph-dev.json` - dev/ (scripts, lib, Playbooks)
3. **Skrypt**: `dev/scripts/graph-switch.sh`
4. **Dokumentacja**: `docs/infra/software/obsidian/graph/`
   - README.md
   - installation-guide.md
   - presets.md
   - colors.md

### 💡 Cel setupu

Zoptymalizowana konfiguracja dla 927 plików markdown:
- Bez załączników dla szybkości
- Ukryte martwe linki dla czystości
- Ukryte sieroty dla koncentracji na relacjach
- Kompaktowy layout (280px)
- Silne centrum (0.4)

---

## 📅 2025-11-23 16:57 - Backup przed ULTIMATE

### Config

Backup utworzony: `.obsidian/graph.json.backup-20251123-165657`

Stara konfiguracja (przed zmianami):
```json
{
  "search": "path:docs/ OR path:usr/jakubc/ OR ...",
  "showTags": true,
  "showAttachments": true,
  "hideUnresolved": false,
  "showOrphans": true,
  "colorGroups": [
    {
      "query": "path:docs/",
      "color": {"a": 1, "rgb": 25343}
    }
    // ... tylko 6 grup kolorów
  ],
  "repelStrength": 10,
  "linkDistance": 200
}
```

---

## 📅 2025-11-22 - Pierwsze konfiguracje

### Utworzono

- `docs/infra/software/obsidian/graph/graph-rules.md` - Zasady kanoniczne
- `docs/infra/software/obsidian/graph/GRAPH-CONFIG-DOCS.md` - Dokumentacja config
- Różne backupy i eksperymenty z kolorami

---

## 📊 Porównanie konfiguracji

### Tabela zmian parametrów

| Parametr | 2025-11-22 | 2025-11-23 17:00<br>(ULTIMATE) | 2025-11-23 17:45<br>(CURRENT) |
|----------|------------|-------------------------------|-------------------------------|
| **showTags** | true | true | true |
| **showAttachments** | true | false → true | true |
| **hideUnresolved** | false | true | **false** |
| **showOrphans** | true | false | **true** |
| **nodeSizeMultiplier** | 1.0 | 1.5 | **2.065** |
| **lineSizeMultiplier** | 1.0 | 2.0 | **0.687** |
| **textFadeMultiplier** | 0 | -0.5 | -0.5 |
| **centerStrength** | 0.4 | 0.4 | **0.042** |
| **repelStrength** | 10 | 12 | **20** |
| **linkStrength** | 0.5 | 0.6 | **0.552** |
| **linkDistance** | 200 | 280 | **62** |
| **colorGroups** | 6 | 18 | 18 |

---

## 🎨 Historia grup kolorów

### 2025-11-23 - 18 grup kolorów (CURRENT)

```json
[
  {"query": "tag:#folder_note", "rgb": 5227511},
  {"query": "path:docs/archive OR path:usr/jakubc/workspace/archive", "rgb": 0},
  {"query": "file:README OR file:INDEX OR file:CHANGELOG", "rgb": 16777215},
  {"query": "path:core/var/logs OR path:core/var/status OR path:.github/workflows", "rgb": 16711680},
  {"query": "path:docs/infra OR path:core/systemd OR path:.vscode", "rgb": 16737280},
  {"query": "path:core OR path:.github OR file:.gitignore OR tag:#config", "rgb": 16776960},
  {"query": "path:core OR file:Makefile OR file:CHANGELOG OR tag:#eww OR tag:#core", "rgb": 6748928},
  {"query": "path:business OR tag:#business", "rgb": 65280},
  {"query": "path:dev/scripts OR path:dev/bin OR path:dev/lib OR tag:#tools", "rgb": 65484},
  {"query": "path:docs/infra/hardware/workstations/gerc OR tag:#gerc OR tag:#GERC", "rgb": 65535},
  {"query": "path:usr/jakubc OR tag:#jakubc", "rgb": 26367},
  {"query": "path:dev OR tag:#dev OR tag:#development", "rgb": 255},
  {"query": "path:docs OR tag:#docs OR tag:#documentation", "rgb": 10027007},
  {"query": "path:dev/Projects/Secondbrain OR path:.obsidian OR tag:#secondbrain", "rgb": 16711935},
  {"query": "path:usr/karinam OR tag:#karinam", "rgb": 16711833},
  {"query": "tag:#star-wars OR path:usr/jakubc/hobby/star_wars", "rgb": 14263361},
  {"query": "tag:#lego OR path:usr/jakubc/hobby/lego", "rgb": 16040461},
  {"query": "tag:#Asus_Z77 OR path:docs/infra/hardware/asus_z77", "rgb": 12604881}
]
```

### 2025-11-22 - 6 grup kolorów (LEGACY)

```json
[
  {"query": "path:docs/", "rgb": 25343},
  {"query": "path:usr/jakubc/", "rgb": 16711680},
  {"query": "path:docs/infra/tags/", "rgb": 4585380},
  {"query": "path:usr/karinam/", "rgb": 16711901},
  {"query": "path:core/", "rgb": 65331},
  {"query": "path:core/house/", "rgb": 2303}
]
```

---

## 📁 Backupy dostępne

Lista backupów w `.obsidian/`:

```
graph.json.backup-20251123-165657  # Przed ULTIMATE setup
graph.json.backup-pre-ultimate     # Przed finalną instalacją
graph.json.backup-1763891717       # Auto-backup
graph.json.backup-1763891691       # Auto-backup
graph.json.backup-1763872378       # Auto-backup
... (~35 backupów dostępnych)
```

### Jak przywrócić backup

```bash
# Lista backupów
ls -lht .obsidian/graph.json.backup-* | head -5

# Przywróć wybrany
pkill -f obsidian
cp .obsidian/graph.json.backup-20251123-165657 .obsidian/graph.json
obsidian &
```

---

## 🔧 Narzędzia i skrypty

### graph-switch.sh (utworzony 2025-11-23 17:05)

**Lokalizacja**: `dev/scripts/graph-switch.sh`

**Funkcje**:
- Automatyczne backupy przed zmianą
- Przełączanie między presetami
- Sprawdzanie czy Obsidian działa
- Restore backupów

**Użycie**:
```bash
./dev/scripts/graph-switch.sh         # Interaktywnie
./dev/scripts/graph-switch.sh business # Bezpośrednio
```

---

## 📚 Dokumentacja

### Utworzone pliki (2025-11-23)

| Plik | Rozmiar | Opis |
|------|---------|------|
| README.md | 5.4KB | Indeks + quick start |
| installation-guide.md | 9.1KB | Gdzie, co, po co, jak instalować |
| presets.md | 8.3KB | 6 presetów specjalistycznych |
| colors.md | 9.9KB | Schemat 18 kolorów |
| CHANGELOG.md | Ten plik | Historia zmian z datami |

**Łącznie**: 32.7KB dokumentacji

---

## 🎯 Najważniejsze zmiany - timeline

### 2025-11-23 17:45 ⭐ CURRENT
- ✅ Włączono pokazywanie martwych linków (hideUnresolved: false)
- ✅ Włączono pokazywanie sierot (showOrphans: true)
- ✅ Zachowano parametry fizyki ustawione przez użytkownika
- 📝 Utworzono CHANGELOG.md

### 2025-11-23 17:00
- ⚡ ULTIMATE PERFORMANCE Setup
- 📦 18 grup kolorów
- 📁 3 presety specjalistyczne
- 🔧 Skrypt graph-switch.sh
- 📚 32KB dokumentacji

### 2025-11-23 16:57
- 💾 Backup przed zmianami

### 2025-11-22
- 📝 Pierwsze dokumenty i zasady
- 🎨 Początkowe grupy kolorów (6)

---

## 📖 Zobacz także

- [README.md](README.md) - Główny indeks
- [installation-guide.md](installation-guide.md) - Przewodnik instalacji
- [presets.md](presets.md) - Presety specjalistyczne
- [colors.md](colors.md) - Schemat kolorów

---

**Ostatnia aktualizacja**: 2025-11-23 17:45:00  
**Wersja**: 1.1  
**Autor**: jakubc

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]