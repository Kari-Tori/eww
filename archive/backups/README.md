# Archive for backup files

Ten katalog przechowuje kopie zapasowe i pliki tymczasowe przeniesione z głównego katalogu repo.

Jak używać
- Możesz uruchomić skrypt `scripts/archive-backups.sh --apply` aby automatycznie przenieść pasujące pliki (np. `init-eww.sh.bak*`, `*.bak`, pliki z sufiksem ` (1)`) do tego katalogu.
- Domyślnie skrypt działa w trybie podglądu (dry-run). Użyj `--apply` żeby wykonać przeniesienie.

Dlaczego to jest tutaj
- Uporządkuje widok repo i zmniejszy szum podczas uruchamiania pre-commit / grepu.
- Pliki backupów są ignorowane przez `.gitignore`.