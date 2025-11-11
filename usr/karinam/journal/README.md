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

---

## Automatyczne tworzenie pliku dziennego (autocreate)

W katalogu znajduje się skrypt, który tworzy plik dziennika na dziś z szablonu gdy go brak:

- `usr/karinam/journal/bin/create-today.sh`

Przykłady użycia:

```bash
# utwórz plik dnia (nie otwiera)
usr/karinam/journal/bin/create-today.sh

# utwórz i spróbuj otworzyć (wykorzystuje xdg-open)
usr/karinam/journal/bin/create-today.sh --open
```

Autostart (opcjonalny)

Przykładowy plik `.desktop` znajduje się w repo i możesz go skopiować do `~/.config/autostart/` aby uruchamiać skrypt przy logowaniu:

- `usr/karinam/journal/systemd/eww-journal-autostart.desktop`

Jeśli chcesz, żeby plik otwierał się bezpośrednio w Obsidian, zmodyfikuj `Exec=` w pliku .desktop lub użyj Obsidian URI:

```
Exec=xdg-open "obsidian://open?vault=NAZWA_VAULTU&file=Daily%2Fdaily-YYYY-MM-DD.md"
```

Zastąp `NAZWA_VAULTU` nazwą swojego vaulta.

---

## Templater-friendly variant

Jeśli używasz pluginu Templater, skorzystaj z gotowego szablonu:

- `usr/karinam/journal/Templates/daily-templater.md`

W Obsidianie możesz użyć QuickAdd lub "Insert template" -> wybierz powyższy plik. Templater uzupełni datę i godzinę automatycznie.

---

## Przykładowe zapytania Dataview

Poniżej dwa przykłady, które możesz wkleić do notatki, aby zobaczyć statystyki lub przegląd.

1) Tygodniowy przegląd ostatnich 14 dni (lista plików):

```dataview
table file.name as "Dzień", file.cday as "Utworzono"
from "usr/karinam/journal/Daily"
where contains(tags, "#journal/daily")
sort file.cday desc
limit 14
```

2) Prosty tracker nawyków (DataviewJS) — zlicza wystąpienia ukończonego zadania zawierającego słowo "Medytacja":

```dataviewjs
const pages = dv.pages('"usr/karinam/journal/Daily"');
let count = 0;
for (let p of pages) {
	if (!p.file.tasks) continue;
	for (let t of p.file.tasks) {
		if (t.text && t.text.toLowerCase().includes('medytacja') && t.completed) count++;
	}
}
dv.paragraph('Medytacja ukończona ' + count + ' razy');
```

---

## Styl i wygląd

Możesz skorzystać z prostego snippetu CSS: `usr/karinam/journal/obsidian.css` — skopiuj go do `/.obsidian/snippets/` w Twoim vault i włącz w Obsidian -> Appearance -> CSS snippets.

Jeśli chcesz, mogę też dodać QuickAdd snippet lub instrukcję jak ustawić Templater + Dataview dla automatycznych podsumowań tygodniowych.

## Autocreate, autostart i szybkie polecenia

Utworzyłem kilka helperów, żeby rano mieć gotowy dziennik bez ręcznego kopiowania:

- `usr/karinam/journal/bin/create-today.sh` — skrypt Bash, który tworzy plik na dziś z szablonu (prefers `daily-templater.md` jeśli istnieje). Opcje:
	- `--open` — spróbuje otworzyć plik (xdg-open lub Obsidian URI gdy podasz nazwę vaulta)
	- `--vault NAZWA` — jeśli chcesz otworzyć bezpośrednio w Obsidian przez obsidian://open

Przykłady:

```bash
# tworzy plik dnia (nie otwiera)
usr/karinam/journal/bin/create-today.sh

# tworzy i otwiera (xdg-open lub obsidian:// jeśli podasz --vault)
usr/karinam/journal/bin/create-today.sh --open --vault "eww"
```

Autostart: przykład pliku .desktop znajdziesz tutaj:

- `usr/karinam/journal/systemd/eww-journal-autostart.desktop`

Instalacja (szybki sposób):

```bash
# skopiuj do autostartu użytkownika
mkdir -p ~/.config/autostart
cp usr/karinam/journal/systemd/eww-journal-autostart.desktop ~/.config/autostart/

# upewnij się, że skrypt jest wykonalny:
chmod +x usr/karinam/journal/bin/create-today.sh
```

Jeśli chcesz, aby plik otwierał się bezpośrednio w Obsidian, edytuj linię Exec w pliku .desktop i dodaj `--vault "NAZWA_VAULTU"` lub użyj Obsidian URI bezpośrednio:

```
Exec=xdg-open "obsidian://open?vault=NAZWA_VAULTU&file=Daily%2Fdaily-$(date +%Y-%m-%d).md"
```

## QuickAdd / Templater

Jeśli korzystasz z pluginu Templater, użyj `Templates/daily-templater.md` i stwórz QuickAdd action, która wklei szablon i otworzy go. Przykładowy krok QuickAdd: "Insert template" -> wybierz `usr/karinam/journal/Templates/daily-templater.md`.

## Snippety CSS

Prosty snippet `usr/karinam/journal/obsidian.css` znajduje się w repo — skopiuj go do `/.obsidian/snippets/` w vault i włącz w Appearance -> CSS snippets.

---

Jeśli chcesz, mogę teraz: 1) dodać QuickAdd JSON/konfigurację, 2) uczynić skrypt bardziej rozbudowanym (np. logowanie, backup), lub 3) od razu zainstalować plik .desktop do `~/.config/autostart/` (tylko na Twoim maszynie). Napisz którą opcję wybierasz.
