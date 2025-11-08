# E-Waste Workshop – `/git/eww`

**Lokalizacja (lokalny dysk):** `/git/eww`  
**Repo (GitHub):** https://github.com/Nairecth/eww  
**Owner/Contact:** astriblast@gmail.com

## Struktura plików
```
/git/eww
├─ README.md
├─ init-eww.sh
├─ bin/
│  ├─ eww-status
│  ├─ eww-commit
│  └─ eww-banner
├─ scripts/
│  ├─ eww-setup-git.sh
│  ├─ eww-git-gpg-fix.sh
│  └─ eww-logging.sh
├─ logs/
│  └─ .gitkeep
└─ docs/
   └─ .gitkeep
```

## `init-eww.sh` — co robi
- Ustawia `EWW_ROOT=/git/eww`.
- Tworzy niezbędne katalogi (`bin/`, `scripts/`, `logs/`, `docs/`).
- Nadaje prawa wykonania plikom w `bin/` i `scripts/` (jeśli istnieją).
- Opcjonalnie inicjuje repo Git w `/git/eww` (jeśli brak `.git`).
- Wyświetla baner startowy i status.

## Jak uruchomić
Pobierz do katalogu „Pobrane/Downloads” i uruchom:

```bash
DL="$(xdg-user-dir DOWNLOAD 2>/dev/null || echo "$HOME/Downloads")"
mkdir -p "$DL" && cd "$DL"
curl -fsSL -o init-eww.sh https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
chmod +x init-eww.sh
./init-eww.sh
```
- touch: 2025-11-08 16:21:08 UTC
