---
tags:
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T15:00:00Z
modified: 2025-11-21T15:00:00Z
author: jakubc
title: "🏗️ Systemy wewnętrzne"






owner: jakubc
---



# 🏗️ Systemy wewnętrzne

## 🔌 Hosty i rola
- **Lenovo M710q (Secondbrain core)** — host VM: Synapser, Prefrontal, Hippocampus, Cortex, OrbitalFrontal.
- **Acer Veriton N4630G (nody SB)** — dodatkowe węzły (plug‑and‑play).
- **Fujitsu Esprimo P410 (Lab AI)** — środowisko agentów.
- **Dell T140 (ERP/DB)** — Odoo App/DB.

## 🧠 Warstwy (Bastion 8L)
1. Fizyczna: inwentarz (Snipe‑IT).
2. Wirtualizacja: Proxmox, klastry, backupy.
3. Sieć: NetBox jako źródło prawdy (VLAN prod/lab/dev).
4. Aplikacje: Odoo, OpenProject, Nextcloud, Firefly III.
5. Usługi: n8n, Syncthing, Git, CouchDB (LiveSync), Backstage.
6. Monitoring: Uptime Kuma, Prometheus+Grafana.
7. Kopie: Restic, pgBackRest (PostgreSQL), snapshoty.
8. Security: Reverse proxy, 2FA, Vaultwarden, WAF.

## 🌐 Adresacja i VLAN
- **Prod:** 192.168.0.0/24
- **Lab:** 192.168.10.0/24
- **Dev:** 192.168.20.0/24

## 🧩 Kluczowe VM i porty
- **Synapser** — n8n (5678), Git (3000/ssh), Syncthing (22000), CouchDB (5984)
- **Cortex** — Ollama (11434), OpenWebUI (3000)
- **Hippocampus** — Nextcloud (443/80)
- **Prefrontal** — OpenProject (6000/https)
- **OrbitalFrontal** — Firefly III (8080)
- **Bastion pack:** Kuma (3001), Grafana (3000), Prometheus (9090), NetBox (8000), Snipe‑IT (8001), Backstage (7007)
- **Odoo** — App (8069/8072), DB (5432)

## 🔐 Polityka bezpieczeństwa
- 2FA, `fail2ban`, SSH klucze, RBAC.
- Sekrety: Vaultwarden → `.env` + `systemd` `EnvironmentFile=`.
- Reverse proxy: TLS, HSTS.

## 🔄 Backup & DR
- Restic: repo `sftp:user@backup:/restic/eww` (GFS).
- pgBackRest: pełne tygodniowo, przyrostowe dziennie.
- Test odtworzenia: tydzień w `lab`.

## 📈 Observability
- Grafana: CPU/RAM/dysk, latency.
- Kuma: HTTP/ICMP/TCP alerty → Matrix/Telegram.
- Logi: journald; opcjonalnie Loki/Promtail.
