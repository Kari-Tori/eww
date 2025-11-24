---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T13:00:00Z
modified: 2025-11-22T09:50:25Z
author: jakubc
title: "✅ TODO"






owner: jakubc
---

# ✅ TODO

> [!todo] 🗂️ Karty zadań · Code/System/Obsidian
- [ ] [[TODO-gerc-boot|GERC Boot Autostart]] — dopracować wzorcową kartę i wdrożyć autostart zgodnie z YAML (VS Code + system + Obsidian Tasks/Dataview).
- [ ] Utworzyć `usr/jakubc/templates/task-card.md` bazujący na sekcji 7 karty, żeby VS Code i Obsidian mogły szybko generować nowe zadania.
- [ ] Uzupełnić `eww.code-workspace` o pole `tasks` powiązane z Obsidian Tasks (wspólne statusy/priorytety).
- [ ] Dodać zapytanie Dataview do `TODO.md`, które listuje wszystkie notatki z `task_card: true` (kontrola kart w Obsidianie).

```dataview
TABLE status, priority, file.mtime AS modified
FROM "usr/jakubc"
WHERE task_card = true
SORT priority ASC, file.mtime DESC
```

> [!todo] 🧠 Secondbrain · AppFlowy i migracja
- [x] 📦 Zainstalować AppFlowy na dedykowanej maszynie lub VM
- [ ] 🗂️ Utworzyć przestrzeń „Secondbrain-Pilot”
- [ ] 🧷 Snapshot vaulta Obsidian Git i archiwum
- [ ] 📤 Wyeksportować 50–100 notatek MD z Obsidiana
- [ ] 📥 Zaimportować próbkę do AppFlowy i sprawdzić nagłówki linki obrazy
- [ ] 🧭 Ustalić model pracy hybryda lub pełna migracja
- [ ] 🛡️ Przygotować SOP migracji i backup AppFlowy do MD lub CSV
- [ ] 🔄 Skonfigurować n8n przepływy MD → AppFlowy oraz AppFlowy → MD CSV

> [!todo] 🏢 Biznes · Odoo ↔ eBay integracja wsteczna
- [ ] 🧾 Potwierdzić wersję Odoo CE i środowisko TEST
- [ ] 🔑 Uzyskać klucze eBay Developer App ID Dev ID Cert ID token
- [ ] 🔌 Wybrać konektor OCA komercyjny lub własny
- [ ] ⚙️ Skonfigurować import eBay → Odoo zamówienia stany ceny
- [ ] 🧪 Przetestować na wydzielonych listingach i zweryfikować spójność stanów
- [ ] 📈 Włączyć logi retry oraz alerty błędów
- [ ] 📚 Spisać SOP Obsługa zamówień eBay w Odoo
- [ ] 📊 Ustalić KPI i przegląd po 14 dniach

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
e 
