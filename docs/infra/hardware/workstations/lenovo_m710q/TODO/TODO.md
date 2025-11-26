# TODO: LENOVO M710q (DEV SERVER)

**Owner**: jakubc  
**Role**: DEV SERVER, always-on, backup, automatyzacja, testy, monitoring  
**IP**: 192.168.0.40/24 (do rezerwacji)  
**Location**: /home/jakubc/git/eww (lub /srv/eww)

---

## 🔧 Hardware & Setup
- [ ] Określić ostateczną konfigurację hardware (CPU, RAM, storage) — @jakubc
- [ ] Ustalić docelowy OS (Proxmox VE vs Ubuntu Server) — @jakubc
- [ ] Zainstalować wybrany OS — @jakubc
- [ ] Skonfigurować hostname: lenovo_m710q — @jakubc
- [ ] Przypisać statyczne IP: 192.168.0.40/24 — @jakubc
- [ ] Zarezerwować IP w routerze DHCP — @jakubc

## 🌐 Network & Security
- [ ] Skonfigurować SSH server — @jakubc
- [ ] Dodać klucze SSH dla bezpiecznego dostępu — @jakubc
- [ ] Skonfigurować firewall (ufw) — @jakubc
- [ ] Zainstalować i skonfigurować Tailscale VPN — @jakubc
- [ ] Wyłączyć Cloudflare WARP (domyślnie) — @jakubc
- [ ] Przetestować dostęp LAN i WAN — @jakubc

## 📦 Software Stack
- [ ] Zainstalować Git — @jakubc
- [ ] Sklonować repo: git clone git@github.com:Nairecth/eww.git — @jakubc
- [ ] Zainstalować Obsidian (opcjonalnie, headless LiveSync) — @jakubc
- [ ] Zainstalować Docker (jeśli potrzebny) — @jakubc
- [ ] Zainstalować BATS, Make — @jakubc
- [ ] Skonfigurować Self-hosted LiveSync jako node backup — @jakubc

## 🤖 Automatyzacja & Backup
- [ ] Skonfigurować auto-commit Git (co 30 min, systemd timer) — @jakubc
- [ ] Utworzyć skrypt backup-snapshot.sh — @jakubc
- [ ] Skonfigurować systemd timer: backup-snapshot.timer — @jakubc
- [ ] Dodać monitoring uptime i backupów — @jakubc
- [ ] Skonfigurować automatyczne pull/push — @jakubc
- [ ] Przetestować redundancję z GERC — @jakubc

## 🏗️ Rola i przypadki użycia
- [ ] Określić czy Proxmox node czy Ubuntu Server — @jakubc
- [ ] Jeśli Proxmox: skonfigurować VM dla testów — @jakubc
- [ ] Jeśli Ubuntu: skonfigurować jako node backup/automation — @jakubc
- [ ] Rozważyć hosting usług (Home Assistant, monitoring, backup CouchDB) — @jakubc
- [ ] Opisać integrację z GERC i ASUS Z77 — @jakubc

## 📊 Monitoring & Niezawodność
- [ ] Skonfigurować monitoring uptime (24/7) — @jakubc
- [ ] Dodać alerty dla krytycznych usług — @jakubc
- [ ] Skonfigurować automatyczne restarty (systemd) — @jakubc
- [ ] Zaplanować harmonogram konserwacji — @jakubc
- [ ] Dodać health check scripts — @jakubc

## 📚 Dokumentacja
- [ ] Utworzyć podfoldery: ops/, storage/, network/ — @jakubc
- [ ] Uzupełnić szczegóły hardware w lenovo_m710q.md — @jakubc
- [ ] Opisać przypadki użycia i workflow — @jakubc
- [ ] Dodać do docs/infra/network/README.md — @jakubc
- [ ] Opisać troubleshooting typowych problemów — @jakubc

---

**Status**: 🟡 W TRAKCIE INWENTARYZACJI I WDROŻENIA  
**Priorytet**: Określić OS i rolę, wdrożyć jako always-on node backup  
**Last updated**: 2025-11-23
