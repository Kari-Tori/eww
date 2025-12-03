---
tags:
  - #cisco
  - #network
  - #hardware
created: 2025-11-23T22:44:32Z
modified: 2025-12-01T20:05:00Z
author: jakubc
title: "Cisco 3650 — specyfikacja"
status: planning
owner: jakubc
---

# Cisco 3650 — specyfikacja

## 🔑 Kluczowe parametry
- Model: Catalyst 3650-24P PoE (WS-C3650-24PS/PD) — 24×1G PoE+
- Architektura: StackWise-160 (do 9 urządzeń, 160 Gbps stack bandwidth)
- Switching capacity: ~160 Gbps; forwarding: ~104 Mpps
- Uplink: modułowy slot, *zainstalowany* `C3KX-NM-1G` (4×1G SFP); opcje wymiany na 2×10G SFP+ lub 4×1G RJ45 (poniżej)
- PoE budget: ~390 W z pojedynczym PSU; ~775 W z redundantnym (sprawdzić dokładne PSU)
- PSU: 1× hot-swap (AC); opcja 2× dla redundancji; wymienne wentylatory
- IOS-XE: wersja do potwierdzenia (`show version`)

## 🎛️ Interfejsy (front)
- 24× 10/100/1000Base-T PoE+ (IEEE 802.3af/at) — auto-MDI/MDIX, PoE budżet wg sekcji PoE
- 1× slot uplink (moduł wymienny):
  - `C3KX-NM-1G` (4×1G SFP) — **zainstalowany**
  - `C3KX-NM-10G` (2×10G SFP+ + 2×1G SFP) — opcja upgrade do 10G uplinków
  - `C3KX-NM-1T` (4×1G RJ45) — opcja dla legacy copper uplinków
- Porty zarządzania/konsoli:
  - RJ-45 console
  - USB mini-B console
  - USB Type-A (storage)

## 🔌 Tył urządzenia
- 1× (opcjonalnie 2×) gniazdo PSU hot-swap AC
- 2× StackWise-160 stacking ports (na modułowym bloku), kable stack dedykowane
- Wentylatory modułowe (wymienne)

## ⚡ PoE / zasilanie
- Budżet bazowy: ~390 W (typowo z PSU 640 W, PoE dostępne ~390 W po narzucie systemowym)
- Budżet z 2× PSU: do ~775 W (zależnie od modelu PSU)
- PoE klasy: 802.3af/at, inteligentny podział mocy (`power inline static/auto`, `priority`)
- Do uzupełnienia: realne `show power inline` po podpięciu urządzeń (AP/kamery/telefon)

## 🚀 Opcje rozbudowy / ulepszenia
- Wymienny moduł uplink: można podmienić `C3KX-NM-1G` na `C3KX-NM-10G` (2×SFP+, 2×SFP) lub `C3KX-NM-1T` (4×RJ45); wymagane okno serwisowe / reload przy zmianie.
- StackWise-160: możliwość dołożenia kabli stack i spięcia do 9 sztuk dla większej dostępności/przepustowości.
- Redundantne PSU: dołożenie drugiego zasilacza zwiększa PoE budget i zapewnia failover.

## 📦 Inwentaryzacja do wypełnienia
- Numer seryjny chassis:
- Numer(y) PSU + moc (W):
- Moduł uplink (PN/SN): `C3KX-NM-1G` (4×1G SFP) — **zainstalowany**
- StackWise cables (długość/PN):e
- Wersja IOS-XE: ``
- Licencja/feature set:

## ✅ Zadania
- [ ] Wpisać realne parametry PSU i budżet PoE po audycie.
- [ ] Uzupełnić PN/SN modułu `C3KX-NM-1G` oraz ewentualnych modułów alternatywnych.
- [ ] Dodać wynik `show inventory`, `show version`, `show power inline`, `show switch stack-ports summary`.
