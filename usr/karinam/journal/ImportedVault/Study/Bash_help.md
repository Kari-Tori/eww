---
aliases: [🐚 Bash Help – Podstawy terminala dla Kariny]
linter-yaml-title-alias: 🐚 Bash Help – Podstawy terminala dla Kariny
date created: niedziela, sierpień 10. 2025, 2:39:53 am
date modified: środa, sierpień 13. 2025, 1:09:08 am
---

# 🐚 Bash Help – Podstawy terminala dla Kariny

Ten plik to **szybka ściąga** do terminala na Kubuntu.  
Pomaga zrozumieć, co wpisać i co to robi.

---

## 🧍 Kim jestem?

```bash
whoami
```
→ Pokazuje Twoją nazwę użytkownika w systemie.

---

## 📂 Gdzie jestem?

```bash
pwd
```
→ Pokazuje, w jakim folderze (katalogu) aktualnie jesteś.

---

## 📦 Co tu jest?

```bash
ls
```
→ Lista plików i folderów w bieżącym katalogu.

---

## 🧭 Przemieszczanie się po systemie

```bash
cd NAZWA_FOLDERU
```
→ Wejdź do folderu `NAZWA_FOLDERU`

```bash
cd ..
```
→ Wróć o jeden folder wyżej

```bash
cd ~
```
→ Wróć do folderu domowego (np. `/home/karina`)

---

## 🧹 Czyść terminal

```bash
clear
```
→ Wyczyść ekran terminala (nie usuwa danych – tylko „odświeża” widok).

---

## 🔍 Sprawdź informacje o systemie

```bash
uname -a
```
→ Informacje o systemie (wersja jądra, nazwa systemu, itd.)

---

## 💽 Ile mam miejsca?

```bash
df -h
```
→ Pokaż ile masz wolnego miejsca na dyskach.

---

## 🧪 Przykład: prosty skrypt

Zapisz poniższe do pliku `moja_pozycja.sh`:

```bash
#!/bin/bash
echo "Użytkownik: $(whoami)"
echo "Jesteś w: $(pwd)"
echo "Tu znajdują się:"
ls
```

A potem:

```bash
chmod +x moja_pozycja.sh
./moja_pozycja.sh
```

---

> 🧠 TIP: Terminal nie gryzie. To po prostu szybki sposób rozmowy z komputerem.
