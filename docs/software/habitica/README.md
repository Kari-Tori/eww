# Habitica — API i integracje

- Strona: https://habitica.com/
- Dev docs (API): https://habitica.com/apidoc/
- Wiki: https://github.com/HabitRPG/habitica/wiki
- Autoryzacja: nagłówki `x-api-user: <USER_ID>` i `x-api-key: <API_TOKEN>`.
- Modele: `tasks` (todo/daily/habit/reward), `user`, `groups`, `webhooks`.
- Zastosowanie: lustrzany frontend mobilny (questy/fantasy) dla zadań z repo; stan synchronizowany.

### Przykład: pobranie zadań TODO
```bash
curl -H "x-api-user: $HAB_USER" \
     -H "x-api-key: $HAB_TOKEN" \
     https://habitica.com/api/v3/tasks/user?type=todo
```

