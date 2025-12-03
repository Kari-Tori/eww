---
tags:
  - #cisco
  - #network
  - #hardware
  - #folder_note
created: 2025-11-23T22:44:32Z
modified: 2025-11-23T22:44:32Z
author: jakubc
title: "Cisco Catalyst 3650-24P PoE — karta główna"
status: planning
role: core_switch
location: "Rack U42 (front, U38–U42)"
owner: jakubc
---

# Cisco Catalyst 3650-24P PoE — karta główna

Centralny przełącznik warstwy dostępowej z PoE, który przejmuje rolę Netgear FS108 i staje się podstawą modernizacji opisanej w [[../network-deployment|planie wdrożenia]]. Folder zawiera wszystkie informacje operacyjne o urządzeniu w sieci EWW: fizyczną lokalizację, plan kablażu, log wdrożenia oraz zadania.

## 🔎 Profil urządzenia
> [!info] Najważniejsze fakty
> - **Model:** Cisco Catalyst 3650-24P PoE (24×1G PoE+, stacking, modular PSU)
> - **Rola:** Core switch + dystrybucja PoE i VLAN w środowisku PROD (GaryNet ↔ hosty)
> - **Status:** Planowanie + przygotowanie wdrożenia (patrz [[ops/2025-11-23~initial-setup|log operacyjny]])
> - **Uplink główny:** `Gi1/0/1 → Router dual-WAN` (pfSense/Mikrotik/ISR)
> - **Scope:** zastępuje Netgear FS108 w szafie U42 oraz zapewnia PoE dla AP/kamer/IoT
> - **Zależności:** [[../garynet]], router dual-WAN, zasilanie z UPS 5 kW

## 🧩 Kontekst sieci
- Plan docelowy (dual-WAN + Catalyst) jest opisany w [[../network-deployment]].
- Bieżące zadania operacyjne i log z dnia 2025-11-23 znajdują się w [[../network-deployment-2025-11-23]]; najważniejsze wpisy zostały zmirrorowane w pliku [[ops/2025-11-23~initial-setup]].
- Status łańcucha WAN (iPhone → Lenovo Y700 → ASUS DSL-N16 → Netgear) z [[docs/infra/hardware/network/status/wan-fallback-2025-11-23]] wskazuje dlaczego Catalyst musi przejąć rolę core switcha.
- Po wpięciu Catalystem do GaryNet obowiązuje zasada „stare środowisko działa równolegle” — zero downtime podczas migracji hostów.

## 📦 Zakres inwentaryzacji
| Element | Opis | Status |
| --- | --- | --- |
| **Hardware** | Numer seryjny, moduły PSU, wersja IOS-XE | 🟡 do zebrania (wykonać `show inventory`) |
| **Konfiguracja** | VLAN 1 (LAN), VLAN 20 (IoT/PoE), profile portów `Gi1/0/x` | 🟡 draft w [[cisco-3650-ports]] |
| **Połączenia** | Router dual-WAN, hosty prod (GERC, ASUS Z77, Lenovo M710q, Dell T140) | 🟡 planowane przepięcia (Fazy 4–5) |
| **PoE budżet** | Sumaryczne zapotrzebowanie AP/kamer/telefonów | 🔴 brak danych (wymaga audytu urządzeń PoE) |
| **Monitoring** | Syslog/SNMP/export config do repo | 🔴 brak (dopiero w fazie 6) |

## 📍 Lokacja fizyczna i okablowanie
- **Szafa serwerowa U42 (pomieszczenie 24 m²)** — Catalyst montujemy wysoko (U38–U42) tuż pod panelem krosowym, frontem do drzwi dla łatwego dostępu do portów i konsoli (info z [[../network-deployment#🏗️-Lokalizacja-fizyczna-(rack-U42-+-biurko-DEV)|plan wdrożenia]]).
- **Uplink GaryNet**: krótki patch od patch panelu (góra szafy) do `Gi1/0/1` wraz z połączeniem do routera dual-WAN stojącego bezpośrednio pod Catalystem.
- **Port diagnostyczny**: zostaw jeden frontowy port oznaczony „DEV/diag”, aby dało się szybko podpiąć laptopa lub tester RJ45 (zalecenie z planu wdrożenia).
- **Zasilanie**: obie wtyczki PSU do listwy UPS 5 kW; dodać opis na przewodach.

## ⚙️ Etapy wdrożenia (snapshot 2025-11-23)
1. **Faza 1–2** — montaż fizyczny i config bazowy (hostname, management IP, backup `startup-config`).
2. **Faza 3** — spięcie uplinku z GaryNet i walidacja portu (`show interfaces status`).
3. **Faza 4–5** — migracja hostów GERC/ASUS Z77 z Netgear FS108 na Gi1/0/x Catalystem jednocześnie z konfiguracją VLANów.
4. **Faza 6** — backup configu, aktualizacja workflow w `core/workflow/infrastructure.md`, stworzenie dokumentu topologii Gary Network.

Szczegóły i timestampy znajdziesz w [[ops/2025-11-23~initial-setup]].

## 🗂️ Struktura folderu
- `cisco-3650-plan.md` — plan wdrożenia i checklisty.
- `cisco-3650-ports.md` — profilowanie portów i VLAN.
- `cisco-3650-specs.md` — specyfikacja techniczna i inwentaryzacja hardware.
- `ops/2025-11-23~initial-setup.md` — wycinek logu wdrożeniowego powiązanego z Catalystem.

## ✅ TODO / kolejne kroki
- [ ] Zebrać pełne `show inventory`, `show version`, `show power inline` i wkleić do tego folderu.
- [ ] Wpisać docelowe adresy IP management + konfigurację VLAN do `cisco-3650-ports.md`.
- [ ] Dodać schemat patchcordów (diagram/zdjęcia) w `ops/` po montażu.
- [ ] Skonfigurować backup configu do repo (`copy running-config tftp://…`).
- [ ] Uaktualnić [[docs/infra/hardware/hardware.md]] oraz [[../network]] po zakończeniu migracji.

## 🔗 Powiązane
- [[../network-deployment]]
- [[../network-deployment-2025-11-23]]
- [[docs/infra/hardware/network/status/wan-fallback-2025-11-23]]
- [[../garynet]]
- [[docs/infra/hardware/network/netgear_fs108/netgear_fs108]] (urządzenie zastępowane)

## 🔗 Backlinks

- [[docs/infra/hardware/network/cisco-3650-catalyst-poe-24/cisco-3650-catalyst-poe-24]]
- [[docs/docs]]
- [[INDEX]]
