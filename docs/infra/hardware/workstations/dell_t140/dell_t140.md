---
tags:
  - #Dell_T140
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #folder_note
created: 2025-11-22T18:34:00Z
modified: 2025-11-22T18:34:00Z
author: jakubc
title: "dell_t140 — karta główna"
owner: jakubc
---

# dell_t140 — karta główna

Serwer Dell PowerEdge T140 przewidziany jako główny host usług biznesowych (NAS, kontenery, backup). Notka bazuje na strukturze `asus_z77`, aby zachować powtarzalny układ sekcji i checklist.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki
> - 🏢 **Rola:** Serwer on-prem (storage + kontenery + ewentualnie hypervisor)
> - 🧱 **Hardware:** Tower T140, CPU Xeon E-2224 (do potwierdzenia), 32 GB ECC RAM
> - 💾 **Storage:** Hotswap 3.5" + NVMe cache (TBD)
> - 📌 **Status:** Przygotowanie do wdrożenia (sprzęt w magazynie)

## 🗂️ Indeks folderu
- Komponenty planowane: `cpu-intel-xeon-e-2224.md`, `ram-ecc-32gb.md`, `storage-nas-pool.md`, `psu-dell-tnmrm.md`.
- `ops/` – logi instalacji Proxmox/TrueNAS, wymian dysków i aktualizacji firmware iDRAC.

## ✅ Zadania
- [ ] Zidentyfikować finalny system (TrueNAS SCALE vs Proxmox VE).
- [ ] Przygotować listę dysków i macierzy RAID (RAIDZ/RAID10).
- [ ] Wpisać serwer do `docs/infra/network/README.md` (IP, VLAN).
- [ ] Sprawdzić, czy Cloudflare Zero Trust będzie potrzebny (dostęp zdalny do panelu).

## 📝 Notatki operacyjne
> [!abstract] 2025-11-22
> - Dokumentacja utworzona. Wymagany spis numerów seryjnych, weryfikacja gwarancji i inwentaryzacja dysków.

- [ ] Dodać plan konserwacji filtrów i przepływu powietrza (raz na kwartał).

## 🌐 Konfiguracja sieciowa (plan)
> [!info] Parametry wstępne
> - 🔌 **Interfejs:** eno1/eno2 (dual NIC, 1 Gbit) + opcjonalny iDRAC
> - 📍 **IP zarządzający:** 192.168.0.30/24 (propozycja)
> - 🧠 **VLAN:** docelowo VLAN storage (ID TBD) + trunk do switcha głównego
> - 🔐 **Zero Trust:** dostęp przez Tailscale + Cloudflare Tunnel (HTTPS), brak WARP na samym serwerze

## 🔍 Diagnoza - 2025-11-22
> [!todo] Urządzenie offline
> - ⚠️ Serwer nie został jeszcze uruchomiony, brak danych S.M.A.R.T. i logów POST.
> - ✅ Po pierwszym włączeniu wykonać serię testów (memtest, stress-ng, iperf) i opisać wyniki.

## 🔐 Dostęp
- **Out-of-band:** iDRAC (port RJ45) – ustawić silne hasło + 2FA.
- **System:** planowany Proxmox/TrueNAS – docelowy dostęp SSH przez klucze.

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono notę katalogową i listę TODO. |

## 📁 Podfoldery
- (do utworzenia) `ops/`, `storage/`, `case/`

## 🔗 Backlinks
- [[hardware]]
- [[docs/infra/network/README]]
