---
title: EWW – Folder note & repo index
description: Szkic folder note i indeksu dla repozytorium E-Waste Workshop.
lang: pl
audience: developers
type: folder-note
platform: Ubuntu
---
# ♻️ E-Waste Workshop - Centrum recyklingu i refabrykacji

[![Website](https://img.shields.io/badge/Website-🏠%20E--Waste_Workshop-10AB1C?style=for-the-badge&logo=recycle&logoColor=white)](https://e-wasteworkshop.co.uk) ♻️ – `e-wasteworkshop.co.uk`
[![YouTube subs](https://img.shields.io/badge/YouTube-Subs%2018-ff0000?style=for-the-badge&logo=youtube)](https://www.youtube.com/channel/UCe31iZazQVN678Yqn62u3GA)
[![GitHub files](https://img.shields.io/badge/GitHub-16\,827%20files-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Nairecth/eww)
[![eBay sold](https://img.shields.io/badge/eBay-Sold%20Items%2067-0064d2?style=for-the-badge&logo=ebay&logoColor=white)](https://www.ebay.co.uk/usr/e-waste_workshop)

> [!note] **Co robimy**
> - **E-Waste Workshop** to technologiczny startup z misją recyklingu i refabrykacji sprzętów elektronicznych oraz household items.
> - Łączymy automatyzację, AI, 3D printing i HomeLabing, żeby projektować procesy odzysku i rewitalizacji.
> - Dzielimy się postępami na YouTube, prowadzimy tooling na GitHubie, sprzedajemy odnowione sprzęty przez eBay i scala to centrum recyklingu + strona.

## 🔐 Stałe połączenie SSH — gerc (192.168.0.99)

Jeśli chcesz, aby komputer "code (Asus Z77)" utrzymywał stałe połączenie SSH do hosta `gerc` (192.168.0.99), użyj skryptów i jednostki systemd przygotowanych w repo:

- Skrypt utrzymujący połączenie:
  - scripts/ssh_keepalive.sh
- Helper instalacyjny (generuje klucz i kopiuje publiczny klucz):
  - scripts/setup_ssh_keepalive.sh
- Jednostka systemd --user:
  - systemd/eww-ssh-keepalive.service

Szybkie kroki (na maszynie local "code"):
1. Nadaj prawa i uruchom helper:
   chmod +x ./scripts/*.sh
   ./scripts/setup_ssh_keepalive.sh [REMOTE_USER] 192.168.0.99 [~/.ssh/id_rsa_eww]
2. Sprawdź status:
   systemctl --user status eww-ssh-keepalive.service
3. Jeśli nie masz autossh, zainstaluj:
   sudo apt install autossh

Uwaga: skrypt nie automatycznie modyfikuje zdalnego hosta bez Twojej zgody — podczas pierwszego użycia ssh-copy-id poprosi o hasło. Jeśli nie chcesz podawać hasła, dodaj publiczny klucz ręcznie do ~/.ssh/authorized_keys na hoście `gerc`.
