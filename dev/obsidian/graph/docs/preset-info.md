# Multi-Graph Strategy - ACTIVE

## 🎯 Obecny preset: ULTIMATE PERFORMANCE

**Filter:** `-path:core/var/logs -path:core/var/status -path:.git`
**Nodes:** ~927 (wszystkie pliki markdown)
**Render time:** <3s ⚡ (zoptymalizowany)
**Updated:** 2025-11-27

## 📊 Dostępne presety

**Lokalizacja:** `dev/obsidian/graph/`

Użyj: `cp graph/graph-{nazwa}.json .obsidian/graph.json`

1. **ULTIMATE** (~927 nodes) - aktywny, zoptymalizowany (graph-ultimate.json)
2. **BUSINESS** (~100 nodes) - business/, governance, processes
3. **DEV** (~200 nodes) - dev/, skrypty, lib, playbooks
4. **JAKUBC** (~150 nodes) - usr/jakubc/ + secondbrain
5. **KARINAM** (~50 nodes) - usr/karinam/
6. **MINIMAL** (~60 nodes) - tylko README/INDEX/folder notes
7. **PERFORMANCE** - maksymalna wydajność (mniej features)

## ⚙️ Konfiguracja ULTIMATE

- **Wykluczenia:** logi, status, .git
- **hideUnresolved:** true (bez martwych linków)
- **showOrphans:** false (bez odizolowanych)
- **showAttachments:** false (performance)
- **textFadeMultiplier:** -0.5 (zawsze widoczne etykiety)
- **nodeSizeMultiplier:** 1.5 (większe węzły)
- **lineSizeMultiplier:** 2 (grubsze linie)
- **linkDistance:** 120 (kompaktowy layout)
- **centerStrength:** 0.15 (skupione centrum)
- **repelStrength:** 12 (zbalansowane odpychanie)

## 🚀 Wydajność

| Preset | Nodes | Render | Status |
|--------|-------|--------|--------|
| ULTIMATE | ~927 | <3s | ✅ Zoptymalizowany |
| BUSINESS | ~100 | <1s | ✅ Fast |
| DEV | ~200 | 1-2s | ✅ Very good |
| MINIMAL | ~60 | <1s | ✅ Instant |
| JAKUBC | ~150 | 1-2s | ✅ Good |

## 💡 Tips

- **Cała struktura:** Preset ULTIMATE (aktywny)
- **Skupienie na obszarze:** Przełącz na BUSINESS/DEV/JAKUBC
- **Tylko overview:** MINIMAL (folder notes only)
- **Local Graph:** Ctrl+G na pliku - zawsze <1s
- **Dokumentacja:** Zobacz `graph-presets.md` (pełny guide)

## 📂 Struktura

```
dev/obsidian/
├── graph/              # Presety JSON + CSS (+ README.md)
├── graph-backups/      # Ręczne backupy (+ README.md)
├── graph-versions/     # Daily snapshots (+ README.md)
├── graph-presets.md    # Pełna dokumentacja (321 linii)
└── graph-preset-info.md # Ten plik (quick ref)
```
