---
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T00:00:00Z
author: jakubc
title: "ASUS X99-PRO — karta płyty głównej"






owner: jakubc
---



# ASUS X99-PRO — karta płyty głównej

## 1. Producent, osiągi i specyfikacja

| 🏷️ Pole | 📚 Wartość |
| --- | --- |
| 🏭 Producent | ASUSTeK COMPUTER INC. |
| 📦 Model / rewizja | X99-PRO (Rev 1.xx) |
| 🆔 Numer seryjny | 141034128000863 |
| 🧠 Chipset | Intel X99 (Wellsburg) |
| 🧬 Socket CPU | [LGA2011-v3](https://en.wikipedia.org/wiki/LGA_2011) — obsługuje Intel Haswell-E/Broadwell-E (np. i7-5960X) |
| 🧵 RAM | 8 × DDR4 DIMM (maks. 128 GB, 2133-3333 MHz OC) — patrz [RAM](ram-corsair-vengeance-32gb.md) |
| 🎮 GPU | 4 × PCIe 3.0 ×16 (x16/x16/x8 lub x16/x8/x8/x8) — obsługa 3-way/4-way SLI/CrossFireX |
| 💾 Magazyn | 10 × SATA 6Gb/s + M.2 socket + SATA Express — szczegóły w [Storage](storage/storage-index.md) |
| 🧮 BIOS | American Megatrends Inc. 4101 (2019-07-10) |
| 💰 Koszt premierowy (2014) | ok. 260-300 USD (segment enthusiast/workstation) |
| 💷 Wartość wtórna (2025) | ~150-200 GBP (model X99 nadal popularny w home lab) |
| 🧾 Wolumen | brak oficjalnych danych (model dla entuzjastów) |
| 🖥️ Firmware Age | 6 lat 4 miesiące 2 tygodnie (od ostatniej aktualizacji) |

## 2. Znaczenie historyczne i odbiór
> [!note] Kontekst 2014
> - Platforma X99 wprowadziła DDR4, 40 linii PCIe 3.0, obsługę 8-rdzeniowych CPU.
> - X99-PRO to model mid-range z pełnym zestawem slotów (8× RAM, 4× PCIe x16).
> - Kierowany do workstation/rendering/gaming enthusiast builds.

> [!quote] Odbiór w mediach i wśród użytkowników
> - Recenzje (TechPowerUp, HardOCP) chwaliły solidną sekcję VRM i bogate I/O.
> - Krytykowali brak niektórych premium features z wyższych modeli (Deluxe/WS).
> - Użytkownicy cenili stosunek cena/możliwości i stabilność przy OC.

## 3. Dzisiejsze zastosowania
> [!success] Reuse w 2025
> - Popularna w home lab, NAS builds (10× SATA), rendering farms, multi-GPU setups.
> - Platforma X99 nadal aktualna dla wielu zadań: Docker, VM, AI/ML inference.
> - DDR4 i PCIe 3.0 zapewniają kompatybilność z nowszym sprzętem.

## 4. Złącza, kontrolery i linki
- 🎮 **PCIe / grafika** → `[GPU](gpu-nvidia-gtx980ti.md)`: 4 × PCIe 3.0 x16, obsługa SLI/CrossFireX (2×, 3×, 4× GPU).
- 🧵 **Pamięć** → `[RAM](ram-corsair-vengeance-32gb.md)`: 8 × slotów DDR4 DIMM (4 kanały, do 128 GB).
- 💾 **SATA / M.2** → `[Storage](storage/storage-index.md)`: 10 × SATA 6Gb/s + M.2 Socket 3 + SATA Express.
- 🔌 **USB**: 8 × USB 3.0 (4 × Intel, 4 × ASMedia) + 6 × USB 2.0.
- 🌐 **Sieć**: Intel I218-V Gigabit Ethernet (eno1: 192.168.0.99/24) — patrz sekcja Notatki sieciowe.
- 🌐 **WiFi/BT**: Broadcom BCM4352 802.11ac Dual Band (wlp6s0) — patrz [WiFi](pcie/pcie-wifi-bcm4352.md).
- 🔊 **Audio**: Realtek ALC1150 8-kanałowy codec.
- ⚙️ **Dodatki**: UEFI BIOS, Fan Expert 3, DIGI+ VRM, Q-LED diagnostics.

## 5. Prekursor, następca, rywal

| Rola | Model | Chipset | Rok | Notatka |
| --- | --- | --- | --- | --- |
| 🔁 Prekursor | ASUS P9X79 DELUXE | Intel X79 | 2012 | LGA2011 (Ivy Bridge-E), DDR3, poprzednia platforma HEDT |
| 🔄 Następca | ASUS X299 PRIME | Intel X299 | 2017 | LGA2066 (Skylake-X/Kaby Lake-X), nowsza platforma HEDT |
| ⚔️ Rywal AMD | ASUS ROG Crosshair VI Hero | AMD X370 | 2017 | AM4 (Ryzen), DDR4, alternatywa AMD dla enthusiast builds |

## 6. Notatki sieciowe
> [!hint] LAN `eno1` (Intel I218-V)
> - IPv4: `192.168.0.99/24`
> - Gateway: `192.168.0.10` (router)
> - DNS: `1.1.1.1`, `8.8.8.8` (Cloudflare + Google)
> - Hostname: `GERC`, `gerc.local`
> - Źródło: `ip -brief address`, `hostnamectl`

> [!hint] WiFi `wlp6s0` (Broadcom BCM4352)
> - Status: DOWN (karta zainstalowana, ale nie używana)
> - Standard: 802.11ac Dual Band
> - Więcej: [pcie/pcie-wifi-bcm4352.md](pcie/pcie-wifi-bcm4352.md)

## 7. Zadania (`@karinam`)
- [x] Wersja BIOS/UEFI (4101) – zweryfikowano.
- [ ] Opisać obsadzenie wszystkich slotów PCIe (2× GPU, WiFi, inne karty).
- [ ] Potwierdzić aktywność wszystkich portów SATA (ile dysków podłączonych).
- [ ] Dodać szczegóły konfiguracji RAID (jeśli jest) i boot order.
- [ ] Zanotować sterowniki chipsetu i wersję Intel ME firmware.
- [ ] Sprawdzić profile wentylatorów w BIOS (Fan Expert 3).
