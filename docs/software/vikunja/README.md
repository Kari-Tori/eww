---
version: 0.0.1
title: "README"
created: 2025-11-29
modified: 2025-11-29
tags:
  - auto-versioned
---

# Vikunja — notatki i zadania

- Strona: https://vikunja.io/
- Dokumentacja: https://vikunja.io/docs/
- API: https://try.vikunja.io/api/v1 (spec OpenAPI wbudowana w instancje)
- Repozytorium: https://code.vikunja.io/
- Klient web/mobile: progressive web app, dostępny z przeglądarki mobilnej.
- Instalacja serwera: Docker `vikunja/api` + `vikunja/frontend` (patrz docs → setup → docker-compose).
- Autoryzacja API: token (Bearer) lub basic (login+hasło); większość integracji używa tokenów.
- Struktura: Namespace → Project → Task (zadanie) → Subtask/Label/Attachment.

### Przykład zapytania (API)
```bash
curl -H "Authorization: Bearer $VIKUNJA_TOKEN" \
  https://vikunja.example/api/v1/projects
```

## 🔗 Backlinks

- [[docs/software/vikunja/vikunja]]
- [[docs/docs]]
- [[INDEX]]