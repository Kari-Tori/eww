# EWW scripts

Zestaw skryptów powłoki dla repozytorium E-Waste Workshop.

## Instalacja
```bash
# Rozpakuj do /git/eww/scripts
mkdir -p /git/eww
cp -r scripts /git/eww/

# Link do PATH użytkownika
mkdir -p ~/.local/bin
ln -sf /git/eww/scripts/init-eww.sh ~/.local/bin/init-eww

# Auto-start przy otwarciu powłoki
grep -q 'init-eww.sh' ~/.bashrc || echo '[ -x /git/eww/scripts/init-eww.sh ] && /git/eww/scripts/init-eww.sh' >> ~/.bashrc
```
## Zawartość
- `eww_common.sh` — wspólne funkcje, logowanie, wykrywanie ścieżek
- `init-eww.sh` — inicjalizacja repo, szybka diagnostyka, logi
- `diag-basic.sh` — podstawowa diagnostyka systemu
- `diag-network.sh` — diagnostyka sieci
- `git-scan.sh` — podsumowanie stanu repo
- `sys-packages.sh` — weryfikacja pakietów bazowych

Wersja pakietu wygenerowana: 2025-11-06 15:50:44 +0000
