# INDEX - E-Waste Workshop

> **Automatycznie wygenerowany indeks repozytorium**  
> Ostatnia aktualizacja: 2025-11-09

## 📖 O tym dokumencie

Ten plik zawiera kompletny indeks wszystkich folderów i plików w projekcie wraz z ich opisami.

- **Foldery** - opis z ich `README.md` lub `.filedesc`
- **Pliki** - opis z `.filedesc`

---

## 📁 Struktura główna

| Folder | Opis |
|--------|------|
| `lib/` | Biblioteki współdzielone - helpery Bash do użytku w skryptach |
| `dev/` | Narzędzia deweloperskie - CLI, skrypty, testy, systemd |
| `docs/` | Dokumentacja projektu - wiki, przewodniki, notatki |
| `archive/` | Archiwum - backups, stare wersje, zarchiwizowane pliki |

## 📄 Pliki główne (MVP)

| Plik | Opis |
|------|------|
| `README.md` | Dokumentacja główna projektu E-Waste Workshop |
| `VERSION` | Numer wersji projektu (semver: x.y.z.b) |
| `CHANGELOG.md` | Historia zmian w formacie Keep a Changelog |
| `Makefile` | Automatyzacja zadań (changelog, release, komentarze, testy) |
| `MVP.md` | Kryteria akceptacji dla wersji MVP 0.0.0.1 |
| `AGENTS.md` | Kontekst dla AI coding agents (architektura, workflow) |
| `init-eww.sh` | Skrypt inicjalizacyjny środowiska (source w ~/.bashrc) |
| `.filedesc` | Opisy wszystkich plików w projekcie (ten plik) |

## 📖 lib/ - Biblioteki współdzielone

Biblioteki współdzielone - helpery Bash do użytku w skryptach

| Plik | Opis |
|------|------|
| `lib/banner.sh` | Funkcje do generowania banerów ASCII |
| `lib/git.sh` | Helpery Git (tagi, commity, sprawdzanie stanu) |
| `lib/idempotent.sh` | Operacje idempotentne (dodawanie linii, instalacja pakietów) |
| `lib/log.sh` | System logowania (log_info, log_warn, log_error) |
| `lib/sys.sh` | Helpery systemowe (dystrybucja, zależności) |

## 🛠️ dev/ - Narzędzia deweloperskie

Narzędzia deweloperskie - CLI, skrypty, testy, systemd

### dev/bin/ - Narzędzia CLI

| Narzędzie | Opis |
|-----------|------|
| `eww-auto-comment` ✅ | Automatyczne dodawanie komentarzy do funkcji Bash |
| `eww::baner` | Baner (zduplikowany, do usunięcia) |
| `eww-banner` | Generator banerów tekstowych (legacy) |
| `eww-changelog` ✅ | Generator changelog z commitów Git (Conventional Commits) |
| `eww-commit` | Helper do tworzenia commitów z Conventional Commits |
| `eww-doctor` | Diagnostyka środowiska deweloperskiego |
| `eww-index` ✅ | Generuje INDEX.md z opisami folderów i plików |
| `eww-status` | Wyświetlanie statusu projektu (wersja, gałąź, zmiany) |
| `eww-tree` ✅ | Wyświetla drzewo katalogów z opisami plików |

### dev/scripts/ - Skrypty pomocnicze

| Skrypt | Opis |
|--------|------|
| `archive-backups.sh` | Archiwizacja starych kopii zapasowych |
| `bump-version.sh` | Podbicie wersji + utworzenie branch/tag/PR |
| `check_readme.sh` | Walidacja README.md (checklist, struktura) |
| `eww-banner.sh` | Generowanie banerów (legacy, duplikat) |
| `eww-fix-init.sh` | Naprawa uszkodzonego init-eww.sh |
| `eww-git-gpg-fix.sh` | Naprawa konfiguracji GPG dla Git |
| `eww-init-idempotent-example.sh` | Przykład użycia lib/idempotent.sh |
| `eww-post-install.sh` | Skrypt uruchamiany po instalacji |
| `release.sh` | Proces wydania nowej wersji (pełny workflow) |
| `semver_auto.sh` | Automatyczna inkrementacja semantic versioning |
| `version.sh` | Zarządzanie numerem wersji |

### dev/cfg/ - Konfiguracje

| Plik | Opis |
|------|------|
| `bashrc.eww.snippet` | Fragment do dodania do ~/.bashrc (source init-eww.sh) |
| `gitconfig.repo` | Konfiguracja Git specyficzna dla tego repo |
| `pre-commit.yaml` | Hooki pre-commit dla walidacji kodu |

### dev/systemd/ - Jednostki systemd

| Jednostka | Opis |
|-----------|------|
| `eww-autocommit.service` | Serwis systemd do automatycznych commitów |
| `eww-autocommit.timer` | Timer uruchamiający autocommit codziennie |
| `eww-status.service` | Serwis do wyświetlania statusu projektu |
| `eww-status.timer` | Timer uruchamiający status co godzinę |

### dev/tests/ - Testy BATS

| Test | Opis |
|------|------|
| `test_idempotency.bats` | Testy operacji idempotentnych |
| `test_init.bats` | Testy jednostkowe dla init-eww.sh |
| `test_init_behavior.bats` | Testy zachowania podczas inicjalizacji |

## 📚 docs/ - Dokumentacja

Dokumentacja projektu - wiki, przewodniki, notatki

| Dokument | Opis |
|----------|------|
| `ENDPOINTS.md` | Dokumentacja API endpoints |
| `index.md` | Strona główna dokumentacji (MkDocs) |
| `readme-checklist.md` | Checklist dla kompletnego README.md |
| `README.md` | Indeks dokumentacji projektu |
| `release-0.0.0.1.md` | Notatki z wydania MVP 0.0.0.1 |
| `vendor.md` | Zależności zewnętrzne i vendor packages |

---

## 🔄 Aktualizacja

Aby zaktualizować ten indeks:

```bash
./dev/bin/eww-index
# lub
make index
```

**Wygenerowano:** `./dev/bin/eww-index`  
**Źródło opisów:** `.filedesc`
