---
tags:
  - index
  - karinam
  - pink
  - candy
created: 2025-11-21
author: karinam
color: pink
---

# 🩷 INDEX - Karinam

> **Główny indeks przestrzeni Karinam**

## 👤 Profil
[[usr/karinam/karinam|🩷 Karinam Profile]]

## 📁 Foldery

### Główne
- [[usr/karinam/Inbox/Inbox|📥 Inbox]] - szybkie notatki
- [[usr/karinam/projects/projects|🚀 Projects]] - projekty
- [[usr/karinam/notes/notes|📝 Notes]] - notatki
- [[usr/karinam/health/health|💪 Health]] - zdrowie

## 📊 Statystyki

```dataview
TABLE file.ctime as "Utworzono", file.tags as "Tagi"
FROM "usr/karinam"
WHERE file.name != "INDEX" AND file.name != "karinam"
SORT file.ctime DESC
LIMIT 20
```

## 🔗 Grafy
- [[GRAPH-KARINAM]] - Graf osobisty
- [[GRAPH-USERS]] - Wszyscy użytkownicy

---

*Ostatnia aktualizacja: 2025-11-21*
