---
title: AppFlowy Deployment
description: 📒 AppFlowy — wdrożenie bez Dockera (Linux)
filepath: dev/Idea/AppFlowy_Deployment.md
color: yellow
author: 
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
tags:
  - documentation
  - markdown
  - development
  - code
related:
  - 
sources:
  - dev/Idea/AppFlowy_Deployment.md
backlinks: []
---


# 📒 AppFlowy — wdrożenie bez Dockera (Linux)

> Dwa warianty: **A) binarka** (AppImage/instalator, jeśli dostępny dla Twojej dystrybucji) lub **B) build ze źródeł** (Flutter + Rust).

## A) Binarka (gdy dostępna)
1. Pobierz **AppImage** lub instalator dla Linux z oficjalnych wydań.
2. `chmod +x AppFlowy-*.AppImage`
3. **Integracja z menu**: uruchom pierwszy raz lub dodaj plik `.desktop` w `~/.local/share/applications/`.
4. Plik danych trzymany w katalogu użytkownika (konfiguracja w ustawieniach AppFlowy).

## B) Build ze źródeł (Kubuntu/Ubuntu 22.04+)
### Zależności systemowe
```bash
sudo apt-get update
sudo apt-get install -y build-essential git curl cmake ninja-build pkg-config   libgtk-3-dev liblzma-dev libssl-dev libsqlite3-dev clang unzip
```

### Rust (toolchain)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup default stable
```

### Flutter (Linux desktop)
```bash
# Pobrać paczkę Flutter SDK i dodać do PATH
# Przykład (wersję dopasuj):
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar -xf flutter_linux_*.tar.xz -C $HOME
echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
flutter doctor
flutter config --enable-linux-desktop
```

### Pobranie źródeł i build
```bash
git clone https://github.com/AppFlowy-IO/AppFlowy.git
cd AppFlowy
flutter pub get
# część komponentów buduje się przez Rust (cargo) — zainicjuje się automatycznie
flutter build linux --release
```

### Uruchomienie
- Binarka pojawi się w `build/linux/x64/release/bundle/`.
- Stwórz skrót `.desktop`:
```ini
[Desktop Entry]
Type=Application
Name=AppFlowy
Exec=/home/USER/AppFlowy/build/linux/x64/release/bundle/AppFlowy
Icon=appflowy
Categories=Office;Productivity;
```

### Autostart (systemd user)
```bash
mkdir -p ~/.config/systemd/user
cat > ~/.config/systemd/user/appflowy.service <<'EOF'
[Unit]
Description=AppFlowy (User Session)

[Service]
ExecStart=%h/AppFlowy/build/linux/x64/release/bundle/AppFlowy
Restart=on-failure
Environment=DISPLAY=:0

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now appflowy.service
```

## Integracja z Secondbrain
- Pliki robocze AppFlowy w katalogu zsynchronizowanym przez **Syncthing**.
- Eksport/backup do **Nextcloud**.
- Automaty przez **n8n**: webhook → przetwarzanie → zapis do Obsidian PKM (MD).
- Single source of truth: notatki nadal w Obsidian; AppFlowy jako interfejs pracy nad projektami.
