# GitHub — kluczowe informacje

- Dokumentacja: https://docs.github.com/
- Autoryzacja: personal access token (PAT) z minimalnymi scope (repo/workflow); przechowywać w `$HOME/.config/github` lub zmiennych środowiskowych.
- Fork flow (używany przez karinam): fork → push do forka → PR do `github.com/nairecth/eww`.
- GitHub Actions: https://docs.github.com/en/actions — CI/CD, sekrety w repo, uruchamiane w workflow YAML.
- CLI: https://cli.github.com/ (`gh`) do tworzenia PR, review, listy issue.

### Przykład: tworzenie PR (gh)
```bash
gh pr create --fill --base main --head feat/branch
```

