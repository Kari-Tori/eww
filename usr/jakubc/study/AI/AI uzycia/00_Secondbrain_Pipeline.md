---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "Secondbrain Pipeline"






owner: jakubc
---

# Secondbrain Pipeline

## Cel
Stała normalizacja i indeksowanie wiedzy tak aby AI i człowiek mieli jedno źródło prawdy.

## Etapy przetwarzania

1. Linter
   - Normalizacja formatu notatek Markdown i sekcji YAML.

2. YAML
   - Utrzymanie metadanych notatki. Status. Priorytet. Lokalizacja. Właściciel.

3. Parser
   - Rozbicie notatki na pola techniczne.
   - Ekstrakcja tagów, identyfikatorów sprzętu, IP, powiązań.

4. Indexowanie
   - Aktualizacja globalnej bazy wyszukiwania.
   - Dwa indeksy: metadane i pełny tekst.

5. Embeddings
   - Zamiana treści na wektory semantyczne.

6. Vectorowanie
   - Zapis wektorów w bazie wektorowej do wyszukiwania podobieństwa.

7. Autotagowanie
   - AI uzupełnia tagi i pola YAML. Wyrównuje status procesu.

## Przepływ danych

Notatka markdown -> Linter -> YAML ustalony -> Parser -> Index -> Embeddings -> Baza wektorowa -> Autotagowanie -> Aktualizacja YAML.

## Wymagania systemowe
- Lokalnie. Brak chmury.
- Każdy użytkownik ma swój węzeł Secondbrain.
- Wersjonowanie zmian w git.
- Wektory i indeks pełnotekstowy wystawione jako usługa API dla reszty systemu.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
