---
title: "Dashboard operacyjny EWW"
description: "Ręczny podgląd KPI i statusów operacyjnych (FCGH, flipy, media, logistyka, finanse)"
created: 2025-12-03
modified: 2025-12-03
tags:
  - ops
  - dashboard
  - kpi
  - eww
  - fcgh
version: 0.0.6
language: pl
category: operations
type: dashboard
status: draft
owner: jakubc
---

# Dashboard operacyjny EWW (grudzień)

> [!info] Jak używać w Obsidian  
> - Włącz pluginy: Dataview (snapshoty z `::`), Tasks (checklisty).  
> - Pola z `___`/`::` uzupełniaj ręcznie po każdym tygodniu.  
> - Sekcje w calloutach są zwarte i czytelne na mobile.

## 🔌 Widoki pluginów
**Snapshot (Dataview)**  
```dataview
table fcgh_weekly, flip_weekly, revenue_month, cash_on_hand
from "ops/dashboard-eww"
```

**Zadania na 7 dni (Tasks plugin)**  
```tasks
not done
path includes ops/dashboard-eww
due on or before in 7 days
```

## 🎯 Cele główne
- 🔄 Sync Odoo <> eBay (dwustronny) uruchomiony.
- 💰 Wyprzedaż pozostałości Cash 4 Device (iPhone 11-14) i reinwestycja w FCGH (https://www.cash4device.co.uk).
- 📦 FCGH działa w pełnym procesie (Odoo + eBay sync).
- 🎯 Przychód brutto: 1500-2000 GBP/mies.
- ▶️ Aktywny kanał YT (2-3 shorty/tydz, start monetyzacji/leady): https://www.youtube.com/@E-WasteWorkshop

## 🗂️ Moduły operacyjne (aktywny scope)
- [[ops/intake/intake]] (INTAKE)
- [[ops/diag]] (DIAG)
- [[ops/repair]] (REPAIR)
- [[ops/sales]] (SALES)
- Nieaktywne/ukryte: `.produkcja`, `.recycle`, `.upcycle`

## 🧩 Postęp celów (uzupełnij)
| Cel | Status | % | Notatka |
| --- | --- | --- | --- |
| Odoo <> eBay sync | sync_status:: ___ | sync_pct:: ___% | deadline 2025-12-10 |
| Wyprzedaż C4D (iPhone 11-14) | c4d_status:: ___ | c4d_pct:: ___% | reinwestycja w FCGH |
| FCGH aktywny proces | fcgh_proc_status:: ___ | fcgh_proc_pct:: ___% | Odoo + eBay |
| Przychód 1500-2000 GBP | rev_status:: ___ | rev_pct:: ___% | target grudzień |
| YT aktywny (2-3 shorty/tydz) | yt_status:: ___ | yt_pct:: ___% | start monetyzacji/leady |

## 🧭 Panel główny (snapshot)
| Obszar | Wartość | Target | Notatka |
| --- | --- | --- | --- |
| FCGH szt./tydz | fcgh_weekly:: ___ | 4 | iPhone 11 jako bazowy |
| FCGH marża/szt (GBP) | fcgh_margin:: ___ | 40-55 | po fees/wysyłce |
| Flipy szt./tydz | flip_weekly:: ___ | 1-2 | tylko ROI>2x |
| Flipy marża/szt (GBP) | flip_margin:: ___ | 50-90 | MTTR krótki |
| % flipy <7 dni | flip_fast_pct:: ___% | >60% | rotacja |
| Shorty/tydz | shorts_weekly:: ___ | 2-3 | teardown/refab/update |
| Leady/tydz | leads_weekly:: ___ | 3-5 | z YT/ogłoszeń |
| Przychód brutto mies. (GBP) | revenue_month:: ___ | 1500-2000 | cash target |
| Cash on hand (GBP) | cash_on_hand:: ___ | n/a | do reinwestycji |

> [!tip] Operacja — fokus  
> - FCGH 4x/tydz (iPhone 11) na istniejących uszkodzonych telefonach + części.  
> - Flipy laptop/PC 1-2/tydz, tylko jasne ROI >2x.  
> - Shorty YT 2-3/tydz dla leadów + ogłoszenia „oddaj sprzęt”.

> [!warning] Ryzyka/logistyka  
> - £0 kapitału, energia ograniczona (detoks) → małe, powtarzalne zadania.  
> - Paczki nie mogą iść na adres Gary’ego → tylko paczkomat/kurier/drop-off.  
> - Bez auta → brak odbiorów fizycznych, tylko zdalne źródła.

> [!summary] KPI quick view  
> - Przychód brutto: 1500-2000 GBP/mies.  
> - FCGH: 4 szt./tydz, marża/szt., lead time.  
> - Flipy: 1-2 szt./tydz, marża/szt., % sprzedaży <7 dni.  
> - Media: 2-3 shorty/tydz, leady z ogłoszeń/komentarzy.

> [!quote] Szansa powodzenia (grudzień)  
> ~50-60% na dowiezienie 1500-2000 GBP, jeśli trzymasz tempo FCGH i selekcję flipów ROI>2x; spada przy braku części/czasu (detoks), rośnie po szybkiej sprzedaży zapasu C4D.
> ~70-80% na dowiezienie 1000 GBP (przy utrzymaniu 4x FCGH/tydz i choć 1 flip tygodniowo).
> ~85-90% na dowiezienie 500 GBP (przy samym minimum FCGH + pojedyncze part-out).

> [!abstract] Logistyka paczek — zasada  
> - Dostawy tylko: paczkomat/locker, kurier na drop-off lub adres zaufanej osoby.  
> - Wymagany tracking + potwierdzenie odbioru (foto/podpis).  
> - W ogłoszeniach: zakaz wysyłki na adres Gary’ego, jasne instrukcje dostawy.

## 📅 Dziś (2025-12-03) — priorytety
- [ ] Spisać asset C4D (iPhone 11-14): stan, wariant, brakujące części, potencjalne ROI.
- [ ] Wytypować najłatwiejsze naprawy (ekran/bateria) i kolejność prac; szybka sprzedaż/part-out do reinwestycji.
- [ ] Ustalić zamówienia brakujących części JIT na bazie listy napraw.
- [ ] Odoo <> eBay sync: doprecyzować zakres/plan prac, deadline 2025-12-10 (due:: 2025-12-10).

> [!todo] Szybkie akcje (codziennie)  
> - Przejrzyj lockery/paczkomaty (tracking + odbiór).  
> - Opublikuj/odśwież shorty (min. 1 dziennie, gdy dostępny materiał).  
> - Oznacz i sfotografuj części z part-out natychmiast po demontażu.  
> - Codzienny update snapshotów `::` (fcgh_weekly, flip_weekly, revenue_month).

## 📆 Tygodniowy log (template)
| Tydzień | FCGH (szt.) | Flipy (szt.) | Shorty (liczba) | Przychód (GBP) | Cash (GBP) | Uwagi |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | ___ | ___ | ___ | ___ | ___ | ___ |
| 2 | ___ | ___ | ___ | ___ | ___ | ___ |
| 3 | ___ | ___ | ___ | ___ | ___ | ___ |
| 4 | ___ | ___ | ___ | ___ | ___ | ___ |

## 📊 KPI szczegółowe
> [!success] FCGH  
> - Szt./tydz (target 4): `___`  
> - Marża/szt: `___ GBP`  
> - Lead time: `___ dni`  
> - Zwroty/DOA: `___%`  

> [!info] Flipy PC/Laptop  
> - Szt./tydz (target 1-2): `___`  
> - Marża/szt: `___ GBP`  
> - Średni MTTR: `___ dni`  
> - % sprzedane w 7 dniach: `___%`  

> [!note] Sourcing  
> - Źródła: drop-off `___`, paczkomat `___`, zakup `___`  
> - % ofert z ROI>2x: `___%`  

> [!hint] Media  
> - Shorty/tydz (target 2-3): `___`  
> - Wyświetlenia/kliknięcia: `___ / ___`  
> - Leady z ogłoszeń/komentarzy: `___`  

> [!example] Finanse  
> - Przychód brutto mies.: `___ GBP`  
> - Cash on hand: `___ GBP`  
> - Reinwestycja w części/zakupy: `___ GBP`  

## ✅ Checklisty operacyjne (bieżące)
- [ ] Pipeline FCGH (dostawcy części, cennik, szablony, checklista testów/pakowania).
- [ ] Ogłoszenia „oddaj sprzęt” + zasady drop-off/paczkomat (adres, godziny, kontakt).
- [ ] Shorty YT 2-3/tydz (teardown/refab/update finansowy/Zero Waste).
- [ ] Selekcja 5-10 ofert laptop/PC z jasnym ROI; kupować tylko te z potwierdzonym MTTR.

## 🚧 Ryzyka i blokery
- Energia ograniczona (detoks) → checklisty, małe zadania.
- Brak auta → tylko paczkomat/kurier/drop-off.
- Kapitał = 0 → zaczynać od posiadanych uszkodzonych telefonów i tanich napraw.
- Utrata paczek na adresie Gary’ego → przestrzegać zasad logistyki.

## 🔗 Backlinks
- [[ops/fcgh/fcgh-notes]]
- [[ops/ops]]
- [[ops/ops-workflow]]
- [[ops/fcgh/fcgh]]
- [[ops/finance/finance]]
- [[ops/intake/intake]]
