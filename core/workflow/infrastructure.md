---
version: 0.0.1
tags:
  - #infrastructure
  - #workflow
  - #hardware
  - #software
  - #core
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "Infrastructure - Sprzęt i oprogramowanie EWW"
owner: jakubc
---

# Infrastructure - Sprzęt i oprogramowanie EWW

Kompletna dokumentacja infrastruktury projektu EWW: hardware, network, software stack.

## 🖥️ Workstations

### GERC (Primary Workstation)

**Hardware**:
- **Model**: Custom X99 build
- **CPU**: Intel Core i7-5960X (8-core, 16-thread, 3.0 GHz base / 3.5 GHz turbo)
- **RAM**: Corsair Vengeance DDR4 32GB
- **GPU**: 2× NVIDIA GTX 980 Ti (SLI/independent)
- **Storage**: NVMe + SATA (multiple drives)
- **Motherboard**: ASUS X99-PRO

**Network**:
- **Hostname**: gerc / gerc.local
- **IP**: 192.168.0.99/24
- **Gateway**: 192.168.0.10
- **DNS**: 1.1.1.1, 8.8.8.8
- **Interface**: eno1 (Intel I218-V)
- **VPN**: Tailscale (fe80::f949:a3aa:6683:32cd/64)

**User**: jakubc
**Location**: /home/jakubc/git/eww
**Role**: PRIMARY workstation, CouchDB server, development, Docker host, backup server

**Full specs**: [[docs/infra/hardware/workstations/gerc/gerc]]

---

### ASUS Z77 (Secondary Workstation)

**Hardware**:
- **Model**: ASUS P8Z77-V DELUXE
- **CPU**: Intel Core i7-3770K (4-core, 8-thread, 3.5 GHz base / 3.9 GHz turbo)
- **RAM**: Corsair Vengeance DDR3 16GB
- **GPU**: NVIDIA GTX 1660 Ti
- **Storage**: SATA (multiple drives)
- **Motherboard**: ASUS P8Z77-V DELUXE (Rev 1.xx, BIOS 2104)
- **Chipset**: Intel Z77 (Panther Point)
- **WiFi**: Wi-Fi GO! 802.11n + Bluetooth 4.0 (mini-PCIe)

**Network**:
- **Hostname**: asus_z77
- **IP**: 192.168.0.77/24
- **MAC**: 8a:7f:75:bf:88:f0 (permaddr: c8:60:00:a2:e2:c0)
- **Gateway**: 192.168.0.10
- **DNS**: 1.1.1.1, 8.8.8.8
- **Interface**: enp13s0 (Intel 82579V)
- **WiFi interface**: wlp11s0 (DOWN)
- **SSH**: `ssh karinam@192.168.0.77` / hasło `ciastko33` (LAN only)

**User**: karinam
**Location**: /home/karinam/git/eww (⚠️ WARNING: poprzednia lokalizacja `/usr/karinam/git/eww` w dokumentacji - do weryfikacji!)
**Role**: SECONDARY workstation, development, eBay workflow, multimedia center (Samsung 65" TV)

**OS**: Ubuntu 25.04 (kernel 6.14.0-36-generic)

**Full specs**: [[docs/infra/hardware/asus_z77/asus_z77]]

**Known issues**:
- 2025-11-22: Brak dostępu do internetu (podejrzenie: Cloudflare Zero Trust WARP conflict)
- WiFi module disabled
- Secondary ethernet (eno1) NO-CARRIER

---

### LENOVO M710q (DEV SERVER, always-on)

**Hardware**:
- **Model**: Lenovo ThinkCentre M710q Tiny
- **CPU**: Intel Core i5-6500T (TBD)
- **RAM**: 16GB DDR4 SO-DIMM
- **Storage**: NVMe/SATA (TBD)
- **Form factor**: Tiny PC, niskie zużycie energii

**Network**:
- **Hostname**: lenovo_m710q
- **IP**: 192.168.0.40/24 (propozycja, do rezerwacji)
- **Gateway**: 192.168.0.10
- **DNS**: 1.1.1.1, 8.8.8.8
- **Interface**: eno1 (Intel I219-V) + opcjonalny USB-C LAN
- **VPN**: Tailscale (planowany), Cloudflare WARP (wyłączony domyślnie)

**User**: jakubc (admin)
**Location**: /home/jakubc/git/eww (lub /srv/eww jeśli serwer)
**Role**: DEV SERVER, always-on, node backup/test, automatyzacja, host usług (np. monitoring, Home Assistant, backup CouchDB)

**OS**: Do decyzji: Proxmox VE lub Ubuntu Server (TODO: @jakubc)

**Full specs**: [[docs/infra/hardware/workstations/lenovo_m710q/lenovo_m710q]]

**Status**: W trakcie inwentaryzacji i wdrożenia

**Polityka pracy**:
- **Zawsze włączony** (24/7, niezawodność, monitoring)
- **LiveSync**: vault EWW synchronizowany w czasie rzeczywistym (jako node backup/test)
- **Git**: regularny commit (propozycja: co 30 min, systemd timer lub skrypt)
- **Backup**: może pełnić rolę dodatkowego backupu (np. mirror repo, snapshoty CouchDB)
- **Automatyzacja**: hostowanie skryptów, testów, monitoringu

**Checklist wdrożeniowy**:
- [ ] Ustalić OS i zainstalować (Proxmox/Ubuntu) — @jakubc
- [ ] Zarezerwować IP w DHCP/routerze i dodać do network/README — @jakubc
- [ ] Skonfigurować hostname, SSH, Tailscale — @jakubc
- [ ] Uzupełnić tabelę hardware (CPU, RAM, storage) — @jakubc
- [ ] Utworzyć podfoldery: ops/, storage/, network/ — @jakubc
- [ ] Skonfigurować git/obsidian/live sync jako node backup/test — @jakubc
- [ ] Opisać przypadki użycia w core/workflow/infrastructure.md — @jakubc

**TODO**:
- [ ] Określić docelową rolę (Proxmox node, Ubuntu Server, backup, automatyzacja)
- [ ] Ustalić politykę commitów (propozycja: co 30 min, systemd timer)
- [ ] Dodać monitoring uptime i backupów
- [ ] Opisać integrację z pozostałymi node (gerc, asus_z77)

---

## 🌐 Network

### Infrastructure

- **Gateway/Router**: ASUS DSL-N16 (192.168.0.10)
  - Credentials: admin / admin
  - DSL connection + NAT + firewall
  - Access: `http://192.168.0.10`

- **Subnet**: 192.168.0.0/24
- **DNS**: 1.1.1.1 (Cloudflare), 8.8.8.8 (Google)
- **VPN**: Tailscale (distributed across workstations)

### Device Map

| Device | IP | MAC | Interface | Status |
|--------|----------|-------------------|-----------|--------|
| Gateway | 192.168.0.10 | 88:d7:f6:63:40:b8 | - | ✅ OK |
| GERC | 192.168.0.99 | - | eno1 | ✅ OK |
| ASUS Z77 | 192.168.0.77 | c8:60:00:a2:e2:c0 | enp13s0 | 🟡 LAN OK, WAN FAIL |
| LENOVO M710q | 192.168.0.40 | - | eno1 | 🔴 NOT CONFIGURED |

**Network docs**: [[docs/infra/hardware/network/network]]

---

## 💻 Software Stack

### Per Workstation (Identical Setup)

Każda stacja robocza ma identyczny software stack dla zapewnienia kompatybilności:

#### 1. **Obsidian** (Vault Management)
- **Wersja**: Latest stable
- **Vault**: /home/{user}/git/eww
- **Plugins**:
  - Self-hosted LiveSync (to install) - real-time sync via CouchDB
  - Obsidian Git - hourly auto-commit (60 min)
  - Graph View (core plugin)
  - Dataview (community)
  - Tasks (community)
- **Role**: Note management, graph view, vault sync, markdown editor
- **Sync**:
  - Real-time: LiveSync → CouchDB (1-2s)
  - Backup: Git → GitHub (hourly/daily)

#### 2. **VS Code** (Development IDE)
- **Wersja**: Latest stable
- **Extensions**:
  - GitHub Copilot (AI code assistant)
  - GitHub Copilot Chat (AI chat)
  - GitLens (Git supercharged)
  - Bash IDE (shellcheck, formatter)
  - Markdown All in One
  - YAML (Red Hat)
- **Settings**: Synced via GitHub account
- **Role**: Primary code editor, script development, Git integration
- **Workspace**: /home/{user}/git/eww/eww.code-workspace

#### 3. **GitHub Copilot**
- **License**: Business seat (każdy user ma osobny seat)
- **Components**:
  - Copilot for VS Code (extension)
  - Copilot Agent (context-aware suggestions)
  - Copilot CLI (terminal assistant) - `gh copilot`
  - Copilot Chat (in-editor chat)
- **Role**: AI code completion, generation, refactoring, documentation
- **Features**:
  - Code suggestions (real-time)
  - Function generation
  - Test generation
  - Documentation writing
  - Code explanation
  - Bug fixing suggestions

#### 4. **GitHub Copilot CLI**
- **Instalacja**: `gh extension install github/gh-copilot`
- **Usage**:
  ```bash
  gh copilot suggest "jak zainstalować CouchDB?"
  gh copilot explain "git rebase -i HEAD~5"
  ```
- **Role**: Terminal AI assistant for commands, scripts, troubleshooting

#### 5. **ChatGPT** (Business Seat)
- **License**: Business seat (każdy user ma osobny seat)
- **Model**: GPT-4 (latest)
- **Usage**:
  - Complex problem solving
  - Architecture design
  - Documentation review
  - Research and planning
  - Code review (paste code → get feedback)
- **Access**: `https://chat.openai.com/`
- **Role**: High-level planning, research, complex reasoning

#### 6. **Codex**
- **Status**: ⚠️ NEEDS DOCUMENTATION
- **Purpose**: TODO - define what Codex is in this context
- **Installation**: TODO
- **Usage**: TODO
- **Role**: TODO

> [!warning] Missing Info
> Codex nie ma jeszcze pełnej dokumentacji. Wymaga:
> - Określenie czy to OpenAI Codex API, czy inna implementacja
> - Instrukcje instalacji
> - Przypadki użycia
> - Integracja z workflow

#### 7. **Git** (Version Control)
- **Wersja**: Latest stable
- **Config**: Synced via core/gitconfig.repo
- **Credentials**: SSH keys per user
- **Remote**: GitHub (Nairecth/eww)
- **Role**: Version control, backup, collaboration

#### 8. **Docker** (GERC only)
- **Wersja**: Latest stable
- **Containers**:
  - CouchDB (eww-vault) - port 5984
  - (other containers TBD)
- **Role**: Container orchestration, CouchDB hosting

#### 9. **BATS** (Testing Framework)
- **Wersja**: Latest stable
- **Location**: /usr/local/bin/bats
- **Role**: Bash script testing
- **Usage**: `bats tests/`

#### 10. **Make** (Build Automation)
- **Config**: /home/{user}/git/eww/Makefile
- **Targets**: install, uninstall, test, help, changelog, readme
- **Role**: Project automation, task runner

---

## 📊 Software Matrix

| Software | GERC (jakubc) | ASUS Z77 (karinam) | License | Status |
|----------|---------------|---------------------|---------|--------|
| **Obsidian** | ✅ Installed | ✅ Installed | Free | ✅ Active |
| **VS Code** | ✅ Installed | ✅ Installed | Free | ✅ Active |
| **GitHub Copilot** | ✅ Active | ✅ Active | Business seat | ✅ Active |
| **Copilot CLI** | ✅ Installed | 🟡 To install | Included | 🟡 Partial |
| **ChatGPT** | ✅ Active | ✅ Active | Business seat | ✅ Active |
| **Codex** | ❓ Unknown | ❓ Unknown | ❓ | ❓ TODO |
| **Git** | ✅ Installed | ✅ Installed | Free | ✅ Active |
| **Docker** | ✅ Installed | ❌ Not needed | Free | ✅ Active (GERC) |
| **BATS** | ✅ Installed | 🟡 To install | Free | ✅ Active (GERC) |
| **Self-hosted LiveSync** | 🟡 To install | 🟡 To install | Free | 🟡 Planned |
| **Obsidian Git** | ✅ Installed | ✅ Installed | Free | ✅ Active |

**Legend**:
- ✅ Active - działa, używane
- 🟡 Partial - częściowo zainstalowane/skonfigurowane
- ❌ Not needed - nie wymagane na tej maszynie
- ❓ Unknown - status nieznany, wymaga weryfikacji

---

## 🔐 Licenses & Seats

### GitHub Copilot Business

**Organization**: Nairecth (lub inna - TODO: verify)
**Plan**: Business
**Seats**: 2 (jakubc + karinam)

**Features**:
- Code completion in VS Code
- Copilot Chat
- Copilot CLI
- Multi-line suggestions
- Context-aware completions
- Organization-wide policies

**Cost**: ~$19/user/month (TODO: verify current pricing)

---

### ChatGPT Business

**Organization**: TODO: verify organization name
**Plan**: Business
**Seats**: 2 (jakubc + karinam)

**Features**:
- GPT-4 access (unlimited)
- GPT-4 Turbo
- Advanced data analysis
- DALL-E 3 image generation
- Priority access
- Admin console
- Data privacy (not used for training)

**Cost**: ~$25/user/month (TODO: verify current pricing)

---

### Obsidian

**License**: Free (personal use)
**Commercial**: Not required (personal notes/code)
**Sync**: Self-hosted (CouchDB + Git) - FREE

---

### VS Code

**License**: Free (MIT License)
**Extensions**: Free (GitHub Copilot requires separate license)

---

## 🚀 Installation Checklist

### New Workstation Setup

Checklist dla dodania nowej workstation do infrastruktury:

- [ ] **Hardware**:
  - [ ] Document specs (CPU, RAM, GPU, storage)
  - [ ] Assign static IP (192.168.0.x)
  - [ ] Configure hostname (DNS)
  - [ ] Test network (LAN, WAN, SSH)

- [ ] **OS**:
  - [ ] Install Kubuntu/Ubuntu
  - [ ] Update system: `sudo apt update && sudo apt upgrade`
  - [ ] Install SSH server: `sudo apt install openssh-server`
  - [ ] Configure firewall: `sudo ufw allow ssh`

- [ ] **Git**:
  - [ ] Install Git: `sudo apt install git`
  - [ ] Configure user: `git config --global user.name "Name"`
  - [ ] Configure email: `git config --global user.email "email"`
  - [ ] Generate SSH key: `ssh-keygen -t ed25519`
  - [ ] Add key to GitHub
  - [ ] Clone repo: `git clone git@github.com:Nairecth/eww.git`

- [ ] **VS Code**:
  - [ ] Download from `https://code.visualstudio.com/`
  - [ ] Install: `sudo dpkg -i code_*.deb`
  - [ ] Install extensions:
    - [ ] GitHub Copilot
    - [ ] GitHub Copilot Chat
    - [ ] GitLens
    - [ ] Bash IDE
    - [ ] Markdown All in One
  - [ ] Sign in to GitHub account
  - [ ] Enable Settings Sync

- [ ] **GitHub Copilot**:
  - [ ] Verify business seat assigned
  - [ ] Sign in via VS Code
  - [ ] Test suggestions (create test.js, type `function`)
  - [ ] Install Copilot CLI: `gh extension install github/gh-copilot`

- [ ] **ChatGPT**:
  - [ ] Verify business seat assigned
  - [ ] Login at `https://chat.openai.com/`
  - [ ] Test access to GPT-4

- [ ] **Obsidian**:
  - [ ] Download from `https://obsidian.md/`
  - [ ] Install: `sudo dpkg -i obsidian_*.deb` (lub AppImage)
  - [ ] Open vault: `/home/{user}/git/eww`
  - [ ] Install plugins:
    - [ ] Obsidian Git (community)
    - [ ] Self-hosted LiveSync (community)
    - [ ] Dataview (community)
    - [ ] Tasks (community)
  - [ ] Configure Obsidian Git:
    - [ ] Auto-commit: 60 min
    - [ ] NO auto-pull/push
    - [ ] Message template: `chore(vault): {username} backup {date}`
  - [ ] Configure LiveSync (after CouchDB setup):
    - [ ] URL: `http://192.168.0.99:5984/eww-vault`
    - [ ] Device name: `{hostname}-{username}`
    - [ ] Test sync

- [ ] **Development Tools**:
  - [ ] Install BATS: `sudo apt install bats`
  - [ ] Install Make: `sudo apt install make`
  - [ ] Test: `make test` (in repo)

- [ ] **EWW Setup**:
  - [ ] Copy configs: `cp core/bashrc.eww.snippet ~/.bashrc.d/eww.sh`
  - [ ] Install binaries: `make install` (from repo)
  - [ ] Test commands: `eww-version`

- [ ] **Documentation**:
  - [ ] Create workstation doc: `docs/infra/hardware/workstations/{hostname}/{hostname}.md`
  - [ ] Add to network map: `docs/infra/hardware/network/network.md`
  - [ ] Update this file: `core/workflow/infrastructure.md`

---

## 📈 Usage Stats (TODO)

### Obsidian
- Total files: 934 (2025-11-23)
- Total links: 4,425
- Vault size: ~40GB
- Graph nodes: 934 (max 2000)
- Active colors: 18/20

### Git
- Total commits: TODO
- Contributors: 2 (jakubc, karinam)
- Branches: main (+ feature branches)
- Last backup: TODO (implement monitoring)

### CouchDB (LiveSync)
- Status: 🟡 NOT YET DEPLOYED
- Server: gerc:5984
- Database: eww-vault
- Documents: 0 (not started)
- Replications: 0 (not started)

---

## 🔧 Maintenance

### Daily
- ✅ Obsidian Git auto-commit (hourly)
- ✅ LiveSync real-time sync (continuous)
- ⏰ Graph snapshot (00:00 daily) - TODO: implement
- ⏰ GitHub backup (03:00 daily) - TODO: implement

### Weekly
- [ ] Check CouchDB health: `curl http://192.168.0.99:5984`
- [ ] Review Git log: `git log --since="1 week ago" --oneline`
- [ ] Check network connectivity (ping tests)
- [ ] Review systemd timers: `systemctl --user list-timers`

### Monthly
- [ ] Update software (apt, Obsidian, VS Code)
- [ ] Review licenses (Copilot, ChatGPT)
- [ ] Backup critical configs
- [ ] Review storage usage: `df -h`

### Quarterly
- [ ] Full system backup
- [ ] Review hardware health (temperatures, fans)
- [ ] Update documentation (this file!)
- [ ] Review and cleanup old branches

---

## 🆘 Troubleshooting

### Network Issues

**Symptom**: Machine can't access internet
**Debug**:
```bash
# Test local network
ping 192.168.0.10  # Gateway
ping 192.168.0.99  # GERC
ping 192.168.0.77  # ASUS Z77

# Test WAN
ping 8.8.8.8       # Google DNS
ping 1.1.1.1       # Cloudflare DNS

# Check routing
ip route
traceroute 8.8.8.8

# Check DNS
systemd-resolve --status
nslookup google.com
```

**Solutions**:
1. Check gateway: `http://192.168.0.10` (router admin)
2. Restart network: `sudo systemctl restart NetworkManager`
3. Check firewall: `sudo ufw status`
4. Disable VPN: `tailscale down` (test if VPN causes issues)
5. Check Cloudflare WARP: `warp-cli status` (known to cause conflicts)

---

### SSH Issues

**Symptom**: Can't SSH between machines
**Debug**:
```bash
# Test SSH service
systemctl status sshd

# Test connection
ssh -v user@192.168.0.xx

# Check firewall
sudo ufw status

# Check SSH config
cat ~/.ssh/config
cat /etc/ssh/sshd_config
```

**Solutions**:
1. Start SSH: `sudo systemctl start sshd`
2. Allow in firewall: `sudo ufw allow ssh`
3. Check permissions: `chmod 600 ~/.ssh/id_*`
4. Regenerate keys: `ssh-keygen -t ed25519`

---

### Git Issues

**Symptom**: Can't push to GitHub
**Debug**:
```bash
# Test connection
ssh -T git@github.com

# Check remote
git remote -v

# Check credentials
cat ~/.gitconfig
```

**Solutions**:
1. Add SSH key to GitHub: `cat ~/.ssh/id_ed25519.pub`
2. Update remote: `git remote set-url origin git@github.com:Nairecth/eww.git`
3. Test again: `git fetch`

---

### Obsidian Sync Issues

**LiveSync problems**:
```bash
# Check CouchDB
curl http://192.168.0.99:5984

# Check database
curl http://eww-admin:PASSWORD@192.168.0.99:5984/eww-vault

# Restart plugin
# Obsidian → Settings → Self-hosted LiveSync → Reload
```

**Git plugin problems**:
```bash
# Check last commit
git log -1

# Force manual commit
# Obsidian → Open command palette → Git: Commit all changes

# Check Git status
git status
```

---

## 🔗 Related Docs

- [[core/workflow/workflow]] - Complete workflow guide
- [[core/workflow/git-sync-strategy]] - Git + LiveSync strategy
- [[docs/infra/hardware/hardware]] - Hardware index
- [[docs/infra/hardware/network/network]] - Network configuration
- [[docs/infra/software/obsidian/obsidian]] - Obsidian documentation
- [[core/config]] - Core configuration

---

**Status**: 🟡 IN PROGRESS
**Completed**: Hardware inventory, network map, software stack definition
**TODO**:
- [ ] Document Codex (purpose, installation, usage)
- [ ] Verify organization names for Copilot/ChatGPT
- [ ] Verify current license costs
- [ ] Implement usage stats monitoring
- [ ] Verify karinam's repo location (home vs usr)

**Owner**: jakubc
**Contributors**: karinam
**Last updated**: 2025-11-23

## 🔗 Backlinks

- [[core/workflow/workflow]]
- [[core/core]]
- [[core/config]]