created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---
tags:
  - #automation
  - #eww
  - #ssh
  - #vscode
  - #remote
  - #development
title: "🌐 Przewodnik Remote SSH w VS Code"
owner: jakubc
created: 2025-11-24T22:31:33Z
modified: 2025-11-24T22:31:33Z
author: jakubc
---

# 🌐 Przewodnik Remote SSH w VS Code

> **Jak łączyć się przez SSH do katalogów domowych innych użytkowników**

## 📋 Koncepcja

Katalog `usr/<username>/` w VS Code zapewnia **zdalny dostęp przez SSH** do fizycznego katalogu `/home/<username>/` na innej maszynie.

**Przykład:**
```
[VS Code na dev-laptop]
        |
        | SSH: karinam@ops-workstation
        |
        v
/home/karinam/ (ops-workstation)
```

Pracujesz w VS Code na swojej maszynie, ale **pliki są fizycznie na zdalnej maszynie**.

## 🎯 Przypadki użycia

- **Jakub (dev-laptop)** chce edytować pliki w `/home/karinam/` na `ops-workstation`
- **Karina (ops-workstation)** chce edytować pliki w `/home/jakubc/` na `dev-laptop`
- Współpraca w czasie rzeczywistym
- Debugowanie problemów na zdalnej maszynie
- Praca na zdalnym środowisku bez kopiowania plików

## 🔧 Wymagania

### 1. Rozszerzenie VS Code

Zainstaluj **Remote - SSH**:

```bash
code --install-extension ms-vscode-remote.remote-ssh
```

Lub w VS Code:
- `Ctrl+Shift+X`
- Wyszukaj: "Remote - SSH"
- Zainstaluj

### 2. SSH Server na zdalnej maszynie

Maszyna docelowa musi mieć uruchomiony SSH server:

```bash
# Na ops-workstation (karinam)
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
```

### 3. Klucze SSH (opcjonalne, ale zalecane)

Wygeneruj klucz SSH na lokalnej maszynie:

```bash
# Na dev-laptop (jakubc)
ssh-keygen -t ed25519 -C "jakubc@dev-laptop"

# Skopiuj klucz do zdalnej maszyny
ssh-copy-id karinam@ops-workstation
```

Teraz możesz łączyć się bez hasła!

## 📝 Konfiguracja SSH

### 1. Edytuj ~/.ssh/config

Na **lokalnej** maszynie (dev-laptop):

```bash
nano ~/.ssh/config
```

Dodaj wpis dla zdalnej maszyny:

```ssh-config
# ops-workstation (Karina)
Host ops-workstation
    HostName 192.168.1.100          # IP lub hostname
    User karinam
    IdentityFile ~/.ssh/id_ed25519
    Port 22
    ForwardAgent yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

**Parametry:**
- `Host` - alias, którego użyjesz w VS Code
- `HostName` - IP lub nazwa DNS maszyny
- `User` - nazwa użytkownika na zdalnej maszynie
- `IdentityFile` - ścieżka do klucza prywatnego SSH
- `ForwardAgent` - przekazanie agenta SSH (dla git)
- `ServerAliveInterval` - utrzymanie połączenia

### 2. Testuj połączenie

```bash
# Sprawdź, czy działa
ssh ops-workstation

# Powinieneś zobaczyć prompt:
# karinam@ops-workstation:~$
```

## 🖥️ Łączenie przez VS Code

### Metoda 1: Command Palette

1. `Ctrl+Shift+P`
2. Wpisz: **"Remote-SSH: Connect to Host..."**
3. Wybierz: `ops-workstation`
4. VS Code otworzy nowe okno i połączy się przez SSH
5. Otwórz folder: `/home/karinam/`

### Metoda 2: Remote Explorer

1. Kliknij ikonę **Remote Explorer** w lewym panelu
2. W sekcji **SSH Targets** zobaczysz `ops-workstation`
3. Kliknij prawym → **Connect in New Window**

### Metoda 3: Bezpośredni URI

```bash
# Otwórz VS Code bezpośrednio przez SSH
code --folder-uri vscode-remote://ssh-remote+ops-workstation/home/karinam/
```

## 📁 Struktura w workspace

Po skonfigurowaniu możesz dodać remote folder do workspace:

**W `.vscode/eww.code-workspace`:**

```json
{
  "folders": [
    {
      "name": "📁 EWW (local)",
      "path": "/home/jakubc/git/eww"
    },
    {
      "name": "🏠 karinam@ops-workstation",
      "uri": "vscode-remote://ssh-remote+ops-workstation/home/karinam"
    },
    {
      "name": "🏠 jakubc@dev-laptop",
      "path": "/home/jakubc"
    }
  ],
  "settings": {
    "remote.SSH.remotePlatform": {
      "ops-workstation": "linux"
    }
  }
}
```

Teraz w jednym oknie VS Code masz:
- Lokalne repozytorium EWW
- Zdalny `/home/karinam/` przez SSH
- Lokalny `/home/jakubc/`

## 🔐 Bezpieczeństwo

### Zasady

1. **NIE** commituj kluczy SSH do Git
2. **NIE** udostępniaj haseł w repo
3. Używaj kluczy SSH, nie haseł
4. Ogranicz dostęp SSH w `sshd_config`:

```bash
# Na ops-workstation: /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no  # Tylko klucze SSH
PubkeyAuthentication yes
AllowUsers karinam jakubc
```

### .gitignore

Upewnij się, że w `.gitignore`:

```gitignore
# SSH keys (nigdy nie commituj!)
.ssh/
id_rsa*
id_ed25519*
*.pem
*.key
```

## 🚀 Quick Start

### Dla Jakuba (dostęp do Kariny)

```bash
# 1. Wygeneruj klucz SSH (jeśli nie masz)
ssh-keygen -t ed25519 -C "jakubc@dev-laptop"

# 2. Skopiuj klucz do ops-workstation
ssh-copy-id karinam@ops-workstation

# 3. Dodaj do ~/.ssh/config
cat >> ~/.ssh/config << 'EOF'
Host ops-workstation
    HostName 192.168.1.100  # Zmień na właściwy IP
    User karinam
    IdentityFile ~/.ssh/id_ed25519
EOF

# 4. Testuj
ssh ops-workstation

# 5. Otwórz w VS Code
code --folder-uri vscode-remote://ssh-remote+ops-workstation/home/karinam/
```

### Dla Kariny (dostęp do Jakuba)

```bash
# 1. Wygeneruj klucz SSH
ssh-keygen -t ed25519 -C "karinam@ops-workstation"

# 2. Skopiuj klucz do dev-laptop
ssh-copy-id jakubc@dev-laptop

# 3. Dodaj do ~/.ssh/config
cat >> ~/.ssh/config << 'EOF'
Host dev-laptop
    HostName 192.168.1.50  # Zmień na właściwy IP
    User jakubc
    IdentityFile ~/.ssh/id_ed25519
EOF

# 4. Testuj
ssh dev-laptop

# 5. Otwórz w VS Code
code --folder-uri vscode-remote://ssh-remote+dev-laptop/home/jakubc/
```

## 🔄 Synchronizacja plików (opcjonalnie)

Jeśli chcesz też mieć lokalną kopię:

```bash
# Synchronizuj remote → local
rsync -avz --progress ops-workstation:/home/karinam/TODO/ ~/eww/usr/karinam/TODO/

# Synchronizuj local → remote
rsync -avz --progress ~/eww/usr/karinam/TODO/ ops-workstation:/home/karinam/TODO/
```

Ale pamiętaj: **Remote SSH pracuje bezpośrednio na zdalnych plikach**, nie potrzebujesz synchronizacji!

## 🤖 Automatyzacja (TODO)

### Skrypt pomocniczy

Planowany: `eww-ssh-connect`

```bash
# Połącz się do użytkownika
eww-ssh-connect karinam

# Lista dostępnych hostów
eww-ssh-connect --list
```

## 📚 Zobacz też

- [VS Code Remote SSH Documentation](https://code.visualstudio.com/docs/remote/ssh)
- [usr/README.md](./README.md) - Dokumentacja katalogu usr/
- [SSH Config Manual](https://man.openbsd.org/ssh_config)

## ❓ FAQ

**Q: Czy pliki są kopiowane na moją maszynę?**
A: Nie! Pracujesz bezpośrednio na zdalnych plikach. Tylko edytor działa lokalnie.

**Q: Co jeśli stracę połączenie?**
A: VS Code automatycznie spróbuje się reconnect. Niezapisane zmiany są bufferowane.

**Q: Czy mogę używać terminala?**
A: Tak! Terminal w VS Code (`Ctrl+`) działa na zdalnej maszynie.

**Q: Czy Git działa normalnie?**
A: Tak! Git działa na zdalnej maszynie. Użyj `ForwardAgent yes` w `~/.ssh/config`.

**Q: Jak znaleźć IP zdalnej maszyny?**
A: Na zdalnej maszynie: `ip addr show` lub `hostname -I`

**Q: Czy mogę otworzyć wiele połączeń?**
A: Tak! Możesz mieć otwarte okna VS Code do różnych hostów jednocześnie.
