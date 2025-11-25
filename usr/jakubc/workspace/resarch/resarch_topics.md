---
title: Lista tematów badawczych (resarch_topics)
description: Snapshot wszystkich eksperymentowanych narzędzi i agentów w hybrydowym workspace
language: pl
updated: 2024-11-16
---

# Lista badań hybrydowego workspace

Ten plik zastępuje dawne `README.md` w katalogu `resarch/`. Służy jako żyjąca lista tematów badawczych (modele, narzędzia, konfiguracje) wykorzystywanych przy budowie lokalnego „Cursor-a”.

## Platformy i interfejsy AI
- 🌐 **OpenAI.** API Business z modelami GPT/Reasoning wykorzystywanymi w Continue/AG2. **Koszt:** usage-based ~£0.0023–£0.0117 za 1K tokenów (w zależności od modelu). [openai.com](https://openai.com)
- 💬 **ChatGPT.** Interfejs web/app do szybkich konsultacji i pisania kodu. **Koszt:** plan darmowy z limitem modeli; ChatGPT Plus £15.60/mies. (20 USD). [chat.openai.com](https://chat.openai.com)
- 🔍 **Google AI Studio (Gemini).** Środowisko testowe modeli Gemini z „free agents”. **Koszt:** darmowy tier z limitami; w produkcji usage-based per token (rozliczane na koncie Google Cloud). [makersuite.google.com](https://makersuite.google.com)
- 🌤️ **Claude Code.** Zapowiedziany agent kodowy Anthropic/Claude nastawiony na reasoning i refactoring. **Koszt:** spodziewany poziom jak Claude Pro/Team ~£15.60/mies. (20 USD) lub model usage-based. [claude.ai](https://claude.ai)

## IDE
- 🧠 **Cursor.** IDE z wbudowanym chatem/agentem działającym na repo; darmowa wersja daje kilkadziesiąt promptów dziennie + podstawowe inline completions, a plan Pro usuwa limity. **Koszt:** free tier z ograniczeniami, Pro ~£15.60/mies. [cursor.com](https://www.cursor.com)
- 🌊 **Windsurf.** Edytor/agent AI od Codeium (pair-programming, live diff, integracja z repo). **Koszt:** beta gratis; Codeium Pro planowany na ~£9–£16/mies. (12–20 USD). [codeium.com/windsurf](https://codeium.com/windsurf)
- 🧰 **Visual Studio Code.** Główne IDE w repo (rozszerzenia, terminal, debug, wsparcie dla Copilota/Continue). **Koszt:** darmowe (licencja MIT). [code.visualstudio.com](https://code.visualstudio.com)
- 🧰 **VSCodium.** VS Code bez telemetrii, kompatybilny z tymi samymi rozszerzeniami. **Koszt:** darmowe, open-source. [vscodium.com](https://vscodium.com)
- 🧩 **JetBrains IDE.** Pełna rodzina narzędzi (PyCharm, Fleet, Rider) do eksperymentów z integracją AI. **Koszt:** licencje od ok. £85/rok (99 EUR); All Products Pack ~£249/rok (289 EUR). [jetbrains.com](https://www.jetbrains.com)
  - 🐍 **PyCharm.** Community darmowy; Professional ~£171/rok (199 EUR).
  - 🚀 **Fleet.** Aktualnie preview (free); docelowo podobna subskrypcja jak pozostałe IDE JetBrains.
  - ⚙️ **Rider.** IDE .NET/Unity ~£128/rok (149 EUR) lub w pakiecie All Products.
- 🧪 **Neovim.** Modalny edytor z bogatymi pluginami AI (Codeium, Continue plugin) i wysoką konfigurowalnością. **Koszt:** darmowy; pluginy zwykle free/donation. [neovim.io](https://neovim.io)
- 💡 **Zed.** Lekki edytor nastawiony na kolaborację na żywo, ze wsparciem LLM i workspace’ów. **Koszt:** obecnie darmowy; płatne funkcje SaaS w zapowiedziach. [zed.dev](https://zed.dev)
- 🧬 **Inne eksperymentalne IDE.** Replit Ghostwriter IDE, Nova czy Emacs + AI pluginy – używamy jako inspiracji. **Koszt:** zależny od produktu; większość w wersjach beta/free lub TBD.

## Notatniki i aplikacje organizacyjne
- 🗂️ **Obsidian.** Lokalny system notatek Markdown z grafem powiązań, świetny do dokumentacji. **Koszt:** core free; Obsidian Sync ~£6.25/mies. (8 USD), Publish ~£12.50/mies. (16 USD). [obsidian.md](https://obsidian.md)
- 📒 **AppFlowy.** Open-source odpowiednik Notion (bazy danych, taski, widoki kanban). **Koszt:** Community Edition darmowa; płatny hosting w przygotowaniu. [appflowy.io](https://www.appflowy.io)

## Platformy systemowe i biznesowe
- 🐧 **Kubuntu.** Docelowy system devów (KDE + Ubuntu 24.04), zgodny z wymaganiami eww. **Koszt:** darmowy OS. [kubuntu.org](https://kubuntu.org)
- 🧾 **Odoo.** ERP/CRM open-source (sprzedaż, finanse, logistyka) planowany do integracji. **Koszt:** self-host free; Odoo Online od ~£21.50/użytk./mies. (25 EUR) + moduły. [odoo.com](https://www.odoo.com)
- 🛒 **eBay.** Kanał sprzedażowy/marketplace do obsługi klientów. **Koszt:** brak abonamentu; prowizje 5–15% + opcjonalne opłaty sklepu. [sellercentre.ebay.co.uk](https://sellercentre.ebay.co.uk)

## Agenci
- 🧬 **Codex**
  - Co daje: lokalny agent kodowy w VS Code, pracuje na repo eww zgodnie z ustalonymi regułami (Bash, dokumentacja, testy).
  - Koszt: brak licencji (open-source), ale lokalne wdrożenie może mieć ustalone limity zapytań/działań dziennie (np. aby chronić środowisko). Kontekst operacyjny: [AGENTS.md](../../../../AGENTS.md).
- 🤝 **Copilot**
  - Co daje: pair-programming (inline completions, chat) z integracją CLI i terminala, wspiera większość języków.
  - Koszt: ok. £7.80/mies. (Individual, 10 USD) lub £14.80/użytk./mies. (Business, 19 USD). [github.com/features/copilot](https://github.com/features/copilot)
- 🔁 **Continue**
  - Co daje: panel multi-LLM w VS Code, przełączanie profili (OpenRouter, Ollama, OpenAI), diff-y, kontekst pliku, zapisywanie wyników.
  - Koszt: open-source; płacimy tylko za użyte API. [continue.dev](https://continue.dev)
- ☁️ **OpenRouter agenci**
  - Co daje: router modeli chmurowych (Claude, GPT, Qwen) z wyborem najlepszego LLM pod zadanie (reasoning, kod, tłumaczenia).
  - Koszt: usage-based per token (np. Claude 3.5 ~£0.62/1M tokenów input i ~£6.20/1M output). [openrouter.ai](https://openrouter.ai)
- 🐻 **Ollama**
  - Co daje: lokalny agent (OpenAI-compatible API) dla modeli open-source, praca offline/poufna.
  - Koszt: aplikacja darmowa; koszty sprzętu + modele free. [ollama.com](https://ollama.com)
- 🧭 **AG2 / AutoGen**
  - Co daje: framework multi-agentowy (Supervisor, CoderCloud, CoderLocal, Tester, Human-in-the-loop), pozwala orkiestrującym pipeline’y „agenci + człowiek”.
  - Koszt: open-source; płacimy tylko za backendy LLM podpięte do agentów. [github.com/microsoft/autogen](https://github.com/microsoft/autogen)
- 🧩 **LangGraph**
  - Co daje: graph-based framework na bazie LangChain do składania agentów/nodów w uporządkowane przepływy z pamięcią i kontrolą stanu; przydatny przy łączeniu Copilota/Codexa w orkiestracje.
  - Koszt: biblioteka open-source; płacimy jedynie za modele/LLM użyte w węzłach (np. OpenAI, Anthropic). [langchain-ai.github.io/langgraph](https://langchain-ai.github.io/langgraph)

## Rodzaje interfejsów i słowniczek
- 🧠 **IDE (Integrated Development Environment)** – kompletne środowiska programistyczne zapewniające narzędzia (edytor, debuggery, integrację agentów).
- 🖥️ **GUI (Graphical User Interface)** – graficzna warstwa IDE, którą użytkownik widzi (okna VS Code, JetBrains).
- ⌨️ **CLI (Command Line Interface)** – terminalowe narzędzia (skrypty Bash, Makefile, AG2 run) spinające workspace z IDE.
- 🤖 **AI** – Artificial Intelligence (sztuczna inteligencja).
- 🔌 **API** – Application Programming Interface (interfejs programistyczny).
- 🧪 **R&D** – Research & Development (badania i rozwój).
- 🧷 **AG2** – AutoGen 2 (framework multi-agentowy od Microsoft/AGI).
- 🪟 **VS** – Visual Studio (w tym kontekście Visual Studio Code).
- 🚀 **MVP** – Minimum Viable Product (minimalny działający produkt).
