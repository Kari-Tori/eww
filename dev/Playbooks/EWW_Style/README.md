---
tags:
  - #automation
  - #books
  - #development
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T23:00:00Z
modified: 2025-11-21T23:00:00Z
author: jakubc
title: "EWW_Style — Playbook pakietu stylistycznego (KDE/Plasma 6)"






---


# EWW_Style — Playbook pakietu stylistycznego (KDE/Plasma 6)

Struktura:
```
Playbooks/EWW_Style/
├─ eww-style                 # wrapper uruchamiający instalator z .env
├─ eww-installer.sh         # główny playbook (KDE/GTK/SDDM/Plymouth/CLI/Kvantum)
├─ eww-rollback.sh          # przywraca domyślne motywy i kolory
├─ eww-doctor.sh            # diagnostyka konfiguracji
├─ .env.example             # przykładowe ustawienia środowiskowe
├─ desktop/EWW Style Installer.desktop
└─ palettes/EWW-Workshop.colors
```

Szybki start:
```bash
cd Playbooks/EWW_Style
cp .env.example .env
chmod +x eww-style
./eww-style
```

Rollback:
```bash
./eww-rollback.sh
```

Diagnostyka:
```bash
./eww-doctor.sh
```
