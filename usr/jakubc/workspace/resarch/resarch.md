---
title: resarch/ – folder note
created: 2025-11-21
description: Instrukcja pracy w katalogu badań hybrydowego workspace
language: pl
updated: 2025-11-21
color: blue
---

# resarch/ – notatka katalogu

Katalog `usr/jakubc/workspace/resarch/` gromadzi całą dokumentację R&D: listy narzędzi, koszty, eksperymenty agentów i logi porównawcze. Poniższa notatka zastępuje dawny `README.md` – szczegółowe tematy opisuje teraz plik [`resarch_topics.md`](resarch_topics.md).

## Co już mamy
- **`resarch_topics.md`** – główny katalog tematów badawczych: platformy AI, IDE, agenci, koszty, glosariusz.
- **`resarch.md` (ten plik)** – folder note z instrukcją, jak organizujemy eksperymenty i gdzie odkładać wyniki.
- **Dowolne dodatkowe pliki** – każdy eksperyment lub raport zapisujemy jako osobny plik Markdown w tym folderze lub w podkatalogach.

## Jak dodawać eksperyment
1. Utwórz plik `YYYY-MM-DD-nazwa-eksperymentu.md` (albo podkatalog, jeśli to większa seria).
2. Na początku umieść krótki opis celu, użytych modeli/narzędzi oraz status (np. ✅ gotowe, ⏳ w toku).
3. Po zakończeniu eksperymentu dopisz wnioski do `resarch_topics.md` (np. w sekcji IDE/Agenci) i zalinkuj nowy plik w odpowiednim miejscu.
4. Jeżeli eksperyment skutkuje zmianami w workspace, zarejestruj zadanie lub wynik w `tools_status.md`.

## Konwencje
- Komentarze i treść piszemy po polsku.
- Pliki nazywamy małymi literami, używając myślników.
- W raportach kosztów stosujemy walutę GBP (zgodnie z `resarch_topics.md`).

## Następne kroki
- Przejrzeć `resarch_topics.md` i zidentyfikować sekcje wymagające aktualizacji na podstawie najnowszych eksperymentów.
- Dodać kolejne folder notes (np. dla podkategorii „ide/”, „agents/”), jeśli eksperymentów będzie więcej.


## 🔗 Powiązane dokumenty

- [[usr/jakubc/workspace/resarch/resarch|resarch]]
- [[usr/jakubc/workspace/workspace|workspace]]
- [[usr/jakubc/jakubc|jakubc]]

---
**Auto-linked:** 2025-11-21
