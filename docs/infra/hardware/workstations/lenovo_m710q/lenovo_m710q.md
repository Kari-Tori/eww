---
tags:
  - #Lenovo_M710q
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #folder_note
created: 2025-11-22T18:32:00Z
modified: 2025-11-22T18:32:00Z
author: jakubc
title: "lenovo_m710q — karta główna"
owner: jakubc
---

# lenovo_m710q — karta główna

Mini PC Lenovo ThinkCentre M710q, planowany do roli niskoenergetycznego węzła (np. router LAB / Proxmox node / Home Assistant). Dokumentacja bazuje na układzie `asus_z77`, aby zachować spójność procesów.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki
> - 🖥️ **Rola robocza:** Mikroserwer / węzeł edge (do ustalenia)
> - 🌡️ **Zalety:** Niski pobór mocy, obudowa Tiny, łatwy montaż na ścianie
> - 🧪 **Eksperymenty:** pfSense/OPNsense, Proxmox, kontenery z usługami pomocniczymi
> - 📌 **Status:** W trakcie inwentaryzacji

## 🗂️ Indeks folderu
- Planowane podfoldery: `ops/`, `storage/`, `network/`.
- Komponenty do opisania: CPU i5-6500T (TBD), RAM 16GB DDR4 SO-DIMM, NVMe SATA.

## ✅ Zadania
- [ ] Zidentyfikować OS docelowy (Proxmox vs Ubuntu Server).
- [ ] Ustawić rezerwację DHCP i dodać wpis do `docs/infra/network/README.md`.
- [ ] Wypełnić tabelę komponentów (CPU/RAM/storage).

## 📝 Notatki operacyjne
> [!todo] 2025-11-22
> - Urządzenie znajduje się jeszcze poza siecią produkcyjną. Po zakończeniu konfiguracji należy porównać ustawienia z `asus_z77`, aby uniknąć konfliktów (szczególnie Cloudflare Zero Trust oraz statycznego adresowania).

- [ ] Przygotować nośnik instalacyjny + checklistę provisioningową.

## 🌐 Konfiguracja sieciowa (plan)
> [!info] Wymagane parametry
> - 🔌 **Interfejs:** eno1 (Intel I219-V) + opcjonalny USB-C LAN
> - 📍 **Docelowy IP:** 192.168.0.40/24 (propozycja – do rezerwacji)
> - 🚪 **Gateway:** 192.168.0.10
> - 🌐 **VPN/Zero Trust:** Cloudflare WARP (disabled domyślnie) + Tailscale node
> - 📡 **Usługi:** pfSense/OPNsense lab lub kontenery (TBD)

## 🔍 Diagnoza - 2025-11-22
> [!warning] Urządzenie offline
> - ⚠️ Brak obecnych testów ping/HTTP – host nie został jeszcze podłączony.
> - 📓 Zadania: po wdrożeniu powielić test-case z `asus_z77` (ping 8.8.8.8 z WARP on/off).

## 🔐 Dostęp
- **Fizyczny:** DisplayPort/HDMI + USB-C power brick.
- **Zdalny:** planowany Tailscale SSH + ansible entry.
- [ ] Uzupełnić w `ansible/inventory` właściwy adres i użytkownika.

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono kartę urządzenia i szkic roli serwerowej. |

## 📁 Podfoldery
- (do utworzenia) `ops/`, `storage/`, `network/`

## 🔗 Backlinks
- [[hardware]]
- [[docs/infra/network/README]]
