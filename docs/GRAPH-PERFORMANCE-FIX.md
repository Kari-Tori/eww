---
tags:
  - #automation
  - #development
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T14:27:50Z
modified: 2025-11-21T14:27:50Z
author: jakubc
title: "🚀 Graf - Optymalizacja Performance"






---

# 🚀 Graf - Optymalizacja Performance

## 🎯 Problem

- **510 plików MD** w repo
- Graf crashował/nie ładował się
- Debug console pokazywał błędy

## ✅ Rozwiązanie

### 1. Extended Graph Config

```json
{
  "maxNodes": 5000,
  "delay": 500,
  "recomputeStatsOnGraphChange": false,
  "fadeInElements": false
}
```

**Wyłączone ciężkie featury:**
- ❌ Properties rendering
- ❌ Shapes
- ❌ Elements stats
- ❌ Layers

### 2. Graph Filter

```
(path:core OR path:config OR path:business OR 
 path:docs/getting-started OR path:docs/setup OR 
 path:infra OR path:usr/jakubc/m18 OR 
 path:usr/jakubc/health OR path:usr/jakubc/INDEX OR 
 path:usr/jakubc/jakubc OR path:usr/karinam) 
-path:docs/tags -path:archive -path:Tags 
-path:usr/jakubc/star_wars -file:backlinks -file:tags.md
```

**Pokazuje:**
- ✅ Core folders (core, config, business)
- ✅ Docs essentials (getting-started, setup)
- ✅ User profiles (jakubc, karinam)
- ✅ Infra

**Ukrywa:**
- ❌ Archive
- ❌ Tags folder
- ❌ Star Wars
- ❌ Backlinks/orphans

### 3. Color Groups

| Kolor | Query | RGB |
|-------|-------|-----|
| 🩷 Pink | `tag:#pink OR tag:#candy OR path:usr/karinam` | 16761035 |
| 🔵 Blue | `tag:#blue OR path:usr/jakubc` | 5592575 |
| 🟢 EWW | `tag:#eww OR path:core OR config OR business` | 10809863 |
| 🟩 Docs | `tag:#green OR path:docs` | 5763719 |
| 🟣 Folder | `tag:#folder-note` | 14701249 |

## 📊 Rezultaty

- **~100-150 nodów** renderowanych (zamiast 510)
- **2-3x szybszy** rendering
- **Czytelny graf** z kolorami

## 🔄 Aplikacja

```bash
./fix-graph-performance.sh
```

Potem **restart Obsidiana**.

## 🔗 Related

- [[GRAPH-READY]] - Setup grafu
- [[GRAPH-OPTIMIZATION]] - Dalsze optymalizacje
- [[check-graph-ready.sh]] - Checker script


**Autor**: jakubc  
**Data**: 2025-11-21  
**Status**: ✅ DZIAŁA
