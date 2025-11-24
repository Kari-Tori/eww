# TODO - Food Heating _(plik główny zadania)_

## Status i zakładane kroki
- [ ] Odgrzać jedzenie (zlecenie Karinam → wykonanie Jakubc)
  - Wymagania: nagrzać piekarnik Lamona do 200 °C (termoobieg), załadować jedzenie, monitorować proces, potwierdzić gotowość.
  - Postępy, log i wszystkie aktualizacje dopisujemy **najpierw tutaj**, a następnie synchronizujemy z `SOP-food-heating.md`.

## Parametry zadania
- **Trudność:** ⭐⭐☆ (średnia – wymaga ciągłego monitoringu i pracy z dwupiętrowym rig-iem).
- **Szacowany czas wykonania:** 60 min (nagrzewanie ~25 min + podgrzewanie/serowanie ~35 min).
- **Zleceniodawca:** Karinam (15:00 utworzyła i zleciła zadanie).
- **Wykonawca:** Jakubc (od 15:20 odpowiedzialny za przebieg operacji).
- **Nagroda / cel biznesowy:** gorący posiłek dla zespołu + odhaczony TODO od Karinam.
- **Wymagane dokumenty/sprzęt:** `TODO/food_heating/cooker.md` (spec piekarnika), rig dwupiętrowy, termometr zewnętrzny.

## Artefakty wspierające
- SOP z instrukcjami krok-po-kroku: `TODO/food_heating/SOP-food-heating.md`
- Specyfikacja piekarnika (Lamona 2000 W, ~10 lat): `TODO/food_heating/cooker.md`

## Harmonogram wykonania
- **Następne zadanie:** monitorować dolną warstwę pizzy i przygotować wydanie (planowana kontrola ~16:20).
- **Ostatnio wykonane:** 16:12 – Karinam wyjęła górną warstwę pizzy (dolna nadal w piekarniku).

## Terminologia
- **Operational Task Log (OTL)** – bieżący dziennik operacyjny zadania TODO.
- **SOP (Standard Operating Procedure)** – dokument tworzony na bazie wielu logów; w tym przypadku `SOP-food-heating.md` zawiera instrukcję krok po kroku.

## Metadane zadania
- Zadanie referencyjne: `TODO/food_heating/TODO-food-heating.md`
- Zleceniodawca: Karinam
- Wykonawca: Jakubc
- Data rozpoczęcia: 2025-11-22
- Lokalizacja sprzętu: kuchnia / piekarnik Lamona (ok. 2000 W, spec: `cooker.md`)
- Cel operacyjny: odgrzanie posiłku dla zespołu

## Log zadania (mirror SOP)
| Czas  | Odpowiedzialny | Status             | Opis krótkiego zdarzenia                                                                   |
|-------|----------------|--------------------|--------------------------------------------------------------------------------------------|
| 15:00 | Karinam        | Zlecenie           | Utworzenie TODO i przekazanie zadania odgrzania jedzenia Jakubcowi.                        |
| 15:20 | Jakubc         | Akceptacja         | Potwierdzenie przyjęcia zadania i start przygotowań.                                       |
| 15:28 | Jakubc         | Start nagrzewania  | Piekarnik Lamona ustawiony na 200 °C termoobieg, przygotowany dwupiętrowy rig.             |
| 15:59 | Jakubc         | Załadunek          | Jedzenie wstawione na rig po stabilizacji temperatury.                                     |
| 16:12 | Karinam        | Rozładunek (góra)  | Górna warstwa pizzy wyjęta; dolna część pozostaje w piekarniku do dalszego dogrzania.      |
| ____  | ____           | ____               | *(miejsce na kolejne zdarzenie – uzupełnij i zsynchronizuj z SOP)*                         |

**Jak dopisać kolejny log?**
1. Dodaj nowy wiersz w powyższej tabeli (czas, osoba, status, krótki opis).
2. Natychmiast zaktualizuj szczegółowy wpis w `TODO/food_heating/SOP-food-heating.md`, aby zachować spójność.

## Zadania podrzędne
- [ ] Monitorować postęp nagrzewania i zanotować temperaturę stabilizacji (ostatni wpis 16:12 – górna warstwa wyjęta).
- [x] Włożyć pojemniki z jedzeniem po osiągnięciu docelowej temperatury (15:59).
- [ ] Potwierdzić gotowość posiłku i zamknąć log wpisem końcowym.

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
