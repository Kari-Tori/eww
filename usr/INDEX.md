---
version: 0.0.6
tags:
  - #automation
  - #eww
  - #index
  - #ssh
  - #remote
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "📑 Index katalogu usr/"
owner: jakubc
---

# 📑 Index katalogu usr/

> **Dostęp SSH do katalogów domowych użytkowników na różnych maszynach**

## 📚 Dokumentacja

| Plik | Opis |
|------|------|
| [README.md](README.md) | Główna dokumentacja katalogu usr/ |
| [usr.md](usr.md) | Szczegóły koncepcji i struktury |
| [SSH-REMOTE-GUIDE.md](SSH-REMOTE-GUIDE.md) | **Przewodnik konfiguracji Remote SSH** |
| [ssh-config.example](ssh-config.example) | Przykładowa konfiguracja ~/.ssh/config |
| [workspace.example.json](workspace.example.json) | Przykład workspace z remote folders |
| [.gitignore](.gitignore) | Wykluczenia z Git (bezpieczeństwo) |

## 👥 Użytkownicy

### 🏠 jakubc/ (localhost)

**Maszyna**: `dev-laptop` (localhost)
**Path**: `/home/jakubc/`
**Dostęp**: Lokalny (ta maszyna)

- [jakubc/README.md](jakubc/README.md) - Profil Jakuba Celmera
- [jakubc/jakubc.md](jakubc/jakubc.md) - Szczegóły
- [jakubc/TODO/](jakubc/TODO/) - Listy zadań
- [jakubc/Notes/](jakubc/Notes/) - Notatki
- [jakubc/workspace/](jakubc/workspace/) - Projekty robocze

### 🌐 karinam/ (Remote SSH)

**Maszyna**: `ops-workstation` (zdalna przez SSH)
**Path**: `/home/karinam/`
**Dostęp**: Remote SSH

**Konfiguracja**:
```bash
# Dodaj do ~/.ssh/config:
Host ops-workstation
    HostName 192.168.1.100  # IP karinam's machine
    User karinam
    IdentityFile ~/.ssh/id_ed25519
```

**Połączenie**:
```bash
# Terminal
ssh ops-workstation

# VS Code Remote
code --folder-uri vscode-remote://ssh-remote+ops-workstation/home/karinam/
```

- [karinam/README.md](karinam/README.md) - Profil Kariny Mirowskiej
- [karinam/karinam.md](karinam/karinam.md) - Szczegóły
- [karinam/projects/](karinam/projects/) - Projekty
- [karinam/notes/](karinam/notes/) - Notatki

## 🚀 Quick Start

### 1. Zainstaluj rozszerzenie Remote SSH

```bash
code --install-extension ms-vscode-remote.remote-ssh
```

### 2. Skopiuj przykładową konfigurację SSH

```bash
cp /git/eww/usr/ssh-config.example ~/.ssh/config
nano ~/.ssh/config  # Edytuj IP
chmod 600 ~/.ssh/config
```

### 3. Wygeneruj klucz SSH (jeśli nie masz)

```bash
ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
```

### 4. Skopiuj klucz do zdalnej maszyny

```bash
# Z dev-laptop (jakubc) do ops-workstation (karinam)
ssh-copy-id karinam@ops-workstation

# Z ops-workstation (karinam) do dev-laptop (jakubc)
ssh-copy-id jakubc@dev-laptop
```

### 5. Testuj połączenie

```bash
ssh ops-workstation
# Powinno zalogować bez hasła
```

### 6. Otwórz w VS Code

```bash
# Command Palette
Ctrl+Shift+P → "Remote-SSH: Connect to Host..." → ops-workstation

# Lub z CLI
code --folder-uri vscode-remote://ssh-remote+ops-workstation/home/karinam/
```

## 🔐 Bezpieczeństwo

### ✅ DO

- Używaj kluczy SSH, nie haseł
- Ustaw `PasswordAuthentication no` w `/etc/ssh/sshd_config`
- Używaj `ForwardAgent yes` dla Git
- Regularnie rotuj klucze SSH

### ❌ NIE

- NIE commituj kluczy SSH do Git
- NIE udostępniaj kluczy prywatnych
- NIE używaj haseł do logowania SSH
- NIE otwieraj SSH na świat (firewall!)

## 🛠️ Narzędzia (TODO)

Planowane skrypty pomocnicze:

- `eww-ssh-connect` - Szybkie łączenie się do użytkowników
- `eww-ssh-status` - Status połączeń SSH
- `eww-ssh-setup` - Automatyczna konfiguracja SSH

## 📊 Struktura

```
usr/
├── INDEX.md                 # Ten plik
├── README.md                # Główna dokumentacja
├── usr.md                   # Koncepcja
├── SSH-REMOTE-GUIDE.md      # Przewodnik SSH
├── ssh-config.example       # Przykład ~/.ssh/config
├── workspace.example.json   # Przykład VS Code workspace
├── .gitignore               # Bezpieczeństwo
│
├── jakubc/                  # 🏠 /home/jakubc/ (localhost)
│   ├── README.md
│   ├── TODO/
│   ├── Notes/
│   └── workspace/
│
└── karinam/                 # 🌐 /home/karinam/ (SSH remote)
    ├── README.md
    ├── projects/
    └── notes/
```

## 🔗 Zobacz też

- [../README.md](../README.md) - Główny README projektu EWW
- [../docs/infra/software/code/code.md](../docs/infra/software/code/code.md) - Dokumentacja VS Code
- [VS Code Remote SSH Docs](https://code.visualstudio.com/docs/remote/ssh)

## 📝 Notatki

- Katalog `usr/` NIE zawiera lokalnych kopii plików
- Pliki są fizycznie na odpowiednich maszynach
- VS Code łączy się zdalnie przez SSH
- Edycja plików odbywa się bezpośrednio na zdalnej maszynie
- Nie trzeba synchronizować - wszystko jest real-time!

## 🔗 Backlinks

- [[usr/usr]]
- [[usr/INDEX.md/INDEX.md]]
- [[EWW-MAP]]
