---
tags:
  - #Lenovo_Y700
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #folder_note
created: 2025-11-22T18:30:00Z
modified: 2025-11-22T18:30:00Z
author: jakubc
title: "lenovo_y700 — karta główna"
owner: jakubc
---

# lenovo_y700 — karta główna

Mobilny laptop gamingowy Lenovo Y700 pełniący rolę terenowej stacji roboczej. Bazuje na szablonie `asus_z77`, aby zachować spójny układ dokumentacji i checklist. Urządzenie wykorzystywane jest, gdy potrzebny jest fizyczny dostęp do LAN (diagnostyka) lub praca w ruchu.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki
> - 💻 **Rola:** Mobilny workstation + diagnostyka sieci w terenie
> - 👥 **Użytkownik:** jakubc (głównie), okazjonalnie karinam
> - 🎯 **Use case:** Remote access do zasobów GERC/asus_z77, testy Cloudflare Zero Trust, backup awaryjny
> - 🌐 **Hotspot:** Laptop zapewnia awaryjny uplink – łączy się po Wi-Fi z iPhone (karinam/jakubc) i przekazuje internet do LAN/routera ASUS DSL-N16
> - 📦 **Stan:** Aktywny, wymaga dopięcia pełnych metryk sprzętowych

## 🗂️ Indeks folderu
- Planowane pliki komponentów: `cpu-intel-i7-6700hq.md`, `gpu-nvidia-gtx960m.md`, `ram-ddr4-16gb.md`, `storage-ssd-samsung.md`.
- `ops/` – logi wymian dysków, reinstalacji Windows/Linux, aktualizacji BIOS.

## ✅ Zadania @jakubc
- [ ] Sprawdzić wersję BIOS i zanotować w `ops/`.
- [ ] Przygotować obraz recovery i dopisać procedurę restore.
- [ ] Skonfigurować Cloudflare Zero Trust wg lekcji z `asus_z77` (split tunnel, brak always-on).

## ✅ Zadania globalne
- [ ] Uzupełnić specyfikację komponentów (CPU/GPU/RAM/storage).
- [ ] Dowiązać laptop do inwentarza sprzętowego w `docs/infra/hardware/hardware.md`.

## 📝 Notatki operacyjne
> [!note] 2025-11-22
> - Laptop przejęty do dokumentacji. Aktualnie służy jako referencja do testów Cloudflare Zero Trust po incydencie na `asus_z77`. Konieczny pełny przegląd sprzętowy.

- [ ] @jakubc przygotować checklistę konserwacji baterii i czyszczenia układu chłodzenia.

## 🌐 Konfiguracja sieciowa
> [!info] Parametry wstępne (do potwierdzenia)
> - 🔌 **Interfejs główny:** wlp2s0 (Wi-Fi 802.11ac), fallback: enp3s0 (USB-C/LAN)
> - 🌍 **Tryb adresacji:** DHCP (192.168.0.0/24), brak statycznych rezerwacji
> - 🚪 **Gateway:** 192.168.0.10 (ASUS DSL-N16)
> - 🌀 **VPN/Zero Trust:** Cloudflare WARP + Tailscale (tylko po konfiguracji split-tunnel)
> - 📶 **Note:** przy pracy diagnostycznej należy ręcznie wyłączyć WARP przed pingami (patrz `asus_z77`).

> [!tip] Runbook tetheringu
> - Aktualny stan WAN i instrukcja krok po kroku: [[docs/infra/status_sieci]].

## 🔍 Diagnoza - 2025-11-22
> [!warning] Weryfikacja po incydencie WARP
> - ❓ Status: brak aktywnych testów — urządzenie nie było jeszcze wpięte podczas awarii.
> - ✅ Lekcja z `asus_z77`: nie włączać `warp-cli connect` z wymuszonym always-on dopóki polityka CFZT nie zostanie zrewidowana.
> - 🔧 TODO: przeprowadzić testy `ping` + `curl` (HTTP/HTTPS) przy aktywnym i wyłączonym WARP.
> - 🌐 TODO: @jakubc udokumentować pełny łańcuch tetheringu (iPhone → Wi-Fi → Y700 → WAN routera) i dopisać procedurę włączania/wyłączania.

## 🔐 Dostęp / SSH
- **OS:** Dual boot (Windows 11 / Ubuntu 24.04) – szczegóły do potwierdzenia.
- **Połączenie zdalne:** preferowany Tailscale lub RustDesk; brak stałego SSH (port blokowany mobilnie).
- [ ] Zadanie: skonfigurować jednolite hasło administracyjne lub klucz FIDO + BitLocker recovery.
- [ ] Zadanie: zapisać dane hotspotów (iPhone karinam/jakubc) w managerze haseł i opisać jak automatycznie udostępnić je na Y700.

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono kartę urządzenia na bazie szablonu `asus_z77`. |

## 📑 Index plików
- TODO: `cpu-intel-i7-6700hq.md`
- TODO: `gpu-nvidia-gtx960m.md`
- TODO: `storage-ssd-samsung.md`
- TODO: `ops/2025-XX-XX~diagnostyka-warp.md`

## 📁 Podfoldery
- (do utworzenia) `ops/`, `storage/`, `case/`

## 🔗 Backlinks
- [[hardware]]
- [[EWW-MAP]]
- [[docs/infra/network/README]]
