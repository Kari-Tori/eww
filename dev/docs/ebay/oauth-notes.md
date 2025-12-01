---
tags:
  - #docs
  - #ebay
  - #oauth
  - #howto
created: 2025-11-29T12:25:00Z
modified: 2025-11-29T12:25:00Z
title: "eBay OAuth – notatki wdrożeniowe"
owner: ai
---

# eBay OAuth – notatki wdrożeniowe

## Środowiska i scope
- `SANDBOX` → endpoint `api.sandbox.ebay.com`, `PRODUCTION` → `api.ebay.com`.
- Tokeny aplikacyjne wymagają zwykle minimalnego scope, tokeny użytkownika muszą mieć konkretne scope z listy `https://developer.ebay.com/api-docs/static/oauth-scopes.html`.
- Redirect URI musi być identyczne z wartością (RUName) skonfigurowaną w portalu deweloperskim.

## Node.js (ebay-oauth-nodejs-client)
1. Instalacja: `npm install ebay-oauth-nodejs-client`.
2. Przykład:
```js
const EbayAuthToken = require('ebay-oauth-nodejs-client');

const ebayAuthToken = new EbayAuthToken({
  clientId: process.env.EBAY_CLIENT_ID,
  clientSecret: process.env.EBAY_CLIENT_SECRET,
  redirectUri: process.env.EBAY_REDIRECT_URI // nazwa z portalu
});

// token aplikacyjny (client_credentials)
const { access_token } = await ebayAuthToken.getApplicationToken('SANDBOX');

// link do zgody użytkownika
const scopes = ['https://api.ebay.com/oauth/api_scope/sell.inventory'];
const authUrl = ebayAuthToken.generateUserAuthorizationUrl('SANDBOX', scopes, { state: 'eww-demo' });

// wymiana code -> access+refresh
const tokens = await ebayAuthToken.exchangeCodeForAccessToken('SANDBOX', code);

// odświeżanie tokenu użytkownika
const refreshed = await ebayAuthToken.getAccessToken('SANDBOX', tokens.refresh_token, scopes);
```
3. Scopes pozostają w domenie `api.ebay.com` także dla sandbox; środowisko wybiera się parametrem `SANDBOX`/`PRODUCTION`.

## Python (ebay-oauth-python-client)
1. `pip install -r requirements.txt` z repo lub dodaj paczkę do projektu.
2. Minimalny szablon:
```python
from oauthclient.credentialutil import credentialutil
from oauthclient.oauth2api import oauth2api
from oauthclient.model.model import environment

credentialutil.load("ebay-config.yaml")  # lub .json; appid/devid/certid/redirecturi

oauth_api = oauth2api()

# token aplikacyjny
app_token = oauth_api.get_application_token(environment.SANDBOX, ["https://api.ebay.com/oauth/api_scope"])

# URL do zgody użytkownika
scopes = ["https://api.ebay.com/oauth/api_scope/sell.inventory"]
auth_url = oauth_api.generate_user_authorization_url(environment.SANDBOX, scopes, state="eww-demo")

# wymiana code -> access+refresh
user_tokens = oauth_api.exchange_code_for_access_token(environment.SANDBOX, code)

# odświeżanie
refreshed = oauth_api.get_access_token(environment.SANDBOX, user_tokens.refresh_token, scopes)
```
3. Przykładowy plik konfiguracyjny (`ebay-config-sample.yaml` w repo) musi zawierać sekcje `sandbox` i `production` z `appid`, `devid`, `certid`, `redirecturi`.

## Checklist operacyjny
- Zweryfikuj, że RUName w portalu == `redirectUri` w SDK.
- Ustal minimalny zestaw scope potrzebny do danej API, by nie prosić o zbędne uprawnienia.
- Tokeny zapisuj z czasem wygaśnięcia i wykonuj odświeżanie na cronie lub przy 401.
- Sandbox ma inne konta użytkowników niż produkcja; testowe konta utwórz osobno.
