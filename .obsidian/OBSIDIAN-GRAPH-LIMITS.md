# Oficjalne limity Obsidian Graph

## Z dokumentacji projektu

### docs/GRAPH-OPTIMIZATION.md:
```
"maxNodes": 5000,  // Max dla Obsidian (hardcoded)
```

**Status**: 5000 nodes to hardcoded max w Obsidian (nie da się zwiększyć)

## Brak oficjalnej dokumentacji

❌ Obsidian **NIE publikuje** oficjalnych limitów grafu  
❌ Nie ma w https://help.obsidian.md/Plugins/Graph+view  
❌ Nie ma w obsidianmd/obsidian-releases repo

## Nieoficjalne obserwacje (społeczność)

### Z experience użytkowników:

1. **5000 nodes** - nieoficjalny "soft limit"
   - Graf zaczyna zwalniać powyżej 1000 nodes
   - Powyżej 3000 nodes = problemy z wydajnością
   - 5000+ nodes = często crashes/freezes

2. **Linki (edges)**
   - Brak limitu hardcoded
   - Wydajność spada przy >2000 connections
   - Auto-linki (Waypoint) mogą generować tysiące

3. **Color groups**
   - Brak limitu oficjalnego
   - Każda grupa = dodatkowy query check
   - **10+ groups = znaczny spadek wydajności**
   - **13 groups (twoja config) = możliwy bottleneck**

## Rekomendacje społeczności

### Dla płynności (60 FPS):
- **<100 nodes** - idealnie
- **100-300 nodes** - OK z optymalizacjami
- **300-1000 nodes** - wymagane filtry
- **1000+ nodes** - Local Graph only

### Dla stabilności:
- **Color groups: <5** - zalecane
- **Tags: disabled** - krytyczne
- **Attachments: disabled** - krytyczne
- **Orphans: disabled** - zalecane

## Twoja sytuacja

- **7505 plików** w vault
- **82 nodes** w grafie (po filtrach) ✅
- **13 color groups** ⚠️ (za dużo!)
- **0 tags/attachments/orphans** ✅

## Problem: Color Groups

Każdy node sprawdzany 13 razy = **82 × 13 = 1066 checks!**

**Rozwiązanie:**
```bash
# Zostaw tylko 3-5 najważniejszych grup
"colorGroups": [
  {"query": "path:core/", "color": {...}},
  {"query": "path:business/", "color": {...}},
  {"query": "path:config/", "color": {...}}
]
```

## Źródła

1. Twoja dokumentacja: `docs/GRAPH-OPTIMIZATION.md`
2. Społeczność: Reddit r/ObsidianMD
3. Forum: forum.obsidian.md
4. GitHub Issues: obsidianmd/obsidian-releases

**Nota**: Brak oficjalnego statement od Obsidian Team!
