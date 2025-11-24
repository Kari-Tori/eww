---
tags:
  - #house
  - #dashboard
  - #shared
created: 2025-11-22T16:50:20+00:00
modified: 2025-11-22T16:56:44+00:00
author: jakubc
title: "🏠 House Dashboard"
status: active
owner: house-team
---

# 🏠 House Dashboard

> Szybki panel koordynujący prace domowe. Zbiera linki do obszarów TODO, wyróżnia priorytety i pozwala przeskakiwać między wspólnym backlogiem a prywatnymi kartami w `usr/`.

## 🔢 Szybkie wskaźniki
- `7` aktywnych kart TODO (`maintenance`, `repairs`, `features`, `cooking`, `shopping`, `cleaning`, `other`).
- Status repo: `git status` przed każdą sesją planowania, aby uniknąć konfliktów.
- Najczęstsze źródła zadań: [[usr/jakubc/TODO-home]], [[usr/karinam/TODO-karinam-list]] (linkuj do wspólnych kart po synchronizacji ustaleń).

## 📋 Obszary TODO
| Obszar | Karta | Priorytet | Co obserwować |
|--------|-------|-----------|---------------|
| Maintenance | [[core/house/area/maintenance/TODO]] | 🟢 rutynowe | Terminy przeglądów sezonowych, filtry, systemy HVAC. |
| Repairs | [[core/house/area/repairs/TODO]] | 🔴 krytyczne | Usterki wymagające natychmiastowego działania + części zamienne. |
| Features | [[core/house/area/features/TODO]] | 🟡 średnie | Ulepszenia, automatyzacje, reorganizacja przestrzeni. |
| Cooking | [[core/house/area/cooking/TODO]] | 🟠 wysokie | Plan posiłków i przygotowanie półproduktów tygodniowych. |
| Shopping | [[core/house/area/shopping/TODO]] | 🟡 średnie | Listy zakupowe, kontrola zapasów i zamówienia online. |
| Cleaning | [[core/house/area/cleaning/TODO]] | 🟠 wysokie | Harmonogramy tygodniowe i deep-clean raz w miesiącu. |
| Other | [[core/house/area/other/TODO]] | ⚪ ad-hoc | Pojedyncze tematy do zaklasyfikowania później. |

## ✅ Priorytety tygodnia
- [ ] Zidentyfikuj 2–3 zadania z największym wpływem i przypisz właściciela w odpowiedniej karcie.
- [ ] Porównaj backlog z prywatnymi listami w `usr/`, aby usunąć duplikaty.
- [ ] Dodaj daty (`📅`) do wszystkich terminowych zadań — umożliwia to filtrowanie w pluginie Tasks.

## 🧭 Nawigacja i szablony
- [[core/house/house]] — folder note + mapa Waypoint.
- [[core/house/area/]] — katalog obszarów (`rules.md`, `functions.md`, `raci.md`, `TODO.md`).
- `templates/TODO-template.md` (jeśli potrzebny wspólny szablon; w przeciwnym razie kopiuj istniejące karty).

## 🔁 Ceremonie operacyjne
| Częstotliwość | Akcja | Notatka |
|---------------|-------|---------|
| Poniedziałek | `Przegląd tygodniowy` | Przejrzyj wszystkie `area/*/TODO.md`, ustaw priorytety, dopisz daty. |
| Środa | `Sync z prywatnymi listami` | Sprawdź `usr/` i przenieś wspólne zadania do odpowiednich `area/{obszar}/TODO.md`. |
| Piątek | `Archiwizacja / Retrospekcja` | Wyczyść wykonane zadania w kartach obszarów, zanotuj wnioski tutaj. |

## 📌 Przypięte linki
- [[usr/jakubc/TODO-home]] — prywatny backlog Jakuba (źródło większości inicjatyw).
- [[usr/karinam/TODO-karinam-list]] — kontekst Kariny, pozwala łączyć zadania/opcje.
- [[core/house/area/features/TODO]] — dobre miejsce na odnośniki do inspiracji (zdjęcia, moodboardy).

## 🛠️ Narzędzia wspierające
- Obsidian + pluginy Waypoint i Tasks (lokalne grafy i filtry dat).
- `scripts/check-folder-notes.sh` — szybki test spójności tagów `#folder_note` / linków.
- `rg` + `dataview` — wyszukiwanie zadań i budowa ad-hoc list.

---

**Ostatnia aktualizacja**: 2025-11-22 • Wersja 0.1
