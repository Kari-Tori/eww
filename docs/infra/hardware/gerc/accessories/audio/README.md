---
tags:
  - #audio
  - #gerc
  - #soundbar
  - #accessories
created: 2025-11-22T18:36:00Z
modified: 2025-11-22T18:36:00Z
author: jakubc
title: "GERC - Audio"
owner: jakubc
---

# GERC - Audio

Dokumentacja konfiguracji audio dla workstation GERC.

## 🔊 Urządzenia audio

### Sony Soundbar
- **Model:** TODO: dokładny model Sony
- **Połączenie:** HDMI ARC z Samsung TV
- **Status:** Aktywne (główne wyjście audio)

📄 Szczegóły: [sony-soundbar.md](sony-soundbar.md)

### Słuchawki
- **Model:** TODO
- **Połączenie:** TODO (3.5mm jack / USB?)
- **Status:** Zapasowe

## 🔌 Routing audio

```
┌──────────────┐
│   GERC GPU   │
│  GTX 980 Ti  │
└──────┬───────┘
       │
       │ HDMI (wideo + audio)
       ▼
┌──────────────────┐
│  Samsung 65" TV  │
└──────┬───────────┘
       │
       │ HDMI ARC (tylko audio)
       ▼
┌──────────────────┐
│  Sony Soundbar   │
└──────────────────┘
       │
       ▼
    🔊 Głośniki
```

## ⚙️ Konfiguracja PulseAudio

### Status aktualny
```bash
# Sprawdź dostępne sink
pactl list sinks short

# Sprawdź domyślny sink
pactl info | grep "Default Sink"

# Sprawdź profile karty
pactl list cards
```

### Konfiguracja HDMI (Samsung TV + Soundbar)
```bash
# Restart PulseAudio
pulseaudio -k && sleep 2 && pulseaudio --start

# Ustaw profil HDMI
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1

# Ustaw jako domyślny sink
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1

# Głośność 100%
pactl set-sink-volume alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 100%

# Test dźwięku
speaker-test -D hdmi:CARD=NVidia_1,DEV=1 -c 2 -t wav -l 1
```

## 📋 Skrypty

### `~/bin/audio-hdmi.sh`
```bash
#!/usr/bin/env bash
# Przełącz audio na HDMI (TV + Soundbar)

pulseaudio -k && sleep 2 && pulseaudio --start
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
pactl set-sink-volume alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 100%
echo "Audio switched to HDMI (TV + Soundbar)"
```

### `~/bin/audio-headphones.sh`
```bash
#!/usr/bin/env bash
# Przełącz audio na słuchawki (onboard)

pulseaudio -k && sleep 2 && pulseaudio --start
pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
echo "Audio switched to headphones"
```

## ✅ Zadania

- [ ] Dodać dokładny model Sony Soundbar
- [ ] Dodać model słuchawek
- [ ] Utworzyć skrypty przełączania audio
- [ ] Dodać autostart konfiguracji przy logowaniu
- [ ] Udokumentować troubleshooting (brak dźwięku, crackle, itp.)

## 🔍 Troubleshooting

### Brak dźwięku przez HDMI
1. Sprawdź czy TV i Soundbar są włączone
2. Sprawdź kabel HDMI ARC
3. Zrestartuj PulseAudio: `pulseaudio -k`
4. Ustaw profil HDMI ponownie
5. Sprawdź głośność: `pactl list sinks`

### Trzaski/crackling
1. Zmień buffer size PulseAudio
2. Sprawdź `/etc/pulse/daemon.conf`
3. Dodaj: `default-fragments = 4` i `default-fragment-size-msec = 25`

## 🔗 Powiązane

- [[gerc/gerc]] - Sekcja konfiguracji audio
- [[accessories/monitors/samsung-65-tv]] - Źródło HDMI audio
- [[gerc/gpu-nvidia-gtx980ti]] - Karta z HDMI audio
