#!/usr/bin/env bash
# File: dev/scripts/semver_auto.sh
# Author: 
# Created: 
# Updated: 
# Description: Auto-bump SemVer wg Conventional Commits od ostatniego tagu v*.
set -Eeuo pipefail
# Auto-bump SemVer wg Conventional Commits od ostatniego tagu v*.
# Użycie: scripts/semver_auto.sh [--dry-run] [--if-main] [--gh]
dry=0
if_main=0
use_gh="${GH:-0}"
CHANGELOG_PATH="${CHANGELOG_PATH:-CHANGELOG.md}"
VERSION_PATH="${VERSION_PATH:-VERSION}"
for a in "$@"; do case "$a" in --dry-run) dry=1 ;; --if-main) if_main=1 ;; --gh) use_gh=1 ;; *)
	echo "usage: $0 [--dry-run] [--if-main] [--gh]" >&2
	exit 2
	;;
esac done
branch="$(git symbolic-ref --short HEAD 2>/dev/null || echo '')"
if [[ "$if_main" -eq 1 && "$branch" != "main" && "$branch" != "master" ]]; then exit 0; fi
latest_tag() { git describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || echo 'v0.0.0'; }
last_tag="$(latest_tag)"
log="$(git log --no-merges --pretty=%B "${last_tag}"..HEAD 2>/dev/null || true)"
bump="none"
if grep -Eq '(^|\n)BREAKING CHANGE' <<<"$log" || grep -Eq '(^|\n)(feat|fix|perf|refactor)!' <<<"$log"; then
	bump="major"
elif grep -Eq '(^|\n)feat(\(|:)' <<<"$log"; then
	bump="minor"
elif grep -Eq '(^|\n)(fix|perf|refactor)(\(|:)' <<<"$log"; then bump="patch"; fi
[[ "$bump" = "none" ]] && {
	echo "INFO: no bump since $last_tag"
	exit 0
}
if [[ -f "$VERSION_PATH" ]]; then base_ver="$(sed -n '1p' "$VERSION_PATH" | tr -d ' \t\r\n')"; else base_ver="${last_tag#v}"; fi
IFS=. read -r MA MI PA <<<"$base_ver"
case "$bump" in major)
	((MA += 1))
	MI=0
	PA=0
	;;
minor)
	((MI += 1))
	PA=0
	;;
patch) ((PA += 1)) ;; esac
new_ver="${MA}.${MI}.${PA}"
echo "INFO: bump=$bump  last_tag=$last_tag  base=$base_ver -> new=$new_ver"
[[ "$dry" -eq 1 ]] && exit 0
printf '%s\n' "$new_ver" >"$VERSION_PATH"
today="$(date +%F)"
tmp="$(mktemp)"
{
	echo "## v${new_ver} — ${today}"
	if [[ "$last_tag" == "v0.0.0" ]]; then git log --pretty=format:"- %s (%h)"; else git log "${last_tag}..HEAD" --pretty=format:"- %s (%h)"; fi
	echo
} >"$tmp"
if [[ -f "$CHANGELOG_PATH" ]]; then cat "$tmp" "$CHANGELOG_PATH" >"${CHANGELOG_PATH}.new" && mv "${CHANGELOG_PATH}.new" "$CHANGELOG_PATH"; else mv "$tmp" "$CHANGELOG_PATH"; fi
git add "$VERSION_PATH" "$CHANGELOG_PATH"
git commit -S -m "chore(release): v${new_ver}"
git tag -s "v${new_ver}" -m "v${new_ver}"
git push --follow-tags
if [[ "$use_gh" -eq 1 ]] && command -v gh >/dev/null 2>&1; then
	awk -v ver="v${new_ver}" 'BEGIN{p=0} $0 ~ "^## "ver" " {p=1; next} /^## v/ {if(p){exit}} p' "$CHANGELOG_PATH" >"/tmp/notes-${new_ver}.md" || true
	gh release create "v${new_ver}" --title "v${new_ver}" --notes-file "/tmp/notes-${new_ver}.md" || true
fi
echo "OK v${new_ver}"
