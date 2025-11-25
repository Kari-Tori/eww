---
aliases: [🐚 Bash Scripts – Podstawy]
linter-yaml-title-alias: 🐚 Bash Scripts – Podstawy
date created: niedziela, sierpień 10. 2025, 2:40:14 am
date modified: środa, sierpień 13. 2025, 2:19:36 am
---

# 🐚 Bash Scripts – Podstawy

Ten plik zawiera podstawowe informacje o **skryptach Bash** – jak je pisać, uruchamiać i do czego służą. Idealne dla początkujących użytkowników Linuxa, 

---

## 📄 Co to jest skrypt Bash?

Skrypt Bash to plik tekstowy zawierający polecenia, które normalnie wpisywalibyśmy w terminalu – ale zapisane na stałe, by je automatyzować.

Plik musi zaczynać się od tzw. shebanga:

```bash
#!/bin/bash
```

---

## ✍️ Przykład prostego skryptu

```bash
#!/bin/bash

echo "Cześć, Karino!"
echo "Dzisiaj jest: $(date)"
```

Zapisz to jako `karina.sh`, a potem:

```bash
chmod +x karina.sh   # nadaj uprawnienia do uruchomienia
./karina.sh          # uruchom skrypt
```

---

## 🧰 Podstawowe składniki skryptu

- `echo` – wypisz tekst
- `#` – komentarz
- `$(komenda)` – uruchom komendę w tle i wstaw wynik
- `read` – pobierz dane od użytkownika
- `if`, `else`, `fi` – instrukcja warunkowa
- `for`, `while` – pętle

---

## 🧪 Przykład z warunkiem

```bash
#!/bin/bash

read -p "Podaj swoje imię: " imie

if [ "$imie" == "Karina" ]; then
    echo "Witaj, Karino!"
else
    echo "Cześć, $imie!"
fi
```

---

## 🔁 Pętla `for`

```bash
#!/bin/bash

for i in {1..5}; do
    echo "Liczba: $i"
done
```

---

## 📂 Automatyzacja zadań

Skrypty Bash są często używane do:

- aktualizacji systemu
- tworzenia kopii zapasowych
- instalacji programów
- przetwarzania plików

---

## 📌 Przydatne komendy w skryptach

```bash
sudo apt update && sudo apt upgrade
cp plik1.txt backup/
mv *.jpg Zdjecia/
rm -r folder
```

---

## 🧠 Rada

Zawsze testuj skrypt **na sucho** – np. dodając `echo` przed komendami lub pracując na kopiach plików.

---

> 📄 Ten plik możesz edytować w Obsidianie lub innym edytorze.  
> Skrypty zapisuj z końcówką `.sh` i wykonuj przez terminal.
