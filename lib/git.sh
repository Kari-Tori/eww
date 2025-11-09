#!/usr/bin/env bash
# shell lib: git helpers

# Pobierz katalog główny repozytorium
repo_root() { 
    git rev-parse --show-toplevel 2>/dev/null || pwd
}

# Pobierz ostatni tag
git::last_tag() {
    git describe --tags --abbrev=0 2>/dev/null || echo ""
}

# Sprawdź czy repozytorium jest czyste
git::is_clean() {
    [[ -z $(git status --porcelain) ]]
}

# Pobierz aktualną gałąź
git::current_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Sprawdź czy commit używa Conventional Commits
git::is_conventional_commit() {
	local msg="$1"
	local pattern='^(feat|fix|docs|style|refactor|perf|test|chore|build|ci|revert|security|add|deprecate|remove)(\([^)]+\))?:[[:space:]].+'
	[[ $msg =~ $pattern ]]
}

# Parsuj typ z commit message
git::get_commit_type() {
	local msg="$1"
	local pattern='^([a-z]+)(\([^)]+\))?:[[:space:]].+'
	if [[ $msg =~ $pattern ]]; then
		echo "${BASH_REMATCH[1]}"
	else
        echo "other"
    fi
}

# Parsuj scope z commit message
git::get_commit_scope() {
	local msg="$1"
	local pattern='^[a-z]+\(([^)]+)\):[[:space:]].+'
	if [[ $msg =~ $pattern ]]; then
		echo "${BASH_REMATCH[1]}"
	else
		echo ""
	fi
}

# Pobierz commity między tagami/refami
git::commits_between() {
    local from="${1:-}"
    local to="${2:-HEAD}"
    
    if [[ -z $from ]]; then
        from=$(git::last_tag)
    fi
    
    if [[ -z $from ]]; then
        git log --pretty=format:"%H|%s" "$to"
    else
        git log --pretty=format:"%H|%s" "${from}..${to}"
    fi
}
