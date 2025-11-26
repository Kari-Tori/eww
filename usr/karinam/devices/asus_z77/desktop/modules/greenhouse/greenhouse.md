---
tags:
  - #greenhouse
  - #flowers
  - #inventory
  - #karinam
  - #dashboard
  - #index
created: 2025-11-22T22:28:00Z
modified: 2025-11-22T22:28:00Z
author: karinam
type: dashboard
owner: karinam
---

# 🌿 Greenhouse - Szklarnia Domowa

## Przegląd

System zarządzania kwiatami domowymi, doniczkami i akcesoriami ogrodniczymi Karinam.

## Struktura

```
greenhouse/
├── greenhouse.md (ten plik - dashboard główny)
├── suculent-1/ (folder + folder note)
├── suculent-2/
├── suculent-3/
├── storczyk/ (❌ nieaktywny)
├── kaktus/
├── bambus/
├── dracena-ananas/
├── chamedora/ (palma domowa)
├── chamedora-2/ (❌ nieaktywna)
├── paprotka/ (lokalizacja: łazienka)
├── assets/ (doniczki zapasowe)
├── seeds/ (nasionka)
└── tools/ (narzędzia, sensory, termometry)
```

## 🌱 Inwentaryzacja Kwiatów

### Aktywne Kwiaty (7)

| # | Kwiat | Status | Lokalizacja | Notatki |
|---|-------|--------|-------------|---------|
| 1 | [[suculent-1/suculent-1\|Suculent 1]] | 🟢 | Desktop | Przywieziony przez Karinę |
| 2 | [[suculent-2/suculent-2\|Suculent 2]] | 🟢 | Desktop | Przywieziony przez Karinę |
| 3 | [[suculent-3/suculent-3\|Suculent 3]] | 🟢 | Desktop | Lokalny |
| 4 | [[kaktus/kaktus\|Kaktus]] | 🟢 | Desktop | Aktywny |
| 5 | [[bambus/bambus\|Bambus]] | 🟢 | Desktop | Aktywny |
| 6 | [[dracena-ananas/dracena-ananas\|Dracena "Ananas"]] | 🟢 | Desktop | Aktywna |
| 7 | [[chamedora/chamedora\|Chamedora]] | 🟢 | Desktop | Palma domowa |

### Kwiaty Specjalne

- [[paprotka/paprotka|🌿 Paprotka]] - 🟡 Lokalizacja: **łazienka** (Bath) - wymaga wysokiej wilgotności

### Historia / Nieaktywne ❌

- [[storczyk/storczyk|Storczyk]] - ❌ **Zabity przez Karinę** 
- [[chamedora-2/chamedora-2|Chamedora 2]] - ❌ **Palma domowa zabita przez Karinę**

---

## 🏺 Akcesoria

### Doniczki (Assets)

**6 dodatkowych doniczek zapasowych** - zobacz [[assets/pot_file|📝 Przykładowa Doniczka]]

### Nasionka (Seeds)

Magazyn nasionek - [[seeds/README|🌱 Seeds Inventory]]

### Narzędzia (Tools)

Sensory, termometry, narzędzia ogrodnicze - [[tools/README|🛠️ Tools Inventory]]

---

## 📋 Parametry Dokumentacji Kwiatów

Każdy kwiat **MUSI** posiadać:

### Struktura Foldera
```
kwiat-nazwa/
├── kwiat-nazwa.md (folder note - główny plik)
├── photos/ (subfolder ze zdjęciami)
│   ├── widok-ogolny.jpg
│   ├── zbliżenie-liscie.jpg
│   └── doniczka.jpg
└── [max 7 dodatkowych plików]
```

### Wymagane Dane
- 📸 **Zdjęcia** (folder `photos/`) - min. 3 sztuki
- 📏 **Średnica doniczki** (cm)
- 📐 **Wysokość kwiata** (cm)
- 🌡️ **Wymagania temperaturowe** (°C)
- 💧 **Częstotliwość podlewania** (dni)
- ☀️ **Wymagania świetlne** (słońce/półcień/cień)
- 📝 **Notatki pielęgnacyjne**
- 📅 **Historia** (daty przesadzenia, nawożenia)

> [!warning] Limit Plików
> Maksymalnie **10 plików** na kwiat (folder note + photos + dokumentacja).

---

## 📊 Dataview - Dashboard Live

### Wszystkie Kwiaty (Status)

```dataview
TABLE 
  status as "Status",
  location as "Lokalizacja",
  height as "Wysokość (cm)",
  pot_diameter as "Doniczka Ø (cm)",
  last_watered as "Ostatnie Podlanie"
FROM "usr/karinam/greenhouse"
WHERE file.name != "greenhouse" AND contains(file.folder, "greenhouse")
SORT status DESC, file.name ASC
```

### Kwiaty Wymagające Uwagi

```dataview
TASK
FROM "usr/karinam/greenhouse"
WHERE !completed AND contains(text, "podlewanie")
SORT priority DESC
LIMIT 10
```

### Ostatnie Aktualizacje

```dataview
TABLE file.mtime as "Ostatnia Modyfikacja"
FROM "usr/karinam/greenhouse"
WHERE file.name != "greenhouse"
SORT file.mtime DESC
LIMIT 10
```

---

## ✅ Zadania Greenhouse

### Inwentaryzacja (Priorytet 7)

- [ ] Sfotografować wszystkie 7 aktywnych kwiatów
- [ ] Zmierzyć wysokości (7x)
- [ ] Zmierzyć średnice doniczek (7x)
- [ ] Uzupełnić opisy pielęgnacyjne
- [ ] Paprotka w łazience - pełna dokumentacja
- [ ] Zinwentaryzować 6 doniczek zapasowych
- [ ] Zinwentaryzować narzędzia (tools)
- [ ] Zinwentaryzować nasionka (seeds)

### Pielęgnacja Regularna

- [ ] Podlewanie zgodnie z harmonogramem
- [ ] Nawożenie (sezon wegetacyjny)
- [ ] Zraszanie paprotki (2-3x/tydzień)
- [ ] Kontrola wilgotności łazienki
- [ ] Czyszczenie liści

---

## 🔗 Linki Powiązane

### Zadania
- [[../TODO/TODO-karinam-list|📋 TODO Lista Karinam]]
- [[../../jakubc/TODO/TODO-daily/TODO-2025-11-22/flowers|🌸 Inwentaryzacja Dziś]]

### Lokalizacje
- [[../house/bath/TODO/flower/flower|🌿 Paprotka w łazience]]
- [[../house/bath/TODO/hole/hole|🕳️ Dziura w łazience (TODO)]]
- [[../desktop/README|🖥️ Desktop (główna lokalizacja kwiatów)]]

### Ogólne
- [[../karinam|👤 Karinam Profile]]
- [[../../core/house/rules/README|🏠 House Rules]]

---

## 📝 Notatki

### Historia
- **2025-11-22**: Karina przywiozła 2 sukulenty (suculent-1, suculent-2)
- **Data nieznana**: Zabita palma chamedora-2
- **Data nieznana**: Zabity storczyk

### Specjalne Wymagania
- **Paprotka**: Wymaga lokalizacji w łazience (wysoka wilgotność!)
- **Sukulenty**: Rzadkie podlewanie, dobre światło
- **Bambus**: Regularne podlewanie, nie lubi przesuszenia

### Obserwacje
```
Karina ma tendencję do zabijania kwiatów wymagających 
specjalnej pielęgnacji (storczyk, chamedora-2).
Sukulenty i rośliny odporne = lepszy wybór.
```

---

**Deadline inwentaryzacji:** 2025-11-22 24:00  
**Priorytet:** 🔴 P7 (wysoki)  
**Odpowiedzialny:** Karinam  
**Wspiera:** Jakubc
