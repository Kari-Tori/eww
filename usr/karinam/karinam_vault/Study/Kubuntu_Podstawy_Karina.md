---
created: "{{date:DD-MM-YYYY}}"
folder: "{{folder}}"
id: "{{date:DD-MM-YYYY(HH:mm)}}-{{title}}"
modified: "{{date:DD-MM-YYYY}}"
status: draft
tags: []
title: "{{title}}"
type: note
aliases: [🐧 Kubuntu 24.04 LTS – Podstawy dla Kariny]
linter-yaml-title-alias: 🐧 Kubuntu 24.04 LTS – Podstawy dla Kariny
date created: niedziela, sierpień 10. 2025, 2:38:52 am
date modified: środa, sierpień 13. 2025, 1:09:06 am
---

# 🐧 Kubuntu 24.04 LTS – Podstawy dla Kariny

## 🧠 Czym jest Kubuntu?

**Kubuntu** to oficjalna dystrybucja systemu Ubuntu, która wykorzystuje środowisko graficzne **KDE Plasma** zamiast GNOME. Jest to system szybki, stabilny i przyjazny dla użytkownika, oferujący szerokie możliwości personalizacji.

- **Wersja systemu**: Kubuntu 24.04 LTS „Noble Numbat”
- **Data wydania**: 25 kwietnia 2024
- **Wsparcie LTS**: do kwietnia 2027
- **Środowisko graficzne**: KDE Plasma 5.27.11 LTS
- **Jądro systemu**: Linux 6.8
- **Menadżer pakietów**: APT (z GUI: Discover)

## 💻 Czym jest KDE i Plasma?

- **KDE** to społeczność oraz zestaw aplikacji open-source rozwijanych dla systemów Linux.
- **Plasma** to środowisko graficzne (shell), które odpowiada za interfejs użytkownika: pasek zadań, menu, pulpity, okna itp.
- **KDE Plasma 5.27.11 LTS** to stabilna wersja środowiska graficznego, oferująca nowoczesny wygląd i szerokie możliwości konfiguracji.

Więcej informacji:
- [KDE Plasma – oficjalna strona](https://kde.org/pl/plasma-desktop/)
- [Kubuntu – oficjalna strona](https://kubuntu.org/)

---

## ⌨️ Podstawowe skróty klawiaturowe

| Skrót                     | Działanie                             |
|---------------------------|----------------------------------------|
| `Ctrl + Alt + T`          | 🔲 Otwórz terminal                     |
| `Meta (Windows) + Space`  | 🌍 Przełącz układ klawiatury (język)   |
| `Alt + Tab`               | 🔁 Przełącz między otwartymi oknami    |
| `Meta (Windows)`          | 🏁 Otwórz menu start (Kickoff)         |
| `Meta + D`                | 🧼 Pokaż pulpit                        |
| `Meta + E`                | 🗂️ Otwórz menedżer plików (Dolphin)    |
| `PrtSc`                   | 📸 Wykonaj zrzut ekranu                |

---

## 🖥️ Terminal – podstawowe komendy

Terminal to narzędzie do wprowadzania poleceń tekstowych. Oto kilka podstawowych komend:

```bash
# 🔄 Aktualizacja systemu
sudo apt update && sudo apt upgrade

# 📥 Instalacja programu
sudo apt install NAZWA_PROGRAMU

# 📁 Przeglądanie folderów
ls          # wyświetl pliki i foldery
cd NAZWA    # wejdź do folderu
cd ..       # wróć do folderu nadrzędnego

# ➕ Tworzenie folderu
mkdir NAZWA_FOLDERU

# ❌ Usuwanie
rm PLIK          # usuń plik
rm -r FOLDER     # usuń folder i jego zawartość

# 🧹 Czyszczenie terminala
clear
```

---

## 🔧 Polecane programy do zainstalowania

```bash
# Przeglądarka internetowa
sudo apt install firefox

# Pakiet biurowy
sudo apt install libreoffice

# Program do montażu wideo
sudo apt install kdenlive

# Odtwarzacz multimedialny
sudo apt install vlc

# Edytor tekstu z obsługą Markdown
sudo apt install kate

# Narzędzie do zrzutów ekranu
sudo apt install spectacle
```

---

## 🧭 Przydatne linki

- [Forum Kubuntu (EN)](https://ubuntuforums.org/forumdisplay.php?f=334)
- [KDE Discover – Centrum oprogramowania](https://apps.kde.org/)
- [KDE Store – Motywy i dodatki](https://store.kde.org/)
- [Terminal – Podstawowe komendy](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)

---

## 🤝 Potrzebujesz pomocy?

- Skontaktuj się z **Jakubem** (czyli mną!)
- Skorzystaj z Centrum Pomocy w systemie (`Meta` → wpisz "Pomoc")
- Przeszukaj forum [AskUbuntu](https://askubuntu.com/)

---

> 📄 Ten plik możesz edytować w Obsidianie lub dowolnym edytorze tekstu.