created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #eww
  - #cleanup
  - #maintenance
title: "🗑️ Cleanup Log - Usunięcie dokumentacji Obsidian"
owner: jakubc
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# 🗑️ Cleanup Log - Usunięcie dokumentacji Obsidian

**Data**: 2025-11-23T01:42:00Z  
**Autor**: jakubc

## 📊 Podsumowanie

### Usunięte foldery (86MB, 6587 plików)

| Folder | Rozmiar | Pliki .md | Powód |
|--------|---------|-----------|-------|
| `official-en/` | 13M | 164 | Pobrana dokumentacja EN |
| `official-pl/` | 996K | 164 | Pobrana dokumentacja PL |
| `resources/hub/` | ~60M | 5747 | Obsidian Hub |
| `resources/api/` | ~5M | 300 | API docs |
| `resources/awesome/` | ~3M | 100 | Awesome lists |
| `resources/releases/` | ~3M | 84 | Release notes |
| `plugins/core/original/` | 132K | 28 | Core plugins docs |

**Razem**: ~86MB, 6587 plików

### Pozostawione (28 plików)

```
docs/infra/software/obsidian/
├── obsidian.md              # ✅ Nasze notatki
├── README.md
├── SUMMARY.md
├── TODO.md
├── STUDY-NOTES.md
├── TRANSLATION-STATUS.md
├── installed_pluggins.md
├── plugins/
│   ├── core/
│   │   └── graph-view.md
│   └── community/
├── settings/
├── features/
└── graph/
```

## 📈 Statystyki przed/po

| Metryka | Przed | Po | Zmiana |
|---------|-------|----|----|
| Pliki .md w repo | 7512 | ~925 | -6587 (-87.7%) |
| docs/infra/software/obsidian | 6642 | 28 | -6614 (-99.6%) |
| Rozmiar docs/obsidian | 86M | ~1M | -85M (-98.8%) |

## 🎯 Cel

Pozostawić tylko nasze własne konfigi i notatki o Obsidian.  
Usunąć całą pobraną dokumentację (official-*, resources/*).

## 🔧 Narzędzia

### Automatyczne
```bash
make clean-obsidian-docs-auto
```

### Interaktywne (z potwierdzeniem)
```bash
make clean-obsidian-docs
```

### Skrypty
- `scripts/cleanup-obsidian-docs.sh` - interactive
- `scripts/cleanup-obsidian-docs-auto.sh` - automatic

## ✅ Rezultat

- **Graph View**: Teraz ~137 nodes zamiast 7505 (98.2% redukcja)
- **Repo size**: ~85MB mniej
- **Przejrzystość**: Tylko nasze konfigi

created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

**Status**: ✅ DONE  
**Nie można cofnąć**: Użyj `git checkout` jeśli potrzebne
