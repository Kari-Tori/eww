# E-Waste Workshop – `/git/eww`

**Lokalizacja (lokalny dysk):** `/git/eww`  
**Repo (GitHub):** https://github.com/Nairecth/eww  
**Owner/Contact:** astriblast@gmail.com

## Cel
Jedno źródło prawdy (SoT) dla integracji E-Waste Workshop z systemem Kubuntu: skrypty, konfiguracje, procedury, logi i testy. Wszystko idempotentne i powtarzalne.

## Docelowa struktura plików
```
/git/eww
├─ README.md
├─ init-eww.sh                  # główny inicjalizator systemu
├─ bin/                         # narzędzia CLI (wykonywalne)
│   └─ eww-*                    # np. eww-status, eww-commit, eww-banner
├─ scripts/                     # skrypty pomocnicze i instalacyjne
│   ├─ eww-banner.sh
│   ├─ eww-git-gpg-fix.sh
│   └─ eww-post-install.sh
├─ lib/                         # biblioteki bash (log, fs, sys, git)
│   ├─ log.sh
│   ├─ git.sh
│   └─ sys.sh
├─ cfg/                         # szablony i pliki konfiguracyjne
│   ├─ bashrc.eww.snippet
│   ├─ gitconfig.repo
│   └─ pre-commit.yaml
├─ systemd/                     # jednostki i timery dla auto-zadań
│   ├─ eww-autocommit.service
│   ├─ eww-autocommit.timer
│   ├─ eww-status.service
│   └─ eww-status.timer
├─ docs/                        # „vendor docs” + tłumaczenia PL
│   ├─ vendor/                  # zewnętrzne źródła (readme, licencje)
│   └─ translated/              # tłumaczenia i notatki integracyjne
├─ tests/                       # testy (bats/shunit) + fixture’y
│   ├─ test_init.bats
│   └─ test_idempotency.bats
├─ logs/                        # artefakty uruchomieniowe
│   ├─ install/
│   └─ status/
├─ .github/workflows/           # CI (lint, shellcheck, bats)
│   └─ ci.yml
└─ .pre-commit-config.yaml      # hooki format/lint
```

## Procedura integracji (Kubuntu)
1. **Wymagania:** `bash>=5`, `git`, `gpg`, `curl`, `coreutils`, `systemd`, `sed`, `awk`, `diffutils`, `python3`, `shellcheck` (CI), `bats` (testy).  
2. **Pobranie repo:**
   ```bash
   sudo mkdir -p /git && sudo chown "$USER":"$USER" /git
   git clone https://github.com/Nairecth/eww /git/eww
   cd /git/eww
   ```
3. **Podpięcie do powłoki (snippet):**
   ```bash
   printf '%s\n' '# EWW init' '[[ -r /git/eww/init-eww.sh ]] && . /git/eww/init-eww.sh' >> ~/.bashrc
   ```
4. **Uruchomienie inicjalizacji:**
   ```bash
   bash -lc '/git/eww/init-eww.sh --bootstrap'
   ```
5. **Dokumentacja integracji:**
   - Pobierz **najnowsze oficjalne dokumenty** komponentów (np. Git, GPG, systemd, pre-commit, Bats, ShellCheck).
   - Zapisz niezmienione źródła do `docs/vendor/` i **tłumaczenie PL** do `docs/translated/` z datą i wersją.
6. **Walidacja:**
   ```bash
   eww-status         # szybki health check
   systemctl list-timers | grep eww
   bats tests/        # testy muszą przejść
   ```

## Kolejność wdrożeń (plan)
1. Git + GPG + pre-commit (repo sanity).  
2. `init-eww.sh` w `.bashrc` i skeleton katalogów.  
3. systemd: `eww-autocommit.timer`, `eww-status.timer`.  
4. Import i tłumaczenia „vendor docs”.  
5. Testy (bats) + ShellCheck w CI.  
6. Rozszerzenia: logi, raporty, integracje z innymi hostami.

## `init-eww.sh` – zakres
- Tworzy strukturę katalogów i nadaje uprawnienia (idempotentnie).  
- Konfiguruje repo: `user.name`, `user.email`, GPG-sign, `pre-commit`.  
- Wstrzykuje snippet do `~/.bashrc` i prezentuje baner statusu.  
- Instaluje i aktywuje timery `systemd`:
  - `eww-autocommit` – commit + push zmian cyklicznie.
  - `eww-status` – zrzut statusu do `logs/status/`.  
- Odkłada logi z każdego kroku do `logs/install/`.  
- Zawsze bezpieczny przy wielokrotnym uruchomieniu.

## Definition of Done (DoD)
- [ ] Repo w `/git/eww` z czystym `git status`.  
- [ ] `bats tests/` przechodzi.  
- [ ] `shellcheck` bez błędów krytycznych.  
- [ ] `eww-autocommit.timer` i `eww-status.timer` **active**.  
- [ ] `eww-status` raportuje OK, logi w `logs/status/` rosną.  
- [ ] Dokumenty źródłowe w `docs/vendor/` i tłumaczenia w `docs/translated/` z datami i wersjami.

## Lista definicji
- **Idempotencja** – wielokrotne uruchomienie daje ten sam efekt końcowy.  
- **SoT (Source of Truth)** – pojedyncze kanoniczne źródło konfiguracji.  
- **Pre-commit** – lokalne hooki formatujące i lintujące przed commit.  
- **Timer systemd** – harmonogram uruchamiania usług w odstępach czasu.  
- **Vendor docs** – oryginalna dokumentacja zewnętrznych komponentów.
