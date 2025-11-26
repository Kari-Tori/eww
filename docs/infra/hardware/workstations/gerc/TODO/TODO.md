# TODO: GERC (Primary Workstation)

**Owner**: jakubc  
**Role**: PRIMARY workstation, CouchDB server, development, Docker host, backup server  
**IP**: 192.168.0.99/24  
**Location**: /home/jakubc/git/eww

---

## 🔧 Hardware & Network
- [ ] Zweryfikować pełną listę dysków (NVMe + SATA) i ich montowanie — @jakubc
- [ ] Opisać konfigurację dual GPU (SLI vs independent) — @jakubc
- [ ] Dodać temperatury referencyjne i profile wentylatorów — @jakubc
- [ ] Uzupełnić monitoring sieci (Tailscale, status VPN) — @jakubc

## 💾 CouchDB Server
- [ ] Zainstalować i skonfigurować CouchDB Docker container — @jakubc
- [ ] Utworzyć bazę danych `eww-vault` — @jakubc
- [ ] Skonfigurować CORS dla Obsidian — @jakubc
- [ ] Skonfigurować firewall (ufw allow 5984 z LAN) — @jakubc
- [ ] Przetestować połączenie z localhost i z ASUS Z77 — @jakubc
- [ ] Dodać monitoring CouchDB (health check, backup) — @jakubc

## 📦 Software
- [ ] Zainstalować Self-hosted LiveSync plugin w Obsidian — @jakubc
- [ ] Skonfigurować LiveSync (device: gerc-jakubc, URL: localhost:5984) — @jakubc
- [ ] Zweryfikować GitHub Copilot CLI (gh copilot) — @jakubc
- [ ] Opisać konfigurację VS Code (extensions, settings) — @jakubc
- [ ] Uzupełnić dokumentację Git (aliasy, hooks, workflow) — @jakubc

## 🤖 Automatyzacja
- [ ] Utworzyć skrypt graph-snapshot.sh (daily backup graph.json) — @jakubc
- [ ] Utworzyć skrypt daily-github-backup.sh (push at 03:00) — @jakubc
- [ ] Utworzyć skrypt batched-commit.sh (max 18 files/commit) — @jakubc
- [ ] Skonfigurować systemd timer: graph-snapshot.timer — @jakubc
- [ ] Skonfigurować systemd timer: github-backup.timer — @jakubc
- [ ] Przetestować wszystkie timery — @jakubc

## 📊 Monitoring & Maintenance
- [ ] Skonfigurować monitoring uptime — @jakubc
- [ ] Dodać skrypt sprawdzający status CouchDB — @jakubc
- [ ] Skonfigurować alerty dla krytycznych usług — @jakubc
- [ ] Zaplanować harmonogram backupów (weekly full, daily incremental) — @jakubc

## 📚 Dokumentacja
- [ ] Uzupełnić docs/infra/software/git/TODO-git-gerc-jakubc.md — @jakubc
- [ ] Uzupełnić docs/infra/software/obsidian/TODO-obsidian-gerc-jakubc.md — @jakubc
- [ ] Uzupełnić docs/infra/software/code/TODO-code-gerc-jakubc.md — @jakubc
- [ ] Opisać troubleshooting typowych problemów — @jakubc

---

**Status**: 🟡 W TRAKCIE WDROŻENIA  
**Priorytet**: CouchDB setup (Phase 1), automatyzacja (Phase 2)  
**Last updated**: 2025-11-23
