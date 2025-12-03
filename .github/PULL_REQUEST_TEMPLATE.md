---
version: 0.0.6
title: "PULL_REQUEST_TEMPLATE"
created: 2025-11-26
modified: 2025-11-28
tags:
  - auto-versioned
---

## Opis zmian

<!-- Krótki opis co zostało zmienione i dlaczego -->

## Typ zmian

- [ ] 🐛 Bug fix (naprawa błędu)
- [ ] ✨ New feature (nowa funkcja)
- [ ] 💥 Breaking change (zmiana łamiąca kompatybilność)
- [ ] 📝 Documentation update (dokumentacja)
- [ ] 🧹 Code cleanup / refactoring (refaktoryzacja)
- [ ] 🔧 Configuration change (konfiguracja)

## Checklist (WYMAGANE)

### Konfiguracja wersjonowania ⚠️ OBOWIĄZKOWE

- [ ] ✅ Zainstalowano Git hooks (`make install-hooks`)
- [ ] ✅ Przeczytano [`docs/setup/onboarding.md`](../docs/setup/onboarding.md)
- [ ] ✅ Sprawdzono spójność wersji (`make check-versions`)
- [ ] ✅ Wszystkie pliki `.md` mają frontmatter z `version`

### Jakość kodu

- [ ] Kod zgodny z konwencjami projektu (bash style, naming)
- [ ] Dodane testy (jeśli dotyczy)
- [ ] Uruchomione `shellcheck` i naprawione błędy
- [ ] Zaktualizowana dokumentacja (jeśli dotyczy)
- [ ] Commity w formacie Conventional Commits (`feat:`, `fix:`, `docs:`)
- [ ] Kod i komentarze **po polsku**

### Weryfikacja

- [ ] CI/CD przechodzi bez błędów
- [ ] Lokalnie przetestowano zmiany
- [ ] Brak konfliktów z `main`

## Testy

<!-- Opisz jak przetestowano zmiany -->

```bash
# Przykładowe komendy testowe
bats tests/
make check-versions
./bin/eww-setup
```

## Screenshots / Logi (jeśli dotyczy)

<!-- Wklej screenshot lub przykładowy output -->

## Powiązane Issues

Closes #
Relates to #

## Dodatkowy kontekst

<!-- Dodatkowe informacje dla reviewera -->

---

**Przypomnienie:** Przed push upewnij się, że pre-commit hook działa:

```bash
git config core.hooksPath  # Powinno zwrócić: .githooks
semver --version           # Powinno zwrócić wersję semver
```

**Workflow:** Nairecth/eww → lokalnie → Kari-Tori/eww → PR → Nairecth/eww

## 🔗 Backlinks

- [[INDEX]]
- [[.github]]
- [[README]]

