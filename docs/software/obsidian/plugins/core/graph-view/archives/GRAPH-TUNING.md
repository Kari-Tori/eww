---
version: 0.0.3
tags:
  - #automation
  - #graph
  - #eww
  - #guide
created: 2025-11-21
modified: 2025-11-28
author: jakubc
title: "📖 GRAPH: Instrukcja Tuningu"
owner: jakubc
---

# 📖 GRAPH: Instrukcja Tuningu

> **Jak dostroić separację klastrów grafów**

## 🎯 Problem: Klastry się mieszają?

Graf Obsidian używa **force-directed layout** - węzły się przyciągają i odpychają.
Jeśli klastry się mieszają, trzeba dostroić **4 kluczowe parametry**.

## ⚙️ Kluczowe parametry

### 1. **repelStrength** (odpychanie)
Jak mocno węzły się od siebie odpychają:
- `10-15` - słabe (klastry blisko siebie)
- `20-30` - średnie (normalna separacja)
- `35-50` - silne (duża separacja)
- `>50` - ekstremalne (mogą się rozlecieć)

### 2. **linkDistance** (odległość linków)
Jak długie są połączenia między węzłami:
- `200-400` - krótkie (gęsty graf)
- `500-700` - średnie (normalny spacing)
- `800-1200` - długie (rozległy graf)
- `>1200` - bardzo długie (może być chaotyczny)

### 3. **centerStrength** (centrowanie)
Jak mocno graf jest przyciągany do centrum:
- `0.01-0.05` - słabe (luźna struktura) ✅
- `0.1-0.3` - średnie (balans)
- `0.5-1.0` - silne (wszystko w środku)

### 4. **linkStrength** (siła łączenia)
Jak mocno linki przyciągają węzły:
- `0.1-0.3` - słabe (luźne klastry)
- `0.4-0.6` - średnie (normalne łączenie)
- `0.7-1.0` - silne (zwarte klastry)

## 🎨 Predefiniowane presety

### 🟢 MILD - Łagodna separacja
```json
{
  "repelStrength": 15,
  "linkDistance": 400,
  "centerStrength": 0.15,
  "linkStrength": 0.7
}
```
**Efekt**: Klastry blisko siebie, łatwo zobaczyć połączenia

### 🟡 MEDIUM - Średnia separacja (OBECNY)
```json
{
  "repelStrength": 25,
  "linkDistance": 600,
  "centerStrength": 0.05,
  "linkStrength": 0.5
}
```
**Efekt**: Dobry balans separacji i czytelności

### 🟠 STRONG - Silna separacja
```json
{
  "repelStrength": 35,
  "linkDistance": 800,
  "centerStrength": 0.03,
  "linkStrength": 0.3
}
```
**Efekt**: Wyraźnie oddzielone klastry, duża przestrzeń

### 🔴 EXTREME - Ekstremalna separacja
```json
{
  "repelStrength": 50,
  "linkDistance": 1200,
  "centerStrength": 0.01,
  "linkStrength": 0.1
}
```
**Efekt**: Maksymalna separacja, klastry bardzo daleko

## 🛠️ Jak użyć?

### Metoda 1: Interaktywny skrypt
```bash
bash tune-graph-separation.sh
```
Wybierz preset lub wpisz własne wartości.

### Metoda 2: Ręczna edycja
1. Edytuj `.obsidian/graph.json`
2. Zmień wartości parametrów
3. Zapisz plik
4. Restart Obsidian

### Metoda 3: Bezpośrednio w Obsidian
1. Otwórz Graph View
2. Kliknij ikonkę ustawień (⚙️)
3. Rozwiń "Forces"
4. Przesuń slidery:
   - **Center force** → centerStrength
   - **Repel force** → repelStrength
   - **Link force** → linkStrength
   - **Link distance** → linkDistance

## 💡 Rekomendacje

### Dla małych vault (<100 plików):
- **MILD** lub **MEDIUM**
- Mniejsza separacja = lepiej widać strukturę

### Dla średnich vault (100-300 plików):
- **MEDIUM** lub **STRONG**
- Potrzebujesz separacji, ale nie za dużo przestrzeni

### Dla dużych vault (>300 plików):
- **STRONG** lub **EXTREME**
- Maksymalna separacja aby nie było chaosu

### Dla vault z wieloma klastrami (>10):
- **EXTREME** + filtry
- Pokazuj tylko wybrane klastry naraz

## 🎯 Przykładowe scenariusze

### "Klastry nachodzą na siebie"
```
repelStrength: 25 → 40
linkDistance: 600 → 900
```

### "Graf jest za rozległy, nie widzę struktury"
```
repelStrength: 40 → 25
linkDistance: 900 → 500
centerStrength: 0.03 → 0.1
```

### "Chcę zobaczyć tylko połączenia w klastrze"
```
linkStrength: 0.5 → 0.8
repelStrength: 25 → 15
```

### "Klastry są OK, ale zbyt gęste wewnątrz"
```
linkDistance: 600 → 800
# (nie zmieniaj repelStrength)
```

## 📊 Testowanie

Po każdej zmianie:
1. **Restart Obsidian**
2. **Otwórz Graph View** (Ctrl+G)
3. **Poczekaj 5-10 sekund** (animacja)
4. **Oceń efekt**
5. **Dostosuj** jeśli potrzeba

## 🔗 Related

- [[GRAPH-CLUSTERS]] - System klastrów
- [[fix-graph-clusters.sh]] - Podstawowa konfiguracja
- [[tune-graph-separation.sh]] - Interaktywny tuning
- `.obsidian/graph.json` - Plik konfiguracyjny

## 📝 Notatki

- Zmiany w `graph.json` wymagają **restartu Obsidian**
- Backup tworzony automatycznie w `.obsidian/backups/`
- Możesz cofnąć zmiany: `git checkout .obsidian/graph.json`
- Local graph używa **tych samych parametrów**

---
**Tip**: Zacznij od MEDIUM, potem zwiększaj/zmniejszaj stopniowo! 🎯

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]