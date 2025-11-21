---
title: README
description: EWW_Style — Playbook pakietu stylistycznego (KDE/Plasma 6)
filepath: dev/Playbooks/EWW_Style/README.md
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
  - readme
  - development
  - code
related:
  - AGENTS.md
  - CHANGELOG.md
  - FULL-INDEX.md
sources:
  - dev/Playbooks/EWW_Style/README.md
backlinks: []
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
