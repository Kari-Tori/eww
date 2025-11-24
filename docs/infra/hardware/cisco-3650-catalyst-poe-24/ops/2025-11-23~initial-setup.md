---
tags:
  - #ops
  - #deployment
  - #cisco
created: 2025-11-23T22:44:32Z
modified: 2025-11-23T22:44:32Z
author: jakubc
title: "2025-11-23 — uruchomienie Cisco 3650"
status: log
owner: jakubc
---

# 2025-11-23 — uruchomienie Cisco 3650

Wyciąg z [[docs/infra/network/network-deployment-2025-11-23]] koncentrujący się na przełączniku Cisco Catalyst 3650-24P. Ten log służy jako runbook podczas montażu i pierwszej konfiguracji sprzętu.

## 🎯 Cele dnia
1. **Faza 1** — montaż w szafie U42, zasilanie z UPS 5 kW, LED status.
2. **Faza 2** — konfiguracja bazowa (hostname, enable secret, mgmt IP, `show interfaces status`).
3. **Faza 3** — spięcie uplinku z Gary Network przez router dual-WAN.
4. **Faza 4–5** — przygotowanie do przepięcia GERC i ASUS Z77 (urządzenia pozostają online na dotychczasowym switchu do czasu cutover).
5. **Faza 6** — backup `startup-config`, aktualizacja workflow, dodanie assetu do katalogu hardware (ten folder).

## 📍 Notatki lokalizacyjne
- Switch montujemy **w U3–U4** (bezpośrednio pod patch panelem U1–U2) w szafie U42 (pomieszczenie 24 m²).
- Internet z Gary Network wchodzi z góry szafy, dlatego `Gi1/0/1` ma krótki patch do routera dual-WAN.
- Router dual-WAN montujemy tuż pod Catalystem, aby skrócić uplink i mieć dostęp do frontu (łatwe przepięcia WAN).
- Frontowe porty Catalystem muszą być opisane; jeden port zostaje wolny jako „DEV/diag”.

## 🧪 Kroki konfiguracji
1. **Po podaniu zasilania** — podłącz konsolę (USB/serial) i ustaw `hostname CATALYST-CORE`, `enable secret`, `service password-encryption`.
2. **Management** — skonfiguruj SVI `Vlan99` z IP (TBD) i `ip default-gateway` wskazujące router dual-WAN.
3. **Port profili** — `Gi1/0/1` w trybie trunk (`switchport trunk allowed vlan 1,99`), `Gi1/0/2-24` w trybie access (`switchport access vlan 1` lub VLAN 20 dla PoE) z `spanning-tree portfast`.
4. **PoE** — domyślnie włączone; przed podpięciem AP/IoT zweryfikuj `show power inline` oraz budżet 390W.
5. **Monitoring** — `logging buffered`, `logging host ...`, `snmp-server community ... RO` (wartości TBD) + `archive` auto-save configu.

## 🪜 Timeline (wg logu wdrożenia)
- **20:00** — start równoległego środowiska; istniejące hosty (GERC, ASUS Z77) nadal na Netgear FS108.
- **20:10** — decyzja o pełnym równoległym buildzie; Catalyst to punkt wejściowy do GaryNet. Szafa U42 potwierdzona jako miejsce docelowe.
- **Cel dnia** — ukończyć fazy 1–3, przygotować migrację hostów oraz dodać tę kartę sprzętu do repo.

## ✅ Checklisty operacyjne
- [ ] `show inventory` + zdjęcia (front/back) → załączyć do folderu.
- [ ] Potwierdzić wersję IOS-XE i licencje (`show ver`, `show license`).
- [ ] Opisać przewody (GaryNet uplink, router dual-WAN, porty hostów) etykietą heatshrink.
- [ ] Po zakończeniu dnia wykonać `copy running-config startup-config` i zanotować godzinę w logu.
- [ ] Zgłosić update w [[docs/infra/network/network-deployment-2025-11-23]] i [[docs/infra/hardware/hardware.md]].

## 🔗 Powiązane
- [[../README]]
- [[../ports]]
- [[docs/infra/network/network-deployment-2025-11-23]]
