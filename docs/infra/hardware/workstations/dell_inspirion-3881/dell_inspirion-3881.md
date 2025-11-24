---
tags:
  - #Dell_Inspirion_3881
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #folder_note
created: 2025-11-22T18:36:00Z
modified: 2025-11-22T18:36:00Z
author: jakubc
title: "dell_inspirion-3881 — karta główna"
owner: jakubc
---

# dell_inspirion-3881 — karta główna

Desktop Dell Inspiron 3881 (konfiguracja OEM) używany jako lekka stacja robocza / stanowisko do zadań biurowych i testów peryferiów. Dokument stworzony na podstawie szablonu `asus_z77`.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki
> - 👨‍💻 **Rola:** Lekki workstation (Odoo, eBay listingi, Office)
> - 🔧 **Specyfikacja:** Core i5 10. gen, 16 GB RAM, SSD NVMe 512 GB (do potwierdzenia)
> - 🎯 **Cel:** Utrzymywać kompatybilność z drukarkami/skanerami i zapewnić zapasową maszynę testową
> - 📍 **Lokalizacja:** WARSZTAT (stanowisko recepcyjne)

## 🗂️ Indeks folderu
- Pliki komponentów: CPU (i5-10400), RAM (DDR4 16 GB), storage (NVMe + HDD), GPU (Intel UHD).
- `ops/` – log reinstalacji Windows 11 Pro + sterowniki Della.

## ✅ Zadania
- [ ] Zebrać dokładne części (Service Tag + konfiguracja fabryczna).
- [ ] Dodać notę o kompatybilności drukarek (USB + Wi-Fi).
- [ ] Sprawdzić, czy Cloudflare Zero Trust klient jest potrzebny (prawdopodobnie NIE – stacja lokalna).

## 📝 Notatki operacyjne
> [!note] 2025-11-22
> - Urządzenie dodane do katalogu hardware. Wymaga audytu bezpieczeństwa (kont użytkownika, aktualizacje Windows, backup).

## 🌐 Konfiguracja sieciowa
> [!info] Parametry
> - 🔌 **Interfejs:** Intel I219-LM (Ethernet) + Wi-Fi 802.11ac
> - 📍 **IP:** DHCP (192.168.0.x), docelowa rezerwacja np. 192.168.0.50
> - 🚪 **Gateway:** 192.168.0.10
> - 🔐 **VPN:** brak; jeśli konieczne, użyć Tailscale aby uniknąć problemów WARP (wg doświadczeń `asus_z77`)

## 🔍 Diagnoza - 2025-11-22
> [!todo] Stan początkowy
> - ⚠️ Nie wykonano jeszcze testów wydajności ani sieci – wymagane `ping 8.8.8.8` i `speedtest`.
> - ✅ Zadanie: utworzyć snapshot konfiguracji Windows (listy aplikacji + plan aktualizacji).

## 🔐 Dostęp
- **OS:** Windows 11 Pro
- **Kontrola dostępu:** Konto Microsoft (do potwierdzenia) + PIN; plan: przejść na lokalny account + YubiKey.
- [ ] Dodać szczegóły logowania / sekcję w managerze haseł (nie w repo).

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Stworzono kartę urządzenia według standardu `asus_z77`. |

## 📁 Podfoldery
- (do utworzenia) `ops/`, `drivers/`, `peripherals/`

## 🔗 Backlinks
- [[hardware]]
- [[docs/infra/network/README]]
