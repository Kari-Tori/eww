---
version: 0.0.1
tags:
  - #mobile
  - #iphone
  - #folder_note
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "mobile_devices — karta główna"
status: dev
owner: jakubc
---

# mobile_devices — karta główna

Folder zbiorczy dla urządzeń mobilnych wykorzystywanych jako awaryjne źródło internetu (hotspot) i sprzęt komunikacyjny. Struktura wzorowana na [[docs/infra/hardware/workstations/asus_z77/asus_z77|asus_z77]].

## ℹ️ Opis i zastosowanie
> [!info] Profil
> - 📱 **Urządzenia:** iPhone 13 Pro Max (martwy – spuchnięta bateria), iPhone 11 Pro Max (aktywny hotspot), iPhone Kariny (hotspot backup).
> - 🌐 **Rola:** Dostarczanie internetu przez LTE → Wi-Fi hotspot → Lenovo Y700 → ASUS DSL-N16.
> - ⚠️ **Problem:** Długotrwały tethering niszczy baterie i blokuje możliwość odbierania połączeń (telefony leżą za oknem).
> - 📄 **Instrukcja:** bieżący runbook znajduje się w [[docs/infra/hardware/network/status/wan-fallback-2025-11-23]].

## 🗂️ Indeks folderu
- (plan) `iphone-13-pro-max.md`
- (plan) `iphone-11-pro-max.md`
- (plan) `iphone-karina.md`

## ✅ TODO (@jakubc)
- [ ] Opisać każdy telefon w osobnym pliku (stan baterii, numer SIM, taryfa).
- [ ] Przygotować runbook wymiany/ładowania hotspotów.
- [ ] Po powrocie DSL przełączyć telefony z trybu non-stop hotspot i wykonać serwis (wymiana baterii, utylizacja spuchniętego iPhone 13).

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono folder na bazie szablonu asus_z77. |

## 🔗 Backlinks

- [[docs/infra/hardware/mobile/phones/phones]]
- [[docs/docs]]
- [[INDEX]]