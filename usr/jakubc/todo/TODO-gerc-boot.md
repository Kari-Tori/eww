---
version: 0.0.1
tags:
  - #automation
  - #desktop
  - #eww
  - #jakubc
  - #plasma
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "🗂️ Karta zadania · GERC Boot"
type: task-card
status: in-progress
priority: P1
owners:
  - jakubc
vault: /home/jakubc/git/eww
workspace: config/eww.code-workspace
task_card: true
integrations:
  code:
    workspace_file: config/eww.code-workspace
    settings_file: .vscode/settings.json
    tasks_file: .vscode/tasks.json
    required_extensions:
      - ms-vscode.codicons
      - ms-vscode.powershell
      - ms-python.python
      - yzhang.markdown-all-in-one
      - adpyke.codesnap
  obsidian:
    vault: /home/jakubc/git/eww
    plugins:
      - obsidian-tasks
      - dataview
      - canvas
  system:
    os: kubuntu-24.04
    desktop: plasma-6.4
    scripts_dir: ~/.config/autostart-scripts
owner: jakubc
---

# 🗂️ Karta zadania · GERC Boot Autostart

> [!info] Podsumowanie
- Zapewnić w 100% powtarzalny start środowiska pracy na 3 monitorach (Sony TV, HP vertical, HP Control/Info) po uruchomieniu Kubuntu/Plasma.
- Automatycznie ładować główne narzędzia (VS Code, Obsidian Graph, Firefox/ChatGPT, Kalendarz KDE, Kronometer, monitoring routera, audio panel) z zachowaniem układu.
- Ta karta jest wzorcowa; każde kolejne zadanie w katalogu `usr/jakubc` powinno mieć analogiczną kartę (patrz sekcja 7).
- Konfiguracja musi pozostać kompatybilna z obecnymi rozszerzeniami VS Code oraz najnowszym Obsidianem z pluginami do zarządzania zadaniami (Tasks + Dataview).

## 1. Kontekst i oczekiwany wynik
- Środowisko: Kubuntu 24.04 + Plasma 6.4, repo `/home/jakubc/git/eww` jako główny workspace.
- Wynik: pojedynczy reboot powoduje włączenie monitorów i aplikacji w dokładnie takim układzie jak obecnie, bez ręcznej interwencji.
- Sukces mierzymy stabilnością (3 udane restarty z rzędu) oraz gotową dokumentacją w repo.

## 2. Zakres funkcjonalny

#### Sony TV · główny workspace
- [ ] Ustawić domyślny workspace VS Code na `/home/jakubc/git/eww` (`code --folder-uri ...`).
- [ ] Zapisać układ paneli (TODO.md, Explorer, terminal, Outline) oraz wymusić przywracanie (`window.restoreWindows`, `workbench.editor.restoreViewState`).
- [ ] Skrypt KDE przypina okno VS Code do Sony TV, uruchamia eww + status widgets na tym monitorze oraz sprawdza dostępność wymaganych rozszerzeń (Markdown, Tasks integration).

#### HP vertical · research / szybkie narzędzia
- [ ] Obsidian Graph (vault = repo) odpala się w dolnych ~60% z wymuszonym widokiem grafu i aktywnymi pluginami Tasks + Dataview.
- [ ] Firefox z ChatGPT i szybką wyszukiwarką startuje nad Obsidianem w dedykowanym kontenerze kart.
- [ ] Systemowy kalendarz Plasmy (KOrganizer) ląduje na górze z aktywną synchronizacją.
- [ ] Kronometer auto-startuje, ładuje profil i od razu liczy czas pracy w przypiętym miejscu.

#### HP Control/Info · monitoring
- [ ] Plasma zachowuje obecne widżety (gerc info) i rozszerza panel o router monitor + audio panel.
- [ ] Router posiada osobny panel z prędkościami sieci (odświeżanie 5s) i szybką diagnostyką.
- [ ] Wi-Fi oraz Dolphin pozostają w przypiętych miejscach.

## 3. Odpowiedzialności i zależności
- Owner: `jakubc` (koordynuje monitowy layout, autostart, dokumentację).
- Zależności techniczne: `eww`, `Plasma autostart`, `Kronometer`, `Obsidian`, `Firefox`, `KOrganizer`, `router 192.168.1.1`.
- Wymagane tajne dane: `ROUTER_CREDS`, ewentualne tokeny VS Code/Firefox (lokalnie w KDE Wallet).

## 4. Kryteria akceptacji
- 3 kolejne restarty -> wszystkie aplikacje w poprawnych pozycjach i rozmiarach.
- Kronometer zawsze w stanie `running` po zalogowaniu.
- Router monitor i audio panel reagują natychmiast (latencja < 2s aktualizacji).
- Dokumentacja kroków wdrożenia znajduje się w `usr/jakubc/autostart/README.md`.
- VS Code uruchamia się z kompletem rozszerzeń wymienionych w sekcji spec; Obsidian raportuje aktywne Tasks + Dataview (najświeższe wersje).

## 5. Spec techniczna (YAML)
- Master spec do automatyzacji i testów.

```yaml
boot_profile:
  date: 2025-11-22
  version: 1.3
  owner: jakubc
  os: kubuntu-24.04
  plasma: 6.4
  dependencies:
    - eww >= 0.6
    - kde-plasma-desktop >= 6.4
    - obsidian >= 1.5
    - firefox >= 130
    - kronometer
  requirements:
    vscode_extensions:
      - ms-vscode.codicons
      - ms-vscode.powershell
      - ms-python.python
      - yzhang.markdown-all-in-one
      - adpyke.codesnap
    obsidian_plugins:
      - obsidian-tasks@latest
      - dataview@latest
      - canvas
  integrations:
    code:
      settings_file: /home/jakubc/git/eww/.vscode/settings.json
      workspace_file: /home/jakubc/git/eww/eww.code-workspace
      features:
        - window.restoreWindows=all
        - workbench.editor.restoreViewState=true
        - tasks.customization synced with obsidian `Tasks`
    system:
      autostart_manager: plasma
      scripts_dir: ~/.config/autostart-scripts
      services:
        - monitor_rules.sh
        - eww-code.desktop
        - kronometer-autostart.desktop
    obsidian:
      vault_path: /home/jakubc/git/eww
      daily_note_template: templates/daily.md
      plugins:
        tasks:
          version: latest
          sync_target: VS Code tasks
        dataview:
          version: latest
          indexes: repo-wide
        canvas:
          enabled: true
  monitors:
    sony_tv:
      role: primary_workbench
      geometry:
        resolution: 3840x2160
        scale: 150%
        placement: left
      workspace: /home/jakubc/git/eww
      vs_code:
        autostart_cmd: code --folder-uri file:///home/jakubc/git/eww
        restore_state: true
        extensions_required: ${boot_profile.requirements.vscode_extensions}
        pinned_views:
          - usr/jakubc/TODO.md
          - Explorer (left)
          - Integrated Terminal (bottom)
          - Outline (right)
      automation:
        - lock_window_to_monitor "VS Code" sony_tv
        - start_service eww-daemon
        - ensure_panel status-primary
    hp_vertical:
      role: research_stack
      geometry:
        resolution: 1920x1080
        orientation: portrait
        placement: center
      layout:
        bottom:
          app: obsidian
          mode: graph
          vault: /home/jakubc/git/eww
          plugins:
            - obsidian-tasks
            - dataview
          height_percent: 60
        middle:
          app: firefox
          tabs:
            - https://chat.openai.com/
            - https://duckduckgo.com/
          container: chatgpt-tools
        top:
          app: plasma-calendar
          backend: korganizer
          sync: enabled
      timers:
        kronometer:
          profile: work-tracking
          color: current
          autostart: true
          state: running
          position: pinned_bottom_right
    hp_control:
      role: telemetry_panel
      geometry:
        resolution: 1920x1080
        placement: right
      plasma_widgets:
        - gerc_info
        - router_monitor (target 192.168.1.1 refresh 5s)
        - pinned_networks
        - dolphin_launcher
        - audio_panel
      monitoring:
        router:
          url: http://192.168.1.1
          credentials: ${ROUTER_CREDS}
          widgets:
            - throughput
            - wifi_clients
          compatibility:
            obsidian_tasks_sync: true
        network_speed:
          source: /sys/class/net/*
          show_in_panel: true
  persistent_apps:
    - eww-daemon
    - nextcloud-client
  automation_scripts:
    kde:
      - name: autostart-code
        path: ~/.config/autostart/eww-code.desktop
      - name: monitor-placement
        path: ~/.config/autostart-scripts/monitor_rules.sh
  verification:
    checklist:
      - reboot_and_validate_positions
      - confirm_kronometer_running
      - log_steps_in_usr/jakubc/autostart/README.md
      - backup_yaml_to_repo
```

## 6. Checklisty operacyjne

**Po restarcie**
- [ ] Monitor EDID wykryty poprawnie dla wszystkich ekranów.
- [ ] VS Code, Obsidian, Firefox, Kalendarz, Kronometer, router panel i audio panel są aktywne i przypięte.
- [ ] Brak błędów w `journalctl -b | grep autostart`.

**Dokumentacja i utrzymanie**
- [ ] Uzupełnić log w `usr/jakubc/autostart/README.md` po każdym wdrożeniu.
- [ ] Zarchiwizować YAML w repo i w backupie (Nextcloud / Git).
- [ ] Zresetować liczniki Kronometera na końcu dnia.

## 7. Szablon dla kolejnych kart
- Każde kolejne zadanie w repo powinno posiadać podobną kartę (status, priorytet, zakres, kryteria, YAML/spec, checklisty).
- Szablon startowy:

```markdown
---
tags:
  - #taskcard
  - #<obszar>
created: <ISO8601>
modified: <ISO8601>
author: jakubc
title: "🗂️ Karta zadania · <Nazwa>"
status: <in-progress|blocked|done>
priority: <P1|P2|P3>
owners:
  - <owner>
task_card: true
---

> [!info] Podsumowanie
- ...

## 1. Kontekst
## 2. Zakres (TODO listy)
## 3. Kryteria akceptacji
## 4. Spec (np. YAML)
## 5. Checklisty
```

- Jeśli zadanie nie wymaga YAML, należy dodać inną sekcję specyfikacji (np. tabela konfiguracji).
- Wrzucaj nowe karty do `usr/jakubc/` i linkuj je z głównego `TODO.md`.

## 8. Integracja Code/System/Obsidian
- **VS Code** — korzysta z workspace `eww.code-workspace`, który ładuje rozszerzenia wymienione w YAML i synchronizuje zadania (`tasks.json`) z Obsidian Tasks; wszystkie nowe karty muszą mieć status i priorytet mapowane 1:1 między `TODO.md` a `code-workspace`.
- **System (Plasma/Kubuntu)** — autostart i reguły monitorów siedzą w `~/.config/autostart` oraz `~/.config/autostart-scripts`; każda karta zadania powinna podać wymagane usługi/systemd units lub skrypty, żeby ułatwić przypinanie do monitorów.
- **Obsidian** — vault `/home/jakubc/git/eww` ma pluginy Tasks + Dataview; każda karta ma mieć front matter z `task_card: true`, a główne `TODO.md` łączy się poprzez `[[linki]]`, dzięki czemu graf i zapytania Dataview automatycznie zbierają statusy.

## 🔗 Backlinks

- [[usr/jakubc/todo/todo]]
- [[usr/jakubc/jakubc]]
- [[EWW-MAP]]