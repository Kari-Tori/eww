---
version: 0.0.4
title: "repo-live-contract"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-21T10:00:00Z
modified: 2025-11-24T22:31:02Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "Repo Live Contract"






owner: jakubc
created: 2025-11-21T10:00:00Z
modified: 2025-11-24T22:31:02Z
author: jakubc
---

# Repo Live Contract
## Cel
Kontrola kosztów i zdrowia repo. Progi ostrzegawcze i blokujące.
## Polityki
- `main` chroniony, PR z review.
- Commity małe i opisowe; bez binariów >50 MiB.
- Releases: asset ≤2 GiB/szt.
- Duże pliki → Git LFS.
- CI: kontrakt na każdy push i codziennie 03:00 UTC.
## SLO + Progi
- `repository.diskUsage`: warn 500 MiB, block 1 GiB.
- Największy blob w historii: warn 25 MiB, block 100 MiB.
- Pojedynczy plik w drzewie: warn 25 MiB, block 100 MiB.
- Release asset: block 2 GiB.
- Actions minuty: warn 90% limitu, block 100%.
- Packages: warn 400 MiB, block 500 MiB.
- LFS lokalnie: warn 8 GiB, block 10 GiB.
## Telemetria
- Lokalnie: `git count-objects -vH`, liczba commitów, contributorzy, top blob-y, porównanie `.git` vs worktree.
- GitHub API: traffic (views, clones 14 dni), statistics, GraphQL `repository.diskUsage`, billing (Actions/Packages/Shared).
## Egzekwowanie
- `pre-push`: blokady.
- GitHub Actions: status check „Repo Contract”.
## Remediacja
Filter-repo/BFG, przeniesienie binariów do Releases/LFS, redukcja historii.

## 🔗 Backlinks

- [[docs/governance/governance]]
- [[docs/docs]]
- [[INDEX]]