---
tags:
  - #automation
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21






---

# 🎨 Optymalizacja Graph View - Strategie

## Problem: Graph się wykrzacza przy 489 notatkach

### ✅ Co już mamy:
- `maxNodes: 5000` ✓
- Filtry: `-path:archive -path:Tags` ✓  
- Color groups (5 kategorii) ✓

### 🔧 Rozwiązania:

#### 1. **Multiple Small Graphs** (REKOMENDOWANE)
Zamiast 1 grafu → **5 dedykowanych grafów**:

```
GRAPH-CORE.md      → tylko core/ (czerwony)
GRAPH-BUSINESS.md  → tylko business/ (żółty)
GRAPH-USERS.md     → jakubc + karinam (cyan + pink)
GRAPH-CONFIG.md    → config/ + infra/ (zielony)
GRAPH-MAP.md       → overview wszystkich folder notes
```

**Każdy graf**:
- 50-100 notatek max
- Własny filtr `path:xxx`
- Szybki rendering
- Czytelna wizualizacja

#### 2. **Local Graph w każdym folderze**
- Każda folder note pokazuje LOCAL GRAPH
- Depth: 2-3 levels
- Tylko bezpośrednie połączenia

#### 3. **Git jako versioning** (masz już!)
```bash
git log --all --graph --oneline
```
- Pełna historia zmian
- Darmowe (bez Obsidian Sync)
- `git log` jako timeline

#### 4. **Waypoint jako index generator**
- Auto-generuje listę plików w folder notes
- Odświeża co 30 sec
- Nie obciąża grafu

### 🎯 Implementacja:

**KROK 1**: Stwórz 5 dedykowanych grafów
**KROK 2**: W każdym ustawienia:
```json
{
  "search": "path:core -path:archive",
  "maxNodes": 500,
  "centerStrength": 0.6,
  "repelStrength": 20
}
```

**KROK 3**: Każdy graf = osobny widok w Obsidian
- Pin jako zakładka
- Szybkie przełączanie
- Czytelność 100%

### 📈 Rezultat:
- ✅ 5 grafów po 50-100 notatek (szybkie!)
- ✅ Local graphs w folder notes (kontekst)
- ✅ Git versioning (darmowe)
- ✅ Waypoint indexing (auto-update)
- ✅ **Piękna wizualizacja bez lagów**

---

**Zaczynamy od GRAPH-CORE.md?** 🚀
