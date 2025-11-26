---
tags:
  - "#greenhouse"
  - "#kwiaty"
  - "#dashboard"
created: 2025-11-22T22:47:00Z
modified: 2025-11-22T22:47:00Z
author: karinam
owner: karinam
---

# 🌸 Flowers Dashboard

Dashboard wszystkich kwiatów w greenhouse.

## ✅ Kwiaty żywe

```dataview
TABLE
  file.folder as "Lokalizacja",
  wysokosc as "Wys. (cm)",
  srednica_doniczki as "Doniczka Ø",
  data_zakupu as "Zakup",
  ostatnie_podlanie as "Ostatnie podlanie"
FROM "usr/karinam/greenhouse"
WHERE status = "żywy"
AND file.name != "greenhouse"
AND file.name != "flowers_dashboard"
SORT file.name ASC
```

## ⚰️ Kwiaty martwe

```dataview
TABLE
  file.folder as "Lokalizacja",
  data_smierci as "Data śmierci",
  przyczyna as "Przyczyna"
FROM "usr/karinam/greenhouse"
WHERE status = "martwy"
AND file.name != "greenhouse"
AND file.name != "flowers_dashboard"
SORT data_smierci DESC
```

## 🚨 Kwiaty wymagające uwagi

```dataview
TABLE
  file.folder as "Kwiat",
  ostatnie_podlanie as "Ostatnie podlanie",
  dni_od_podlania as "Dni temu"
FROM "usr/karinam/greenhouse"
WHERE status = "żywy"
AND dni_od_podlania > 7
AND file.name != "greenhouse"
AND file.name != "flowers_dashboard"
SORT dni_od_podlania DESC
```

## 📊 Statystyki ogólne

### Podsumowanie

- **Kwiaty żywe**: `= length(filter(file.lists.file, (f) => contains(f.path, "greenhouse") AND f.status = "żywy"))`
- **Kwiaty martwe**: `= length(filter(file.lists.file, (f) => contains(f.path, "greenhouse") AND f.status = "martwy"))`
- **Doniczki**: 6 dodatkowych (assets)

### Rozkład według typu

```dataview
TABLE WITHOUT ID
  file.tags[0] as "Typ",
  length(rows) as "Liczba"
FROM "usr/karinam/greenhouse"
WHERE file.name != "greenhouse"
AND file.name != "flowers_dashboard"
AND !contains(file.folder, "assets")
GROUP BY file.tags[0]
```

## 🔔 Przypomnienia

### Harmonogram podlewania

```dataview
TASK
FROM "usr/karinam/greenhouse"
WHERE contains(text, "podlać")
```

### Najbliższe nawożenie

```dataview
TABLE
  file.name as "Kwiat",
  ostatnie_nawozenie as "Ostatnie",
  nastepne_nawozenie as "Następne"
FROM "usr/karinam/greenhouse"
WHERE nastepne_nawozenie
AND file.name != "greenhouse"
AND file.name != "flowers_dashboard"
SORT nastepne_nawozenie ASC
LIMIT 5
```

## 🔗 Szybkie linki

- [[greenhouse.md|Główny index greenhouse]]
- [[assets/doniczki/|Doniczki]]
- [[assets/nasionka/|Nasionka]]
- [[assets/tools/|Narzędzia]]
- [[assets/sensors/|Sensory]]

---

**Ostatnia aktualizacja**: 2025-11-22
