---
title: Security Policy
description: Polityka bezpieczeństwa i zgłaszanie podatności
tags:
  - security
  - vulnerability
  - policy
language: pl
---

# Polityka bezpieczeństwa

## 🔒 Wspierane wersje

Aktualnie wspieramy bezpieczeństwo następujących wersji projektu:

| Wersja | Wsparcie           |
| ------ | ------------------ |
| 0.0.x  | :white_check_mark: |
| < 0.0  | :x:                |

## 🐛 Zgłaszanie podatności

Jeśli odkryjesz lukę w zabezpieczeniach, **NIE** twórz publicznego issue na GitHubie.

### Jak zgłosić

1. **Email**: Wyślij szczegóły na **astriblast@gmail.com** z tematem: `[SECURITY] Opis podatności`

2. **Zawartość zgłoszenia**:
   - Opis podatności
   - Kroki reprodukcji
   - Potencjalny wpływ
   - Propozycja rozwiązania (opcjonalnie)
   - Twoje dane kontaktowe (do followup)

3. **Odpowiedź**: Otrzymasz odpowiedź w ciągu **72 godzin**

### Proces obsługi

1. ✅ **Potwierdzenie** - potwierdzamy otrzymanie zgłoszenia
2. 🔍 **Weryfikacja** - badamy zgłoszoną podatność
3. 🛠️ **Naprawa** - opracowujemy i testujemy patch
4. 📢 **Publikacja** - publikujemy poprawkę i security advisory
5. 🙏 **Uznanie** - dodajemy Cię do listy security researchers (jeśli chcesz)

### Timeline

- **Potwierdzenie**: 72 godziny
- **Pierwsza ocena**: 7 dni
- **Patch (krytyczny)**: 14-30 dni
- **Patch (średni/niski)**: 30-90 dni

## 🔐 Best practices dla użytkowników

### Bezpieczne używanie skryptów

```bash
# Zawsze sprawdzaj źródło przed uruchomieniem
cat script.sh | less

# Nie używaj curl | bash bez inspekcji
# Zamiast tego:
curl -O https://example.com/script.sh
less script.sh
bash script.sh

# Używaj weryfikacji GPG dla pobranych plików
gpg --verify file.sig file
```

### Zmienne środowiskowe

```bash
# Nigdy nie commituj sekretów
# Użyj .env i dodaj do .gitignore
echo "SECRET_KEY=xxx" >> .env
echo ".env" >> .gitignore

# W skryptach sprawdzaj obecność zmiennych
: "${SECRET_KEY:?SECRET_KEY not set}"
```

### Uprawnienia plików

```bash
# Ogranicz uprawnienia do skryptów
chmod 750 scripts/*.sh

# Sprawdź uprawnienia przed wykonaniem
stat -c "%a %n" script.sh
```

## 🛡️ Bezpieczeństwo zależności

Projekt używa głównie **Bash** i **core utils**, minimalizując zależności.

Jeśli dodajesz zależności:
- Sprawdź CVE w [GitHub Advisory Database](https://github.com/advisories)
- Używaj pinned versions
- Regularnie aktualizuj

## 📜 Polityka ujawniania

- **Responsible disclosure**: 90 dni od zgłoszenia do publicznej informacji
- **CVE**: Dla krytycznych podatności wystąpimy o CVE ID
- **Security Advisory**: Publikujemy na GitHubie: https://github.com/Nairecth/eww/security/advisories

## 🏆 Hall of Fame

Osoby, które odpowiedzialnie zgłosiły podatności:

*(Pusta lista - bądź pierwszy/a!)*

---

**Dziękujemy za pomoc w utrzymaniu bezpieczeństwa projektu! 🔐**
