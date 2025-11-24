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
title: "WiFi — Broadcom BCM4352"






owner: jakubc
---



# WiFi — Broadcom BCM4352

| Pole | Wartość |
| --- | --- |
| Model | Broadcom BCM4352 802.11ac Dual Band Wireless Network Adapter |
| Chipset | BCM4352 (rev 03) |
| Standard | 802.11ac (WiFi 5) Dual Band (2.4 GHz + 5 GHz) |
| Interface | PCIe (06:00.0) |
| System interface | wlp6s0 |
| Status | DOWN (zainstalowana, ale nieużywana) |
| Sterownik | TODO (prawdopodobnie brcmfmac lub wl) |

## O chipset Broadcom BCM4352
> [!info] Broadcom BCM4352
> - Standard: 802.11ac Wave 1 (do 867 Mbps @ 5 GHz)
> - Dual-band: 2.4 GHz (300 Mbps) + 5 GHz (867 Mbps)
> - Rok wprowadzenia: ~2013
> - Powszechnie używany w laptopach i kartach PCIe

## Konfiguracja w systemie
```bash
# Interface
wlp6s0: DOWN (nie w użyciu)

# Karta zainstalowana w slocie PCIe
lspci | grep Network
06:00.0 Network controller: Broadcom Inc. and subsidiaries BCM4352 802.11ac Dual Band Wireless Network Adapter (rev 03)
```

## Dlaczego DOWN?
> [!note] Ethernet preferowany
> - System używa przewodowego Ethernetu (eno1: Intel I218-V) jako głównego interfejsu sieciowego.
> - WiFi zainstalowane jako backup/opcja, ale obecnie wyłączone.
> - IP: 192.168.0.99/24 przypisane do eno1 (Ethernet).

## Sterowniki w Linux
> [!warning] Broadcom i Linux
> Chipset BCM4352 w Linux wymaga proprietary driver:
> - **brcmfmac** - open-source driver (ograniczone możliwości)
> - **wl** (broadcom-sta) - proprietary driver (lepsza wydajność)
>
> Instalacja:
> ```bash
> # Ubuntu/Debian
> sudo apt install broadcom-sta-dkms
>
> # lub
> sudo apt install firmware-b43-installer
> ```

## Zadania
- [ ] @karinam sprawdzić aktualny sterownik: `lsmod | grep -i bcm`
- [ ] @karinam zanotować czy karta WiFi była kiedykolwiek aktywna (historia NetworkManager).
- [ ] @karinam dodać instrukcje aktywacji WiFi (jeśli potrzebne jako backup).
- [ ] @karinam sprawdzić firmware version: `modinfo brcmfmac` lub `modinfo wl`.
- [ ] @karinam rozważyć czy karta jest potrzebna (jeśli nie, można usunąć z PCIe slot).
