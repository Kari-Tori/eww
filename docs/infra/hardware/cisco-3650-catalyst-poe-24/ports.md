---
tags:
  - #cisco
  - #network
  - #ports
  - #vlan
created: 2025-11-23T22:44:32Z
modified: 2025-11-23T22:44:32Z
author: jakubc
title: "Cisco 3650 — profil portów"
status: planning
owner: jakubc
---

# Cisco 3650 — profil portów

Tabela odwzorowuje planowane profile interfejsów zgodnie z [[docs/infra/network/network-deployment#🛠️-Etapy-wdrożenia|planem wdrożenia]]. Po migracji z Netgear FS108 należy aktualizować kolumnę `Status` i dopisać dokładne MAC hostów. Wszelkie zmiany konfiguracji (VLAN, PoE, opis portu) kopiujemy tu jako źródło prawdy.

## VLAN-y (draft)
| VLAN ID | Nazwa | Zastosowanie | Notatki |
| --- | --- | --- | --- |
| 1 | LAN-Core | Hosty produkcyjne (GERC, ASUS Z77, Lenovo M710q, Dell T140) | Domyślna sieć 192.168.0.0/24 z routerem dual-WAN jako bramą. |
| 20 | IoT-PoE | Kamery, AP, okablowanie strukturalne PoE | Utworzyć ograniczony dostęp do WAN (firewall na routerze). |
| 99 | Mgmt | Zarządzanie Catalystem (loopback / SVI) | IP management TBD, planowany dostęp tylko z GERC. |

## Porty fizyczne (Gi1/0/x)
| Port     | Typ           | VLAN/tryb         | Przeznaczenie                          | Status   | Notatki                                                                       |
| -------- | ------------- | ----------------- | -------------------------------------- | -------- | ----------------------------------------------------------------------------- |
| Gi1/0/1  | Access/Uplink | Trunk (VLAN 1,99) | Router dual-WAN (pfSense/Mikrotik/ISR) | 🟡 plan  | Krótki patch z routera stojącego pod Catalystem; oznaczyć jako `Uplink-Core`. |
| Gi1/0/2  | Access        | VLAN 1            | Patch panel → GERC (192.168.0.99)      | 🟡 plan  | Pierwszy host do migracji (Faza 4).                                           |
| Gi1/0/3  | Access        | VLAN 1            | Patch panel → ASUS Z77 (192.168.0.77)  | 🟡 plan  | Drugi host do migracji (Faza 5).                                              |
| Gi1/0/4  | Access        | VLAN 1            | Patch panel → Dell T140                | 🟡 plan  | Docelowo storage/kontenery.                                                   |
| Gi1/0/5  | Access        | VLAN 1            | Patch panel → Lenovo M710q             | 🟡 plan  | Host + WD Elements 6TB.                                                       |
| Gi1/0/6  | Access (PoE)  | VLAN 20           | AP #1 / IoT uplink                     | 🔴 wolne | Wymaga audytu PoE budżetu.                                                    |
| Gi1/0/7  | Access (PoE)  | VLAN 20           | Kamera #1                              | 🔴 wolne | Kabel prowadzony z góry szafy.                                                |
| Gi1/0/8  | Access (PoE)  | VLAN 20           | Kamera #2 / telefon IP                 | 🔴 wolne | TBD.                                                                          |
| Gi1/0/24 | Access        | VLAN 1            | Port `DEV/diag` frontowy               | 🟡 plan  | Służy do diagnostyki/lab (laptopy, testers).                                  |

> [!note] Pozostałe porty Gi1/0/9–23 ustaw w trybie `shutdown` dopóki nie będzie scenariusza użycia. Przy każdym aktywowanym porcie dodaj opis (`description <host>`).

## Zadania portowe
- [ ] Dodać konfigurację `interface range Gi1/0/2-24` z opisami i `switchport` profilami w repo.
- [ ] Utworzyć `logging event link-status` dla portów 1–8 (monitoring).
- [ ] Wpisać bieżące wartości `power inline` gdy tylko pojawią się urządzenia PoE.
- [ ] Dodać wpis o `storm-control` i `bpduguard` dla portów access.
