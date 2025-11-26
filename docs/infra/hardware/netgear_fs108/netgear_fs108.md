---
tags:
  - #Netgear_FS108
  - #network
  - #switch
  - #folder_note
created: 2025-11-22T19:00:00Z
modified: 2025-11-22T19:00:00Z
author: jakubc
title: "netgear_fs108 — karta główna"
status: dev
owner: jakubc
---

# netgear_fs108 — karta główna

Switch Netgear FS108 8×10/100 Mb/s wykorzystywany w środowisku developerskim do łączenia hostów (GERC, ASUS Z77, router ASUS DSL-N16, Lenovo M710q itd.). Struktura dokumentu bazuje na układzie [[docs/infra/hardware/workstations/asus_z77/asus_z77|asus_z77]].

## ℹ️ Opis i zastosowanie
> [!info] Profil
> - 🔌 **Typ:** switch niezarządzalny 8×FastEthernet
> - 🧪 **Rola:** agregacja połączeń DEV (warsztat EWW)
> - 🌐 **Topologia:** Router Gary → RJ45 → ASUS DSL-N16 → FS108 → hosty LAN
> - 📦 **Status:** Dev (aktywny)

## 🗂️ Indeks folderu
- (do uzupełnienia) `ops/` – logi podłączeń, wymiany zasilaczy.
- (do uzupełnienia) `ports.md` – mapowanie portów 1–8.

## ✅ TODO (@jakubc)
- [ ] Utworzyć `ports.md` z aktualnym mapowaniem (port 1: DSL, port 2: GERC, itp.).
- [ ] Zanotować numer seryjny i datę zakupu.
- [ ] Dodać zdjęcia okablowania w `ops/`.

## 🌐 Konfiguracja / Połączenia
> [!info] Obecne porty
> - Port 1: ASUS DSL-N16 (uplink)
> - Port 2: GERC
> - Port 3: ASUS Z77
> - Port 4: Lenovo M710q (plan)
> - Port 5: Dell Inspiron 3881 (plan)
> - Port 6–8: wolne/testowe

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono dokumentację na bazie asus_z77. |

## 📁 Podfoldery
- (to-create) `ops/`
- (to-create) `ports.md`
