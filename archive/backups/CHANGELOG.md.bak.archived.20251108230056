## [0.0.0.2] - 2025-11-08\n\n- Opis zmian\n\n
## [0.0.0.1-pre] - 2025-11-08\n\n- pre-MVP: prepare initial release\n\n
## [0.0.0.2] - 2025-11-08\n\n- Opis zmian\n\n
## [0.0.0.2] - 2025-11-08\n\n- Opis zmian\n\n
# Changelog

Zasady wersjonowania i proces dodawania zmian

- Plik `VERSION` zawiera aktualny numer wersji w formacie semver-like.
- Aby wprowadzić zmiany i wypuścić nową wersję: zaktualizuj plik `VERSION` do nowej wartości, dopisz wpis do `CHANGELOG.md` z opisem (krótko), a następnie zacommituj zmiany i wypchnij do repo.
- Dla prostoty używamy numerów postaci `major.minor.patch.build` (np. `0.0.0.1`).

## [0.0.0.1] - MVP

- Cel: zapewnić działający `init-eww.sh` i `README.md` pozwalający na inicjalizację świeżej instalacji najnowszego Kubuntu.
- Zawiera:
  - skrypt `init-eww.sh` (funkcja `eww::init`) — ustawia `EWW_ROOT`, opcjonalnie przechodzi do katalogu projektu, ładuje baner jeśli dostępny,
  - `README.md` z instrukcją pobrania i sourcowania skryptu,
  - plik `VERSION` ustawiony na `0.0.0.1`.

---

Przykładowy workflow przy wydawaniu nowej wersji:

```bash
# zmień wersję w pliku VERSION (np. 0.0.0.2)
echo "0.0.0.2" > VERSION

# dopisz wpis do CHANGELOG.md z krótkim opisem zmian
git add VERSION CHANGELOG.md
git commit -m "chore(release): 0.0.0.2 - opis zmian"
git tag -a v0.0.0.2 -m "Release 0.0.0.2"
git push origin main --tags
```
## v0.1.0 — 2025-11-07
- chore(versioning): add SemVer tooling (4b412e2)
- test signed commit (b97e28c)
- bootstrap (90d5c89)
- bootstrap (4fd2955)
- init wiki (663bf2f)
- feat(repo): bootstrap minimal ansible layout (c7504b9)
