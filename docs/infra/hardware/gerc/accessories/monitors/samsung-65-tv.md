---
version: 0.0.1
tags:
  - #monitor
  - #tv
  - #samsung
  - #gerc
  - #accessory
  - #4k
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "Samsung 65\" TV - Monitor główny GERC"
parent_device: gerc
type: display
owner: jakubc
---

# Samsung 65" TV - Monitor główny GERC

## ℹ️ Informacje podstawowe

> [!info] Specyfikacja
> - **Typ:** TV LED / Monitor
> - **Marka:** Samsung
> - **Przekątna:** 65"
> - **Rozdzielczość:** 3840×2160 (4K UHD)
> - **Panel:** LED
> - **Częstotliwość:** 60 Hz (TODO: weryfikacja)
> - **Status:** Aktywny (główny monitor GERC)

## 🔌 Połączenie

### Wideo
- **Źródło:** GERC - GTX 980 Ti (GPU1)
- **Kabel:** HDMI
- **Port GPU:** HDMI output
- **Port TV:** HDMI 1 (TODO: weryfikacja numeru)
- **Tryb:** PC/Monitor mode

### Audio
- **Routing:** HDMI → TV → HDMI ARC → Sony Soundbar
- **Konfiguracja:** PulseAudio HDMI output
- **Profil:** `hdmi-stereo-extra1`
- **Sink:** `alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1`

## 📐 Konfiguracja

### Display settings (xrandr)
```bash
# TODO: dodać output z xrandr
xrandr --output HDMI-1 --mode 3840x2160 --rate 60 --primary
```

### Audio settings (PulseAudio)
```bash
# Restart PulseAudio
pulseaudio -k && sleep 2 && pulseaudio --start

# Ustaw SONY TV jako domyślne
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1

# Głośność
pactl set-sink-volume alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 100%

# Test
speaker-test -D hdmi:CARD=NVidia_1,DEV=1 -c 2 -t wav -l 1
```

## 🎯 Zastosowanie

- **Primary display** - Główny monitor robocizy
- **Multimedia** - Filmy, YouTube podczas pracy
- **Gaming** - (jeśli używane)
- **Prezentacje** - Duży ekran do demonstracji

## 🔧 Konserwacja

- [ ] Oczyścić ekran
- [ ] Sprawdzić kable HDMI
- [ ] Zaktualizować firmware TV (jeśli dostępne)
- [ ] Sprawdzić ustawienia obrazu

## 📝 Notatki

> [!note] Setup
> - TV montowany na ścianie lub stojaku (TODO: weryfikacja)
> - Odległość od użytkownika: ~2-3m (TODO: zmierzyć)
> - Oświetlenie: TODO - opisać setup oświetlenia

> [!tip] Optymalizacja
> - Tryb "PC" włączony dla lepszej jakości tekstu
> - Game Mode wyłączony (input lag nie jest problemem)
> - Jasność/kontrast dostosowane do oświetlenia pomieszczenia

## 🔗 Powiązane

- [[gerc/gerc]] - Komputer macierzysty
- [[accessories/audio/sony-soundbar]] - Wyjście audio
- [[gerc/gpu-nvidia-gtx980ti]] - Karta graficzna źródłowa

## 📋 TODO

- [ ] Dodać dokładny model TV (Samsung UN65xxxxx)
- [ ] Dodać numer seryjny
- [ ] Dodać datę zakupu i cenę
- [ ] Zrobić zdjęcie setup
- [ ] Udokumentować wszystkie ustawienia TV
- [ ] Zapisać konfigurację xrandr

## 🔗 Backlinks

- [[docs/infra/hardware/gerc/accessories/monitors/monitors]]
- [[docs/docs]]
- [[INDEX]]