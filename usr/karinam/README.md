# Dziennik Kariny — struktura katalogów

Ten katalog zawiera uporządkowaną wersję dziennika Kariny, przygotowaną do pracy w repozytorium.

Struktura i zasady:

- `journal/` — główny katalog vault-a używany na co dzień. Zawiera:
  - `Templates/` — szablony (regularne i Templater)
  - `Daily/` — przeniesione notatki dzienne
  - `ImportedNotes/` — wyekstrahowane pliki Markdown z surowego importu
  - `ImportedAttachments/` — wyekstrahowane załączniki (obrazy, media)
  - `bin/`, `systemd/` — skrypty i jednostki autostartu specyficzne dla tego vaulta

- `karinam_vault/` — oryginalna, surowa kopia importu (jeśli istnieje lokalnie). Pliki tego katalogu mogły zostać usunięte z gałęzi roboczej i zachowane na gałęzi archiwalnej.

Gdzie jest surowy import?
- Pełna, surowa kopia importu została zachowana na gałęzi `archive/imported-raw`. To bezpieczne archiwum — jeśli potrzebujesz odtworzyć dokładny stan surowego importu, przełącz się na tę gałąź.

Dlaczego usunąłem cache i pliki generowane?
- Pliki takie jak `.makemd/`, `.space/` i miniatury są wygenerowanymi artefaktami i mocno powiększają repozytorium. Zostały usunięte z gałęzi `feat/add-usr-karinam` żeby repo było zgrabniejsze. Surowe dane są bezpiecznie w `archive/imported-raw`.

Jeśli chcesz przywrócić surowy import lokalnie (bez zmieniania historii), wykonaj:

```bash
# przełącz się na branch archiwalny i skopiuj katalog lokalnie
git checkout archive/imported-raw
cp -a usr/karinam/karinam_vault "$HOME/karinam_vault-restore"
git checkout feat/add-usr-karinam
```

Jeśli chcesz oczyścić historię repo (usuwać duże pliki na stałe), daj znać — przygotuję instrukcję z `git-filter-repo` / BFG oraz listę plików do usunięcia.

Plik ten jest dokumentacją operacji porządkowych i powinien pozostać w repo.

— Zmiany wykonane automatycznie przez skrypt porządkowy
