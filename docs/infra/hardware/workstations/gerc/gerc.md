<!--
 * @Author: jakubc jakub@eww.local
 * @Date: 2025-11-21 20:13:13
 * @LastEditors: jakubc jakub@eww.local
 * @LastEditTime: 2025-11-22 11:03:31
 * @FilePath: /eww/docs/infra/hardware/workstations/gerc/gerc.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
---
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
  - #folder_note
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "gerc — karta główna"






---



# gerc — karta główna

Jednostka robocza na platformie Intel X99 (LGA2011-v3) pełniąca rolę GERC - głównego węzła obliczeniowego i laboratorium w infrastrukturze EWW. Dual GPU (2× GTX 980 Ti), 8-rdzeniowy CPU (i7-5960X), 32 GB RAM DDR4.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki
> - 💻 **Rola:** Workstation główny + laboratorium (GERC = host wszystkiego)
> - 🎮 **Konfiguracja:** Dual GPU GTX 980 Ti (SLI/niezależne), multi-display setup
> - 📊 **Zastosowanie:** Docker/containerы, kompilacja, rendering, AI/ML inference, VM hosting
> - 🌐 **Sieć:** 192.168.0.99/24 (eno1), gerc.local, Tailscale VPN
> - 🧩 **Infrastruktura:** Vault Obsidian, DevOps automation, backupy, produkcja + testy

## ⚙️ Specyfikacja (Dataview)
```dataview
TABLE icon AS " ", model AS "Model", specs AS "Specyfikacja", value AS "Wartość"
FROM "docs/infra/hardware/workstations/gerc"
WHERE component
SORT file.name
```

## 🗂️ Indeks komponentów
- `motherboard-asus-x99-pro.md`, `cpu-intel-i7-5960x.md`, `ram-corsair-vengeance-32gb.md`
- `gpu-nvidia-gtx980ti.md`, `psu-corsair.md`
- `case/` (np. `case-index.md`, `case-chassis.md`, `case-fans.md`, `case-cpu-cooler.md`)
- `storage/` (np. `storage-index.md`, dyski NVMe/SATA)
- `ops/` – oś czasu operacji i serwisów

## ✅ Zadania @karinam (folder gerc)
```dataview
TASK
FROM "docs/infra/hardware/workstations/gerc"
```

## ✅ Zadania globalne (wszystkie pliki)
```dataview
TASK
FROM ""
WHERE contains(text, "gerc") OR contains(text, "GERC")
```

## 📝 Notatki operacyjne = Ops timeline
> [!abstract] YYYY-MM-DD · [Zakup](ops/YYYY-MM-DD~zakup.md)
> - TODO: data zakupu, źródło, cena jednostki (X99-PRO + i7-5960X).

> [!info] YYYY-MM-DD · [Pierwsza instalacja](ops/YYYY-MM-DD~pierwsza-instalacja.md)
> - TODO: pierwsza instalacja Ubuntu/Kubuntu, wersja systemu.

> [!success] YYYY-MM-DD · [Dual GPU setup](ops/YYYY-MM-DD~modernizacja-gpu.md)
> - TODO: instalacja 2× GTX 980 Ti, konfiguracja SLI/niezależna.

> [!important] YYYY-MM-DD · [Wdrożenie do infrastruktury](ops/YYYY-MM-DD~wdrozenie.md)
> - Formalne wpięcie do środowiska EWW
> - Hostname: GERC, IP: 192.168.0.99, gerc.local
> - TODO: dokładna data wdrożenia.

> [!tip] 📔 Log serwisów (ciągły)
> - TODO: dodać timeline serwisów, modernizacji dysków, wymiany komponentów.

- [ ] @karinam utworzyć pliki ops z konkretnymi datami wydarzeń.
- [ ] @karinam dodać szczegóły każdego wydarzenia (ceny, źródła, screenshoty).

## 🌐 Konfiguracja sieciowa
- **Hostname:** GERC
- **IP:** 192.168.0.99/24 (eno1 - Intel I218-V)
- **Gateway:** 192.168.0.10
- **DNS:** 1.1.1.1, 8.8.8.8
- **Hostname lokalny:** gerc.local
- **VPN:** Tailscale (fe80::f949:a3aa:6683:32cd/64)
- **WiFi:** wlp6s0 (Broadcom BCM4352, DOWN - karta zainstalowana, nieużywana)

## 🔍 Diagnostyka sieci (2025-11-22)
> [!info] Testy referencyjne
> - ✅ `ping -c4 192.168.0.77` (asus_z77) — działa, więc łączność LAN dwukierunkowa jest poprawna.
> - ✅ `ping -c4 8.8.8.8` oraz `curl https://example.com` — GERC posiada pełny dostęp do internetu.
> - ✅ `traceroute 8.8.8.8` pokazuje poprawną trasę przez 192.168.0.10.
> - ℹ️ Używanie GERC jako punktu odniesienia potwierdza, że router ASUS DSL-N16 i połączenie WAN działają; problem sieciowy dotyczy wyłącznie asus_z77.
> - ☁️ GERC również korzysta z Cloudflare Zero Trust/WARP + Tailscale. `warp-cli status` = CONNECTED, ale ruch do internetu działa, więc polityki Zero Trust wymagają porównania z konfiguracją asus_z77 (szczególnie tryb always-on i split tunnel).

## 🔊 Konfiguracja audio

> [!tip] **Automatyczna konfiguracja**
> System jest skonfigurowany do automatycznego ustawiania SONY TV jako domyślnego wyjścia audio przy każdym starcie.
>
> **Usługa systemd:** `eww-audio-sony-tv.service` (user)
> **Skrypt:** `~/git/eww/scripts/audio-setup-sony-tv.sh`
> **Dokumentacja:** [audio-setup-README.md](audio-setup-README.md)

### Urządzenia audio

- **Karta 0:** HDA Intel PCH (C610/X99) - wbudowana karta dźwiękowa
  - Codec: ALC1150
  - Porty: Front Mic, Rear Mic, Line In, Line Out, Headphones, S/PDIF
  - Status: OFF (nieużywana)

- **Karta 1:** HDA NVidia (GTX 980 Ti #1, PCI 0000:02:00.1)
  - 4× HDMI outputs (wszystkie niedostępne)
  - Status: OFF

- **Karta 2:** HDA NVidia (GTX 980 Ti #2, PCI 0000:01:00.1) - **AKTYWNA**
  - HDMI 0: HP 27 Curved (monitor, dostępne)
  - HDMI 1: SONY TV *00 (dostępne) - **WYJŚCIE GŁÓWNE**
  - HDMI 2-3: niedostępne
  - Aktywny profil: `output:hdmi-stereo-extra1`

### Konfiguracja PulseAudio

- **Domyślne wyjście:** `alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1`
  - Urządzenie: SONY TV (HDMI 1, karta 2)
  - Format: s16le 2ch @ 48000 Hz
  - Port: hdmi-output-1 (HDMI / DisplayPort 2)
  - ALSA: card=2, device=7, subdevice=0

- **Dodatkowe urządzenia:**
  - `alsa_output.2.hdmi-stereo` - HP 27 Curved (HDMI 0, karta 2)
  - `combined` - moduł combine-sink (niewykorzystywany)

### Setup HDMI ARC

- **TV:** SONY TV *00 podłączony do karty 2, HDMI 1
- **Soundbar:** podłączony do TV przez HDMI ARC
- **Routing:** PC → HDMI (GTX 980 Ti #2) → SONY TV → HDMI ARC → Soundbar
- **Aplikacje:** Firefox, Spotify, powiadomienia systemowe → SONY TV

### Komendy konfiguracyjne

```bash
# Restart PulseAudio
pulseaudio -k && sleep 2 && pulseaudio --start

# Ustawienie SONY TV jako domyślne wyjście
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1

# Kontrola głośności
pactl set-sink-volume alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 100%

# Status
pactl list sinks short
pactl info | grep "Domyślny odpływ"

# Test dźwięku
speaker-test -D hdmi:CARD=NVidia_1,DEV=1 -c 2 -t wav -l 1
```

## 💡 Monitoring (sensors snapshot)

- **CPU Package:** 53°C (idle/light), max 87°C (high), 105°C (crit)
- **CPU Cores:** 45-51°C
- **NVMe:** 42.9°C
- **PSU VRM:** 41.5°C, Case temp: 30.2°C
- **GPU:** (sprawdź `nvidia-smi`)
- **Power draw:** 210W (idle/light), ~700W peak (dual GPU + CPU full load)

## Historia zmian

| Data | Opis |
| --- | --- |
| 2025-11-22 | Dodano szczegółową konfigurację audio (HDMI, PulseAudio, SONY TV + soundbar) |
| 2025-11-22 | Pełna restrukturyzacja według wzoru asus_z77, dodano szczegółowe dane CLI, utworzono case/storage/ops |
| 2025-11-19 | Utworzono strukturę folderu i linki do komponentów. |

## 📑 Index plików

Komponenty główne:

- [cpu-intel-i7-5960x](cpu-intel-i7-5960x.md)
- [motherboard-asus-x99-pro](motherboard-asus-x99-pro.md)
- [ram-corsair-vengeance-32gb](ram-corsair-vengeance-32gb.md)
- [gpu-nvidia-gtx980ti](gpu-nvidia-gtx980ti.md)
- [psu-corsair](psu-corsair.md)

Komponenty starsze (do aktualizacji/usunięcia):
- [case](case.md) → przejdzie do `case/case-chassis.md`
- [cooling](cooling.md) → przejdzie do `case/case-cpu-cooler.md`
- [cpu](cpu.md) → zastąpiony przez `cpu-intel-i7-5960x.md`
- [fans](fans.md) → przejdzie do `case/case-fans.md`
- [gpu](gpu.md) → zastąpiony przez `gpu-nvidia-gtx980ti.md`
- [motherboard](motherboard.md) → zastąpiony przez `motherboard-asus-x99-pro.md`
- [psu](psu.md) → zastąpiony przez `psu-corsair.md`
- [ram](ram.md) → zastąpiony przez `ram-corsair-vengeance-32gb.md`
- [storage](storage.md) → przejdzie do `storage/storage.md`

## 📁 Podfoldery

- [case/](case/case-index.md) - Obudowa, wentylatory, chłodzenie
- [ops/](ops/ops.md) - Historia operacyjna, timeline wydarzeń
- [storage/](storage/storage-index.md) - Dyski, storage index
- [pcie/](pcie/) - Dodatkowe karty PCIe (WiFi, etc.)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]
