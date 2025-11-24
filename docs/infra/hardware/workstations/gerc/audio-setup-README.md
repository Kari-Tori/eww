# Automatyczna konfiguracja audio GERC - SONY TV

System automatycznej konfiguracji audio dla GERC, który przy każdym starcie systemu kieruje cały dźwięk na SONY TV (HDMI ARC → Soundbar).

## 📋 Komponenty

### Skrypt konfiguracyjny
- **Plik:** `scripts/audio-setup-sony-tv.sh`
- **Funkcja:** Ustawia SONY TV jako domyślne wyjście audio
- **Parametry:**
  - Karta: `alsa_card.pci-0000_01_00.1` (GTX 980 Ti #2)
  - Profil: `output:hdmi-stereo-extra1`
  - Sink: `alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1`
  - Głośność: 100%

### Usługa systemd
- **Plik:** `systemd/eww-audio-sony-tv.service`
- **Instalacja:** `~/.config/systemd/user/eww-audio-sony-tv.service`
- **Status:** Włączona automatycznie przy starcie systemu
- **Typ:** oneshot (uruchamia się raz przy starcie)

## 🚀 Instalacja

```bash
# 1. Skopiuj usługę do katalogu użytkownika
mkdir -p ~/.config/systemd/user
cp systemd/eww-audio-sony-tv.service ~/.config/systemd/user/

# 2. Przeładuj konfigurację systemd
systemctl --user daemon-reload

# 3. Włącz automatyczne uruchamianie
systemctl --user enable eww-audio-sony-tv.service

# 4. Uruchom teraz (test)
systemctl --user start eww-audio-sony-tv.service
```

## 📊 Zarządzanie

### Sprawdzenie statusu
```bash
systemctl --user status eww-audio-sony-tv.service
```

### Ręczne uruchomienie
```bash
# Przez systemd
systemctl --user restart eww-audio-sony-tv.service

# Bezpośrednio skrypt
./scripts/audio-setup-sony-tv.sh
```

### Wyłączenie automatycznego startu
```bash
systemctl --user disable eww-audio-sony-tv.service
```

### Logi
```bash
# Ostatnie logi
journalctl --user -u eww-audio-sony-tv.service -n 50

# Logi na żywo
journalctl --user -u eww-audio-sony-tv.service -f
```

## 🔧 Ręczna konfiguracja

Jeśli potrzebujesz ręcznie skonfigurować audio:

```bash
# Restart PulseAudio
pulseaudio -k && sleep 2 && pulseaudio --start

# Ustaw profil karty i domyślne wyjście
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1

# Ustaw głośność
pactl set-sink-volume alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 100%

# Sprawdź status
pactl info | grep "Domyślny odpływ"
pactl list sinks short
```

## 🎯 Routing audio

```
PC → GTX 980 Ti #2 (HDMI 1) → SONY TV → HDMI ARC → Soundbar
```

### Urządzenia
- **HP 27 Curved:** `hdmi-output-0` (nieużywany)
- **SONY TV *00:** `hdmi-output-1` ✅ (aktywny)
- **Soundbar:** podłączony przez HDMI ARC do TV

### Aplikacje
Wszystkie aplikacje używają domyślnego wyjścia SONY TV:
- Firefox
- Spotify
- VLC
- Powiadomienia systemowe
- Wszystkie inne aplikacje audio

## ⚠️ Rozwiązywanie problemów

### Brak dźwięku
1. Sprawdź czy TV jest włączony
2. Sprawdź czy soundbar jest włączony i w trybie HDMI ARC
3. W ustawieniach TV włącz HDMI-CEC i ARC
4. Uruchom ponownie usługę: `systemctl --user restart eww-audio-sony-tv.service`

### Firefox nie gra dźwięku
```bash
# Restart PulseAudio
pulseaudio -k && sleep 2 && pulseaudio --start

# Odśwież stronę w Firefoxie (F5)
```

### Sprawdź czy urządzenie istnieje
```bash
# Lista kart
pactl list cards short

# Lista urządzeń wyjściowych
pactl list sinks short

# Test dźwięku
speaker-test -D hdmi:CARD=NVidia_1,DEV=1 -c 2 -t wav -l 1
```

## 📝 Dokumentacja

Szczegółowa dokumentacja konfiguracji znajduje się w:
- `docs/infra/hardware/workstations/gerc/gerc.md` (sekcja "🔊 Konfiguracja audio")

## 🔄 Aktualizacja

Jeśli zmienisz skrypt lub usługę:

```bash
# 1. Skopiuj zaktualizowane pliki
cp systemd/eww-audio-sony-tv.service ~/.config/systemd/user/

# 2. Przeładuj systemd
systemctl --user daemon-reload

# 3. Restart usługi
systemctl --user restart eww-audio-sony-tv.service
```

## 📌 Status instalacji

- ✅ Skrypt: `/home/jakubc/git/eww/scripts/audio-setup-sony-tv.sh`
- ✅ Usługa: `~/.config/systemd/user/eww-audio-sony-tv.service`
- ✅ Autostart: Włączony
- ✅ Data instalacji: 2025-11-22
