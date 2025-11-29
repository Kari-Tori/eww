---
tags:
  - #todo
  - #syncthing
  - #home
  - #sync
  - #karinam
created: 2025-11-22T15:00:00Z
modified: 2025-11-22T15:00:00Z
author: jakubc
title: "TODO: Synchronizacja katalogów home przez Syncthing"
owner: jakubc
---

# TODO: Synchronizacja katalogów home przez Syncthing

## 🎯 Cel

Synchronizacja katalogu domowego Kariny z mojego komputera, aby mieć dostęp do jej plików w `/home/karinam/` na GERC.

## 🖥️ Maszyny

| Hostname | IP | User | Home | Rola |
|----------|-------------|---------|------|------|
| **GERC** | 192.168.0.? | jakubc | `/home/jakubc/` | Moja maszyna (dev) |
| **ASUS_Z77** | 192.168.0.77 | karinam | `/home/karinam/` | Maszyna Kariny (ops) |

## 📋 Zadanie

### 1. Na GERC (moja maszyna)

- [ ] Utworzyć katalog `/home/karinam/` (lokalny)
- [ ] Zainstalować Syncthing (jeśli nie ma)
- [ ] Skonfigurować Syncthing folder:
  - Source: ASUS_Z77:/home/karinam/
  - Target: GERC:/home/karinam/
  - Type: Send & Receive (2-way sync)

### 2. Na ASUS_Z77 (maszyna Kariny)

- [ ] Zainstalować Syncthing
- [ ] Udostępnić folder `/home/karinam/`
- [ ] Sparować z GERC (jakubc)

### 3. W repozytorium `/git/eww/`

**Do ustalenia:**
- [ ] Czy `usr/karinam/` → symlink do `/home/karinam/`?
- [ ] Czy `usr/jakubc/` → symlink do `/home/jakubc/`?
- [ ] Jakie pliki commitować do Git?
- [ ] Aktualizować `.gitignore` dla bezpieczeństwa

## 🔄 Architektura synchronizacji

```
ASUS_Z77 (192.168.0.77)          GERC (moja maszyna)
karinam@asus_z77                 jakubc@gerc
│                                │
/home/karinam/  ←──Syncthing──→ /home/karinam/
(fizyczne pliki)                 (synchronizowana kopia)
                                 │
                                 ↓
                                /git/eww/usr/karinam/
                                (symlink lub wybrane pliki)
```

## 📦 Instalacja Syncthing

### GERC (moja maszyna)

```bash
# Zainstaluj Syncthing
sudo apt update
sudo apt install syncthing

# Uruchom jako user jakubc
systemctl --user enable syncthing
systemctl --user start syncthing

# Web GUI: http://localhost:8384
```

### ASUS_Z77 (maszyna Kariny)

```bash
# SSH do jej maszyny
ssh karinam@192.168.0.77

# Zainstaluj Syncthing
sudo apt update
sudo apt install syncthing

# Uruchom jako user karinam
systemctl --user enable syncthing
systemctl --user start syncthing

# Web GUI: http://192.168.0.77:8384
```

## ⚙️ Konfiguracja

### 1. Sparuj urządzenia

Na GERC:
- Otwórz http://localhost:8384
- Actions → Show ID
- Skopiuj Device ID

Na ASUS_Z77:
- Otwórz http://192.168.0.77:8384
- Add Remote Device → wklej Device ID z GERC
- Zatwierdź

### 2. Udostępnij folder (ASUS_Z77)

- Add Folder
- Folder Path: `/home/karinam/`
- Folder Label: `karinam-home`
- Share With Devices: wybierz GERC
- File Versioning: Simple File Versioning (opcjonalnie, backup)

### 3. Zaakceptuj folder (GERC)

- Pojawi się notyfikacja "New folder from ASUS_Z77"
- Accept
- Folder Path: `/home/karinam/`
- Folder Type: Send & Receive

## 🔐 Bezpieczeństwo

### .stignore (Syncthing ignore)

Utworzyć `/home/karinam/.stignore`:

```gitignore
# Nie synchronizuj wrażliwych danych
.ssh/
.gnupg/
.password-store/
*.key
*.pem

# Cache
.cache/
.mozilla/
.config/google-chrome/
.thumbnails/

# Development
node_modules/
.venv/
venv/
__pycache__/
```

## 🔗 Integracja z Git

### Opcja A: Symlink (REKOMENDACJA)

```bash
# W repozytorium eww
cd /git/eww/usr/

# Usuń obecny katalog karinam (jeśli istnieje)
rm -rf karinam/

# Utwórz symlink do zsynchronizowanego home
ln -s /home/karinam karinam

# Podobnie dla jakubc
ln -s /home/jakubc jakubc
```

**Efekt**:
- `usr/karinam/` zawsze pokazuje aktualne pliki z Syncthing
- NIE trzeba ręcznie synchronizować
- Edycja w VS Code → automatycznie sync przez Syncthing

### Opcja B: Wybrane pliki w Git

```bash
# Kopiuj tylko wybrane katalogi do Git
rsync -av /home/karinam/TODO/ /git/eww/usr/karinam/TODO/
rsync -av /home/karinam/notes/ /git/eww/usr/karinam/notes/

# Commituj
cd /git/eww
git add usr/karinam/
git commit -m "sync(usr): update karinam files"
```

## 📊 Status sync

### Sprawdź status Syncthing

```bash
# Web GUI
http://localhost:8384

# CLI (jeśli zainstalowane syncthing-cli)
syncthing cli show system

## 🗓️ Zadania domowe (deadline: 20)

- [ ] Internet (stabilny uplink + router) ⏫ 📅 2025-11-20
- [ ] Tablet (konfiguracja + aplikacje) 📅 2025-11-20
- [ ] TV (ustawienia / montaż) 📅 2025-11-20
- [ ] Kwiaty (podlewanie/przesadzenie) 📅 2025-11-20
- [ ] Biurko (porządek, okablowanie) 📅 2025-11-20
- [ ] Śmieci (wyniesienie / segregacja) 📅 2025-11-20
- [ ] Telefony (C4D) – zadania powiązane z komunikacją 📅 2025-11-20
- [ ] Telefony stacjonarne – sprawdzenie/reaktywacja 📅 2025-11-20

Po ukończeniu wszystkich powyższych:

- [ ] Ogarnąć dziurę w łazience (unlockuje nagrodę) 📅 2025-11-21
- 🎁 **Nagroda:** LEGO 75400 🚀
syncthing cli show connections
```

### Sprawdź czy katalog jest zsynchronizowany

```bash
# Sprawdź zawartość
ls -la /home/karinam/

# Sprawdź użycie dysku
du -sh /home/karinam/
```

## ⏱️ Timeline

- [ ] **Dzisiaj (22.11.2025)**: Zainstalować Syncthing na obu maszynach
- [ ] **Dzisiaj**: Sparować GERC ↔ ASUS_Z77
- [ ] **Dzisiaj**: Skonfigurować sync `/home/karinam/`
- [ ] **Jutro**: Przetestować synchronizację
- [ ] **Następnie**: Zdecydować o integracji z Git (symlink vs wybrane pliki)
- [ ] **Później**: Rozszerzyć na Proxmox VM (docelowo)

## 📚 Dokumentacja do aktualizacji

Po skonfigurowaniu Syncthing, zaktualizować:
- [ ] `/git/eww/usr/README.md` - koncepcja Syncthing
- [ ] `/git/eww/usr/SSH-REMOTE-GUIDE.md` → przemianować na `SYNCTHING-GUIDE.md`
- [ ] `/git/eww/usr/usr.md` - zmiana z SSH na Syncthing
- [ ] `/git/eww/README.md` - główny README, sekcja o usr/

## ❓ Pytania do ustalenia

1. **Git commits**: Czy commitować pliki Kariny do GitHub?
   - ✅ Tak, wszystkie → Pełny backup w Git
   - ⚠️ Tak, wybrane → Tylko TODO/Notes/Projects
   - ❌ Nie → Tylko Syncthing, bez Git

2. **Struktura usr/**:
   - Opcja A: `usr/karinam/` → symlink do `/home/karinam/`
   - Opcja B: `usr/karinam/` → wybrane pliki, ręczny sync

3. **Dwukierunkowa synchronizacja mojego home**:
   - Czy `/home/jakubc/` też synchronizować na ASUS_Z77?
   - Czy Karina ma mieć dostęp do moich plików?

## 🎯 Priorytet

**HIGH** - Podstawowa konfiguracja do jutro

## 🔗 Zobacz też

- [Syncthing Documentation](https://docs.syncthing.net/)
- [usr/README.md](./README.md)
- Obsidian Sync (alternatywa dla notatek .md)
