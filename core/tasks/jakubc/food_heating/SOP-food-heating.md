---
version: 0.0.1
tags:
  - #sop
  - #operations
  - #jakubc
  - #karinam
  - #food-heating
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "SOP - Food Heating"
document_type: sop
related:
  - TODO/food_heating/TODO-food-heating.md
  - TODO/food_heating/cooker.md
owner: jakubc
---

# SOP – Food Heating

Instrukcja krok po kroku jak przeprowadzić zadanie „Odgrzać jedzenie” z wykorzystaniem piekarnika Lamona (spec: `cooker.md`). Log operacyjny i aktualne statusy prowadzimy w `TODO/food_heating/TODO-food-heating.md`.

## Krok 0 – Wejście i wymagania
1. Odbierz zlecenie (zwykle Karinam) i zanotuj w TODO.
2. Zweryfikuj zasoby:
   - Piekarnik Lamona 2000 W (efektywnie 1600 W).
   - Dwupiętrowy rig oraz termometr/sonda.
   - Pojemniki/pizze do podgrzania.
3. Potwierdź nagrodę / cel (np. posiłek dla zespołu) i estymowany czas 60 min.

## Krok 1 – Przygotowanie piekarnika
1. Usuń pozostałości z poprzedniego cyklu, zamontuj rig.
2. Sprawdź drzwi i uszczelki; w razie potrzeby przetrzyj easy-clean.
3. Jeżeli potrzebujesz rozdzielić komorę, użyj separatora lub własnego panelu.

## Krok 2 – Nagrzewanie
1. Ustaw tryb termoobiegu na 200 °C.
2. Zakładaj realny czas nagrzewania 20–25 min (współczynnik 0,8 względem katalogu).
3. Monitoruj temperaturę sondą – moment stabilizacji zapisz w TODO (sekcja logu).

## Krok 3 – Załadunek
1. Wsuń jedzenie na oba poziomy, dbając o równą cyrkulację powietrza.
2. Delikatnie zamknij drzwi, aby nie zgubić temperatury.
3. Zapisz w TODO godzinę załadunku i ewentualne uwagi (np. różnice temperatur).

## Krok 4 – Monitorowanie i częściowy rozładunek
1. Co ~10 min kontroluj stan obu poziomów.
2. W razie potrzeby zdejmij górną warstwę wcześniej – loguj kto i kiedy to robi.
3. Zachowuj spójność wpisów (TODO + ewentualnie krótkie notatki w tym SOP-ie).

## Krok 5 – Zakończenie
1. Wyjmij dolny poziom po osiągnięciu oczekiwanej temperatury/chrupkości.
2. Wyłącz piekarnik, uchyl drzwi do ostygnięcia i wyczyść komorę + rig.
3. W TODO:
   - Odhacz zadanie,
   - Dodaj wpis z godziną zakończenia i krótkim podsumowaniem.

## Załącznik A – blok obliczeń (szacunek nagrzewania do 200 °C)

Założenia robocze:
- Piekarnik 65 l (0,065 m³) startuje z 20 °C, cel 200 °C ⇒ ΔT = 180 K.
- Masa stalowych ścian + rusztów ~15 kg, ciepło właściwe stali 0,5 kJ/(kg·K).
- Dwupiętrowy rig (aluminium/stal mieszane) ~3 kg, uśrednione ciepło właściwe 0,9 kJ/(kg·K).
- Powietrze: gęstość 1,2 kg/m³, cp ≈ 1 kJ/(kg·K).
- Moc znamionowa 2000 W, degradacja wydajności −20 % ⇒ moc efektywna 1600 W (1,6 kJ/s).

Obliczenia energii:
1. Ściany/ruszt: 15 kg × 0,5 kJ/(kg·K) × 180 K = **1350 kJ**.
2. Rig: 3 kg × 0,9 kJ/(kg·K) × 180 K = **486 kJ**.
3. Powietrze: (0,065 m³ × 1,2 kg/m³) × 1 kJ/(kg·K) × 180 K ≈ **14 kJ**.
4. Łącznie energia ≈ **1350 + 486 + 14 = 1850 kJ**.

Czas nagrzewania (ignorując straty dynamiczne):
```
czas = energia / moc = 1850 kJ / 1,6 kJ/s ≈ 1156 s ≈ 19,3 min
```

Wnioski:
- Realnie 20–25 min przez straty (drzwi, nieszczelności, sterowanie impulsowe).

## 🔗 Backlinks

- [[core/tasks/jakubc/food_heating/food_heating]]
- [[core/core]]
- [[core/config]]