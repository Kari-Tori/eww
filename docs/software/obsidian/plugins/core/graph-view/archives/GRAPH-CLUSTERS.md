---
version: 0.0.4
tags:
  - #automation
  - #graph
  - #eww
created: 2025-11-21
modified: 2025-12-01
author: jakubc
title: "🎨 GRAPH: Isolated Color Clusters"
owner: jakubc
---

# 🎨 GRAPH: Isolated Color Clusters

> **Każdy kolor = osobny klaster na grafie**

## 🎯 Konfiguracja

### Siły grafu
- **centerStrength**: 0.05 (bardzo słabe centrowanie)
- **repelStrength**: 25 (bardzo silne odpychanie)
- **linkStrength**: 0.5 (średnie łączenie w klastrze)
- **linkDistance**: 600 (bardzo duża odległość)

**Efekt**: Silna separacja klastrów, każdy kolor w osobnym gnieździe

### Efekt
Każda grupa kolorów tworzy **własne gniazdo** (cluster):
- 🔴 **Core** - czerwony klaster (path:core/)
- 🟢 **Config** - zielony klaster (path:config/)
- 🟡 **Business** - żółty klaster (path:business/)
- 🔵 **jakubc** - cyan klaster (path:usr/jakubc/)
- 🟣 **karinam** - magenta klaster (path:usr/karinam/)
- 🌟 **Star Wars** - beżowy klaster (path:usr/jakubc/hobby/star_wars/)
- 🟠 **Lego** - pomarańczowy klaster (path:usr/jakubc/hobby/lego/)
- 🔷 **Docs** - niebieski klaster (path:docs/)
- 🟤 **Infra** - khaki klaster (path:infra/)
- 🔴 **Scripts** - coral klaster (path:scripts/)
- ⚫ **Tools** - szary klaster (path:tools/)
- 🟫 **Folder Notes** - brązowy klaster (centrum)

## 📊 Grupy kolorów

| Kolor | Query | RGB | Ścieżka |
|-------|-------|-----|---------|
| 🟫 Brązowy | `tag:#folder_note` | 9127187 | Folder notes (centrum) |
| 🔴 Czerwony | `tag:#eww OR tag:#core` | 16711680 | path:core/ |
| 🟢 Zielony | `tag:#config` | 65280 | path:config/ |
| 🟡 Żółty | `tag:#business` | 16776960 | path:business/ |
| 🔵 Cyan | `tag:#jakubc` | 65535 | path:usr/jakubc/ |
| 🟣 Magenta | `tag:#karinam` | 16711935 | path:usr/karinam/ |
| 🌟 Beżowy | `tag:#star-wars` | 14263361 | path:usr/jakubc/hobby/star_wars/ |
| 🟠 Pomarańczowy | `tag:#lego` | 16744192 | path:usr/jakubc/hobby/lego/ |
| 🔷 Niebieski | `tag:#docs` | 5592575 | path:docs/ |
| 🟤 Khaki | `tag:#infra` | 10824234 | path:infra/ |
| 🔴 Coral | `tag:#scripts` | 16733525 | path:scripts/ |
| ⚫ Szary | `tag:#tools` | 8421504 | path:tools/ |

## 🎨 Kolorowe ścieżki

Każda ścieżka ma swój unikalny kolor:
- **path:core/** = 🔴 Czerwony
- **path:config/** = 🟢 Zielony  
- **path:business/** = 🟡 Żółty
- **path:usr/jakubc/** = 🔵 Cyan
- **path:usr/karinam/** = 🟣 Magenta
- **path:docs/** = 🔷 Niebieski
- **path:infra/** = 🟤 Khaki
- **path:scripts/** = 🔴 Coral
- **path:tools/** = ⚫ Szary

## 🚀 Użycie

### Filtruj konkretny klaster
```
tag:#jakubc
```
Zobaczysz tylko cyan klaster (jakubc).

### Pokaż relacje między klastrami
```
tag:#eww OR tag:#jakubc
```
Zobaczysz połączenia między zielonym a cyan.

### Local Graph
Każdy plik pokazuje swój klaster + bezpośrednie połączenia.

## 🎨 Wizualizacja

```
       [Folder Notes] 🟫
              |
    +---------+---------+
    |         |         |
 [EWW]🟢  [jakubc]🔵  [karinam]🟣
    |         |         |
  [Docs]   [SW]🟡   [Lego]🟠
   🔷        |         |
         [Scripts]  [Tools]
            🔴        ⚫
```

## ✅ Zalety

- ✅ **Przejrzystość** - każdy kolor to osobna sieć
- ✅ **Nawigacja** - łatwo znaleźć tematyczny content
- ✅ **Performance** - mniejsze klastry = szybszy render
- ✅ **Kontekst** - wizualnie widzisz separację tematów

## 🔧 Dostosowanie

Edytuj `.obsidian/graph.json`:
- **repelStrength** ↑ = więcej separacji
- **linkDistance** ↑ = większe gniazda
- **centerStrength** ↓ = luźniejsza struktura

## 🔗 Related
- [[GRAPH-MAP]] - Mapa główna
- [[GRAPH-OPTIMIZATION]] - Optymalizacje
- [[fix-graph-clusters.sh]] - Skrypt konfiguracyjny

**Restart Obsidian po zmianach!** 🔄

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]