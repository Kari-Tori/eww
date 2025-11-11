# Obsidian Journal (lokalny) — Karina

Ten katalog służy jako lokalny vault Obsidiana z prostym, personalnym dziennikiem.

Główne elementy wpisu dziennego (szablon):

- Nazwa dnia (np. "Wtorek")
- Data (YYYY-MM-DD)
- StartTime — godzina, o której włączyłaś komputer
- Opis dnia — miejsce na osobiste notatki i refleksje
- Zdjęcia / Załączniki — katalog `Attachments/` do przechowywania obrazów, w Obsidianie wstawiaj je jako `![[Attachments/nazwa.jpg]]`

Struktura katalogu:

- `Templates/` — szablony (np. `daily.md`)
- `Daily/` — pliki dzienne (np. `daily-2025-11-11.md`)
- `Attachments/` — zdjęcia i pliki do osadzenia w notatkach

Jak korzystać (szybko):

1. Otwórz ten folder jako vault w Obsidian (File → Open folder as vault).
2. Skopiuj `Templates/daily.md` do `Daily/daily-YYYY-MM-DD.md` i uzupełnij pola:
	- `StartTime:` wpisz godzinę uruchomienia komputera
	- W sekcji **Opis dnia** wpisz swoje notatki
	- Dodaj obrazy do `Attachments/` i osadź je w treści za pomocą `![[Attachments/nazwa.jpg]]`

Obsidan URI (przykład):

`obsidian://open?vault=eww&file=usr%2Fkarinam%2Fjournal%2FDaily%2Fdaily-2025-11-11`

Autostart (opcjonalny):

Utwórz plik `~/.config/autostart/obsidian-daily.desktop` z zawartością:

```
[Desktop Entry]
Type=Application
Name=Obsidian Daily
Exec=xdg-open "obsidian://open?vault=eww&file=Daily%2Fdaily-$(date +%Y-%m-%d)"
Terminal=false
Hidden=false
```

Uwaga: upewnij się, że nazwa vault w URI (tutaj `eww`) odpowiada nazwie twojego vaulta w Obsidianie.

Jeśli chcesz, mogę dodać skrypt, który automatycznie stworzy dzienny plik z szablonu przy pierwszym otwarciu dnia — napisz "autocreate".
