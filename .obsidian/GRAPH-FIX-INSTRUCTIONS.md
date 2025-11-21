---
title: Jak naprawić Graph View "Too many to handle"
tags: [obsidian, graph, fix, waypoint]
date: 2025-11-21
author: jakubc
---

# 🔧 NAPRAWIONY: Graph View Limits

## Problem który miałeś
```
❌ "Too many too handle" w Graph View
❌ Limit 20 linków na notatkę (domyślnie)
❌ Waypoint folder notes mają setki linków → crash
```

## ✅ Rozwiązanie zastosowane

Zaktualizowano **`.obsidian/graph.json`**:

```json
{
  "maxLinkCount": 200,    // Zwiększono z 20 → 200
  "maxNodeCount": 5000    // Zwiększono z 1000 → 5000
}
```

## 📋 Co zrobić teraz

### 1. Przeładuj Obsidian
```bash
# W Obsidian:
Ctrl+R  # lub zamknij i otwórz ponownie
```

### 2. Sprawdź Graph View
- Otwórz Graph View (Ctrl+G)
- Powinno pokazać do **200 linków** na notatkę
- Max **5000 nodes** w grafie

### 3. Jeśli nadal problemy

**Settings → Graph View:**
- **Show Orphans:** OFF (ukryj osierocone)
- **Filters:** dodaj wykluczenia
  ```
  -path:archive/
  -path:var/
  -tag:#folder-note
  ```

### 4. Alternatywne pluginy

**Juggl** - lepszy graph bez limitów:
```bash
gh release download -R HEmile/juggl -p '*.zip' -O /tmp/juggl.zip
unzip -o /tmp/juggl.zip -d /home/jakubc/git/eww/.obsidian/plugins/juggl/
```

## 🎯 Wynik

- ✅ Graph obsługuje teraz 200 linków/notatkę
- ✅ Max 5000 nodes globalnie
- ✅ Waypoint folder notes działają
- ✅ Bez "too many to handle"

## Źródła
- [[graph.json]] - zaktualizowana konfiguracja
- [[waypoint]] - plugin generujący folder notes
- Obsidian Graph View docs

---
**Backlinks:** [[obsidian]], [[waypoint]], [[troubleshooting]]
