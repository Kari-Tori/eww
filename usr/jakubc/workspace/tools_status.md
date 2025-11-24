---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "## Aktualny stan narzędzi"






owner: jakubc
---

## Aktualny stan narzędzi
Bloki poniżej wykorzystują callouty obsługiwane przez Obsidian – każdy z własnym emoji, kolorem statusu i krótkim opisem zastosowania.

> [!success] 💻 Code / VS Code — zainstalowany core
> [Strona projektu](https://code.visualstudio.com/)  \
> **Rola:** bazowe IDE (Integrated Development Environment) z konfiguracją workspace, terminalami i rozszerzeniami (Copilot, Continue, Codex CLI) spiętymi z repo `eww`.  \
> **Użycie:** stałe centrum dowodzenia – przełączanie widoków plików, uruchamianie poleceń, trzymanie notatek.

> [!info] 🤖 GitHub Copilot Pro — asystent terminala
> [Dokumentacja](https://docs.github.com/copilot)  \
> **Rola:** asystent terminala VS Code; dostarcza pair-programming, generacje kodu inline i szybkie komendy Chat/Continue dokładnie tam, gdzie pracujesz.  \
> **Użycie:** obsługuje zdecydowaną większość bieżących iteracji i automatyzuje małe kroki w kodzie.

> [!warning] 🛠️ Codex CLI (OpenAI Business) — agent zadaniowy
> [Kontekst operacyjny](AGENTS.md)  \
> **Rola:** agent zadaniowy; przejmuje prace wymagające pełnego kontekstu repo, planuje zmiany, edytuje pliki i pilnuje wzorców opisanych w `AGENTS.md`.  \
> **Użycie:** odpalany do większych patchy, aktualizacji dokumentacji i sekwencji poleceń z analizą repo.

## Co dalej
1. **Odtworzyć `notes/mvp-workflow.md`** – katalog `notes/` został usunięty, więc trzeba go przywrócić (z archiwum lub od zera) i spisać MVP Copilot + Codex.
2. **Przywrócić `notes/team-and-env.md`** – bez tego dokumentu nie mamy udokumentowanego podziału obowiązków Copilot vs Codex.
3. **Stworzyć `scripts/workspace-agent.sh`** – katalog `scripts/` również nie istnieje; minimalny router można tymczasowo wrzucić do `archive/` i przenieść po odtworzeniu struktury.
4. **Wznowić logi sesji** – do czasu powrotu `run-logs/` zapisuj logi w `archive/run-logs-YYYYMM.md`, z dopiskiem `Copilot`/`Codex`, aby zachować pomiary skuteczności.


## 🔗 Powiązane dokumenty

- [[usr/jakubc/workspace/workspace|workspace]]
- [[usr/jakubc/jakubc|jakubc]]
- [[docs/INDEX|INDEX]]

**Auto-linked:** 2025-11-21
