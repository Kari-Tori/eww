---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T13:00:00Z
modified: 2025-11-21T13:00:00Z
author: jakubc
title: "## 🗺️ Docelowy układ po migracji"






---

moge# 🔐 TODO-SSH – Synchronizacja GERC ↔ Asus_Z77

> [!summary] Kontekst operacji
> 🧭 **Cel nadrzędny:** zunifikować repozytorium `eww` i środowiska edytorów pomiędzy GERC a Asus_Z77, żeby każdy użytkownik miał tę samą bazę.  
> 🖥️ **Maszyny:** ⬅️ `GERC (192.168.0.99)` ➡️ `Asus_Z77 (192.168.0.77)`; użytkownicy `jakubc` oraz `karinam`.  
> 🛟 **Bezpieczeństwo:** każdy krok zakłada backup, dry-run lub log, aby w razie problemów odtworzyć poprzedni stan.  
> 🧩 **Efekt końcowy:** po migracji wszystkie zadania wykonujesz już z `/jakubc/git/eww`, a stare `/git/eww` zostaje tylko jako archiwum.

## 🗺️ Docelowy układ po migracji
> [!abstract]+ Struktura katalogów po zgraniu
> > 🧰 `/jakubc/git/eww` (GERC) – finalne repo robocze, będące miksem Asus_Z77 + lokalnych dodatków.  
> > 🗃️ `/git/eww` (GERC) – źródło historyczne, do skasowania po pełnej weryfikacji.  
> > 👥 `/usr/karinam/git/eww` (Asus_Z77) – repo równoległe, ma mieć identyczny rozkład jak `~/git/eww` niezależnie od użytkownika.


## 🧭 Etap 1 – Wstępne przygotowanie na GERC
Upewnij się, że masz świeży backup i wolne miejsce zanim zaczniesz mieszać w repozytoriach.

> [!todo]+ 💾 Krok 1 — Sprawdź stan repo i utwórz backup
> > 🎯 **Cel:** mieć dokładny obraz bieżącego stanu i punkt przywracania.  
> > 📍 **Kontekst:** repozytorium `/git/eww` na GERC.  
> > 🧰 **Narzędzia:** `git`, `cp`, uprawnienia `sudo`.  
> > 
> > ```bash
> > cd /git/eww
> > git status
> > sudo mkdir -p /jakubc/git
> > sudo cp -a /git/eww "/jakubc/git/eww_backup_$(date +%Y%m%d_%H%M%S)"
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** `git status` ujawnia ewentualne lokalne zmiany, a pełne `cp -a` robi bit‑identyczny snapshot do katalogu domowego `jakubc`.

> [!todo]+ 📦 Krok 2 — Przygotuj katalog docelowy i sprawdź wolne miejsce
> > 🎯 **Cel:** mieć przygotowany katalog docelowy z poprawnymi uprawnieniami i pewność, że rsync się nie wysypie.  
> > 📍 **Kontekst:** `/jakubc/git/` na GERC.  
> > 🧰 **Narzędzia:** `mkdir`, `chown`, `df`.  
> > 
> > ```bash
> > sudo mkdir -p /jakubc/git/eww
> > sudo chown -R jakubc:jakubc /jakubc/git
> > df -h /jakubc
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** katalog i właściciel są ustawieni raz, żeby kolejne kroki nie wymagały `sudo`, a `df` potwierdza dostępne miejsce.

## 🔍 Etap 2 – Diagnostyka repozytorium na Asus_Z77
Zweryfikuj po stronie źródłowej ścieżki, historię Gita oraz konfiguracje edytorów.

> [!todo]+ 🌐 Krok 3 — Wejdź na ASUS-a i sprawdź ścieżki
> > 🎯 **Cel:** potwierdzić, że łączysz się do właściwej maszyny i katalogu oraz że jest miejsce na ewentualne logi.  
> > 📍 **Kontekst:** `/usr/karinam/git/eww` na Asus_Z77.  
> > 🧰 **Narzędzia:** `ssh`, `df`.  
> > 
> > ```bash
> > ssh karinam@192.168.0.77 <<'EOF'
> > cd /usr/karinam/git/eww
> > hostname && pwd
> > df -h .
> > EOF
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** `hostname` + `pwd` ograniczają ryzyko kopiowania z złej lokalizacji, a `df` pokazuje czy lokalny dysk nie jest zapełniony.

> [!todo]+ 🧾 Krok 4 — Zbierz status Gita oraz listę commitów
> > 🎯 **Cel:** zmapować lokalne zmiany i ostatnie commity, żeby później łatwiej porównywać.  
> > 📍 **Kontekst:** repo `eww` na Asus_Z77.  
> > 🧰 **Narzędzia:** `git status -sb`, `git log`, `git log --stat`.  
> > 
> > ```bash
> > ssh karinam@192.168.0.77 <<'EOF'
> > cd /usr/karinam/git/eww
> > git status -sb
> > git log --oneline -15
> > git log --since="2025-10-15" --stat
> > EOF
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** skrócony status jest czytelny zdalnie, a dodatkowe logi (ostatnie 15 commitów + od połowy października 2025) dadzą pełną listę zmian do porównania.

> [!todo]+ 🗂️ Krok 5 — Spisz katalogi konfiguracyjne VS Code/Obsidiana
> > 🎯 **Cel:** mieć referencję struktury konfiguracji, aby łatwiej sprawdzić kompletność transferu.  
> > 📍 **Kontekst:** `~/.config/Code`, `~/.config/obsidian`, `~/.vscode` na Asus_Z77.  
> > 🧰 **Narzędzia:** `tree`, `ls`.  
> > 
> > ```bash
> > ssh karinam@192.168.0.77 <<'EOF'
> > tree -L 2 ~/.config/Code > ~/code_config_tree.txt
> > tree -L 2 ~/.config/obsidian > ~/obsidian_config_tree.txt
> > ls -la ~/.vscode
> > EOF
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** zapisane listingi (`tree -L 2`) staną się szybkim checklistem podczas odtwarzania ustawień na GERC.

## 🚚 Etap 3 – Transfer danych i konfiguracji
Najpierw wykonaj bezpieczny dry-run, potem właściwy rsync i napraw uprawnienia.

> [!todo]+ 🔁 Krok 6 — Zsynchronizuj repo (dry-run + właściwy rsync)
> > 🎯 **Cel:** przenieść zawartość `eww` z Asus_Z77 do `/jakubc/git/eww` zachowując strukturę i prawa.  
> > 📍 **Kontekst:** transfer sieciowy `karinam@192.168.0.77 → GERC`.  
> > 🧰 **Narzędzia:** `rsync -avh --progress`.  
> > 
> > ```bash
> > rsync -avh --dry-run --progress karinam@192.168.0.77:/usr/karinam/git/eww/. /jakubc/git/eww/
> > rsync -avh --progress karinam@192.168.0.77:/usr/karinam/git/eww/. /jakubc/git/eww/
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** pierwsza komenda to tylko podgląd zmian, druga wykonuje faktyczne kopiowanie, dzięki czemu nie zaskoczą Cię nadpisania.

> [!todo]+ 🧾 Krok 7 — Ustaw odpowiednie uprawnienia
> > 🎯 **Cel:** zunifikować właściciela i prawa, aby Git + narzędzia działały bez `sudo`.  
> > 📍 **Kontekst:** `/jakubc/git/eww`.  
> > 🧰 **Narzędzia:** `chown`, `find`.  
> > 
> > ```bash
> > sudo chown -R jakubc:jakubc /jakubc/git/eww
> > find /jakubc/git/eww -type d -exec chmod 755 {} \;
> > find /jakubc/git/eww -type f -exec chmod 644 {} \;
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** po rsyncu pliki mogą mieć prawa użytkownika `karinam`; masowe `chown`+`chmod` normalizują sytuację.

> [!todo]+ 🧩 Krok 8 — Przenieś konfiguracje edytorów i Obsidiana
> > 🎯 **Cel:** synchronizować ustawienia VS Code, Obsidiana i `.vscode`.  
> > 📍 **Kontekst:** katalogi konfiguracyjne w `~/.config` i `~/.vscode`.  
> > 🧰 **Narzędzia:** `cp`, `rsync`.  
> > 
> > ```bash
> > mkdir -p ~/.config/Code_backup ~/.config/obsidian_backup ~/.vscode_backup
> > cp -a ~/.config/Code/. ~/.config/Code_backup/
> > cp -a ~/.config/obsidian/. ~/.config/obsidian_backup/
> > cp -a ~/.vscode/. ~/.vscode_backup/
> > rsync -avh --progress karinam@192.168.0.77:~/.config/Code/ ~/.config/Code/
> > rsync -avh --progress karinam@192.168.0.77:~/.vscode/ ~/.vscode/
> > rsync -avh --progress karinam@192.168.0.77:~/.config/obsidian/ ~/.config/obsidian/
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** najpierw lokalny backup (na wypadek złych danych), potem właściwe rsync z Asus_Z77, by ujednolicić środowisko edytora i Obsidiana.

## 🧾 Etap 4 – Porównanie i scalanie katalogów
Zweryfikuj, czy nic nie zginęło i scal ewentualne resztki ze starego `/git/eww`.

> [!todo]+ 🧮 Krok 9 — Porównaj stare `/git/eww` z nowym `/jakubc/git/eww`
> > 🎯 **Cel:** mieć raport różnic między archiwalnym i nowym repo.  
> > 📍 **Kontekst:** katalogi na GERC.  
> > 🧰 **Narzędzia:** `diff -qr`, `tee`.  
> > 
> > ```bash
> > diff -qr /git/eww /jakubc/git/eww | tee /jakubc/git/diff_eww_$(date +%Y%m%d_%H%M).log
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** `diff -qr` daje listę różnic, a log nazywany timestampem tworzy dokumentację porównania.

> [!todo]+ 🔄 Krok 10 — Jeśli w `/git/eww` są unikalne pliki – przenieś je
> > 🎯 **Cel:** dosymilować brakujące pliki bez nadpisywania świeżego repo.  
> > 📍 **Kontekst:** `/git/eww → /jakubc/git/eww`.  
> > 🧰 **Narzędzia:** `rsync` z dry-run.  
> > 
> > ```bash
> > rsync -avh --dry-run --progress /git/eww/ /jakubc/git/eww/
> > rsync -avh --progress /git/eww/ /jakubc/git/eww/
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** sekwencja identyczna jak w kroku 6 – najpierw kontrolny podgląd, później realne kopiowanie braków.

> [!todo]+ 🧭 Krok 11 — Ustaw `/jakubc/git/eww` jako główne repo robocze
> > 🎯 **Cel:** szybki dostęp do nowego repo oraz otwarcie w ulubionym edytorze.  
> > 📍 **Kontekst:** shell `jakubc`.  
> > 🧰 **Narzędzia:** alias w `.bashrc`, VS Code.  
> > 
> > ```bash
> > echo 'alias proj="cd /jakubc/git/eww"' >> ~/.bashrc
> > source ~/.bashrc
> > code /jakubc/git/eww
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** alias `proj` oszczędza kilka klawiszy, a otwarcie katalogu w VS Code (lub innym edytorze) pozwala od razu przejść do pracy.

## ✅ Etap 5 – Kontrola końcowa
Zrób sanity-check w Git oraz w narzędziach projektowych, by mieć pewność, że środowisko działa.

> [!todo]+ 📊 Krok 12 — Sprawdź stan Gita po scaleniu
> > 🎯 **Cel:** upewnić się, że nowy katalog ma oczekiwaną historię i brak niepożądanych zmian.  
> > 📍 **Kontekst:** `/jakubc/git/eww`.  
> > 🧰 **Narzędzia:** `git status`, `git log --graph`.  
> > 
> > ```bash
> > cd /jakubc/git/eww
> > git status
> > git log --graph --oneline -10
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** szybkie spojrzenie na status i 10 ostatnich commitów potwierdza, że historia została zachowana i nie ma nieśledzonych plików.

> [!todo]+ 🧪 Krok 13 — Uruchom projekt i przetestuj środowisko
> > 🎯 **Cel:** zweryfikować, że zależności i skrypty działają już w nowym repo.  
> > 📍 **Kontekst:** `/jakubc/git/eww` + lokalne narzędzia (np. Node).  
> > 🧰 **Narzędzia:** `npm install`, `npm run`.  
> > 
> > ```bash
> > cd /jakubc/git/eww
> > npm install
> > npm run lint && npm test
> > npm run dev
> > ```
> > 
> > 🗒️ **Wyjaśnienie:** pełny cykl (instalacja, lint, test, dev) daje pewność, że środowisko jest gotowe do pracy po migracji.

# Etap 1 – Wstępne przygotowanie na GERC
cd /git/eww
git status
sudo mkdir -p /jakubc/git
sudo cp -a /git/eww "/jakubc/git/eww_backup_$(date +%Y%m%d_%H%M%S)"
sudo mkdir -p /jakubc/git/eww
sudo chown -R jakubc:jakubc /jakubc/git
df -h /jakubc

# Etap 2 – Diagnostyka repozytorium na Asus_Z77
ssh karinam@192.168.0.77 <<'EOF'
cd /usr/karinam/git/eww
hostname && pwd
df -h .
git status -sb
git log --oneline -15
git log --since="2025-10-15" --stat
tree -L 2 ~/.config/Code > ~/code_config_tree.txt
tree -L 2 ~/.config/obsidian > ~/obsidian_config_tree.txt
ls -la ~/.vscode
EOF

# Etap 3 – Transfer danych i konfiguracji
rsync -avh --dry-run --progress karinam@192.168.0.77:/usr/karinam/git/eww/. /jakubc/git/eww/
rsync -avh --progress karinam@192.168.0.77:/usr/karinam/git/eww/. /jakubc/git/eww/
sudo chown -R jakubc:jakubc /jakubc/git/eww
find /jakubc/git/eww -type d -exec chmod 755 {} \;
find /jakubc/git/eww -type f -exec chmod 644 {} \;

mkdir -p ~/.config/Code_backup ~/.config/obsidian_backup ~/.vscode_backup
cp -a ~/.config/Code/. ~/.config/Code_backup/
cp -a ~/.config/obsidian/. ~/.config/obsidian_backup/
cp -a ~/.vscode/. ~/.vscode_backup/
rsync -avh --progress karinam@192.168.0.77:~/.config/Code/ ~/.config/Code/
rsync -avh --progress karinam@192.168.0.77:~/.vscode/ ~/.vscode/
rsync -avh --progress karinam@192.168.0.77:~/.config/obsidian/ ~/.config/obsidian/

# Etap 4 – Porównanie i scalanie katalogów
diff -qr /git/eww /jakubc/git/eww | tee /jakubc/git/diff_eww_$(date +%Y%m%d_%H%M).log
rsync -avh --dry-run --progress /git/eww/ /jakubc/git/eww/
rsync -avh --progress /git/eww/ /jakubc/git/eww/

echo 'alias proj="cd /jakubc/git/eww"' >> ~/.bashrc
source ~/.bashrc
code /jakubc/git/eww

# Etap 5 – Kontrola końcowa
cd /jakubc/git/eww
git status
git log --graph --oneline -10
npm install
npm run lint && npm test
npm run dev

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
