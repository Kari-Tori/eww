# 🗺️ STRATEGIA NAPRAWY GRAFU OBSIDIAN

## Problem
- **499 plików MD** → graf się sypie (limit ~20 dla przejrzystości)
- "too many to handle" = za dużo połączeń

## Rozwiązanie

### 1. FILTROWANIE (graph.json)
```json
"search": "-path:archive/ -path:var/log/ -path:karinam/"
```

### 2. UKRYCIE SIEROT
```json
"showOrphans": false  ✅ już jest
```

### 3. FOCUS NA GŁÓWNYCH HUB'ACH
Pokazuj tylko:
- Folder notes (indexes)
- Główne dokumenty (README, INDEX, etc)
- Core workflow files

### 4. SEPARATE GRAPHS (per folder)
- Local graph dla każdego folderu
- Główny graf tylko top-level

## Implementacja
