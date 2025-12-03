---
version: 0.0.4
modified: 2025-11-25
title: asus_z77 — Płyta główna
component: motherboard
icon: 🧩
model: ASUS P8Z77-V DELUXE
specs: Intel Z77 · LGA1155 · BIOS 2104 (2013-08-13)
value: 3 × PCIe x16 · 4 × DDR3 · dual LAN + Wi-Fi GO!/BT
author: jakubc
created: 2025-11-21
updated: 2025-11-19
---

# ASUS P8Z77-V DELUXE — karta płyty

## 1. Producent, osiągi i specyfikacja

| 🏷️ Pole | 📚 Wartość |
| --- | --- |
| 🏭 Producent | ASUStek Computer Inc. |
| 📦 Model / rewizja | P8Z77-V DELUXE (Rev 1.xx) |
| 🧠 Chipset | Intel Z77 (Panther Point) + Intel Virtu MVP |
| 🧬 Socket CPU | [LGA1155](https://en.wikipedia.org/wiki/LGA_1155) — obsługuje Intel Sandy/Ivy Bridge (np. i7-3770K) |
| 🧵 RAM | 4 × DDR3 DIMM (maks. 32 GB, 1066–2800 MHz OC) — patrz [RAM](ram-corsair-vengeance-16gb.md) |
| 🎮 GPU | PCIe 3.0 ×16 dla [GPU](gpu-nvidia-gtx1660ti.md) z obsługą multi-GPU |
| 💾 Magazyn | SATA 6/3 Gb/s + eSATA — szczegóły w [Storage](storage/storage-index.md) |
| 🧮 BIOS | American Megatrends 2104 (2013-08-13) |
| 💰 Koszt premierowy (2012) | ok. 280 USD (segment high-end „enthusiast”) |
| 💷 Wartość wtórna (2025) | ~70–90 GBP (nasz egz. ~£80) |
| 🧾 Wolumen | brak oficjalnych danych (model niszowy) |

## 2. Znaczenie historyczne i odbiór
> [!note] Kontekst 2012  
> - Flagowy model dla chipsetu Z77: wprowadzał UEFI EZ Mode, Fan Xpert 2, moduł Wi‑Fi GO! i BIOS Flashback bez CPU.  
> - Zaprojektowany jako „all-in-one” dla overclockerów i domowej rozrywki (Wi‑Fi, Bluetooth, Thunderbolt header, bogate I/O).

> [!quote] Odbiór w mediach i wśród użytkowników  
> - Recenzje (AnandTech, TechPowerUp) chwaliły stabilność OC i bogactwo akcesoriów, krytykowały wysoką cenę ~280 USD.  
> - Konsumenci traktowali płytę jako produkt premium do pokazowych buildów, co budowało jej status „kultowego” modelu Z77.

## 3. Dzisiejsze zastosowania
> [!success] Reuse w 2025  
> - Retro/nostalgia build (PCIe 3.0 + DDR3), domowe laby testowe, budżetowe NAS-y z wieloma SATA/USB, projekty OC Ivy Bridge.  
> - Chipset Z77 wciąż daje Smart Response, Rapid Start i sporo złącz, więc dobrze nadaje się do recyklingu CPU Sandy/Ivy Bridge.

## 4. Złącza, kontrolery i linki
- 🎮 **PCIe / grafika** → `[GPU](gpu-nvidia-gtx1660ti.md)`: 3 × PCIe x16 (x16/x8 + x8/x4) + 4 × PCIe x1, SLI/CrossFireX.  
- 🧵 **Pamięć** → `[RAM](ram-corsair-vengeance-16gb.md)`: 4 sloty DDR3 DIMM do 32 GB.  
- 💾 **SATA / eSATA** → `[Storage](storage/storage-index.md)`: Intel PCH (2 × 6 Gb/s + 4 × 3 Gb/s) + ASMedia ASM1061 (2 × eSATA).  
- 🔌 **USB**: 8 × USB 3.0 (4 × Intel, 4 × ASMedia ASM1042) + 10 × USB 2.0.  
- 🌐 **Sieć**: Intel 82579V + Realtek 8111F, moduł [Wi‑Fi GO!](pcie-wifi-go.md) 802.11n + Bluetooth 4.0 (mini‑PCIe).  
- 🔊 **Audio**: Realtek ALC898 8‑kanałowy, DTS UltraPC II / DTS Connect.  
- ⚙️ **Dodatki**: DIGI+ VRM (16 faz), TPU/EPU, Fan Xpert 2, przyciski Power/Reset/Clr CMOS, Thunderbolt header, UEFI EZ Mode.

## 5. Prekursor, następca, rywal

| Rola | Model | Chipset | Rok | Notatka |
| --- | --- | --- | --- | --- |
| 🔁 Prekursor | ASUS P8Z68-V PRO/GEN3 | Intel Z68 | 2011 | pierwsza płyta ASUS z PCIe 3.0 (GEN3) i podobną sekcją VRM |
| 🔄 Następca | ASUS Z87-DELUXE | Intel Z87 | 2013 | wejście na LGA1150/Haswell, nowsze SATA Express i USB 3.0 |
| ⚔️ Rywal AMD | ASUS Crosshair V Formula-Z | AMD 990FX | 2012 | entuzjastyczny odpowiednik dla platformy AM3+ |

## 6. Notatki sieciowe
> [!hint] LAN `enp13s0` (Intel 82579V)  
> - IPv4 `192.168.0.77/24`, brama `192.168.0.10`, DNS `1.1.1.1 / 8.8.8.8`.  
> - Źródło: `ip -brief address`, `nmcli device show enp13s0`.

## 7. Zadania (`@karinam`)
- [x] Wersja BIOS/UEFI (2104) – zweryfikowano.
- [ ] Opisać obsadzenie slotów PCIe/SATA/USB (co jest fizycznie podłączone), w tym moduły Wi‑Fi/Bluetooth.
- [ ] Potwierdzić aktywność modułu Wi‑Fi GO! i Thunderbolt + zanotować sterowniki chipsetu.

## 🔗 Backlinks

- [[docs/infra/hardware/asus_z77/asus_z77]]
- [[docs/docs]]
- [[INDEX]]