#!/usr/bin/env bash
set -Eeuo pipefail
usage() {
	echo "usage: $0 [major|minor|patch|X.Y.Z]"
	exit 2
}
bump() {
	IFS=. read -r MA MI PA <<<"$1"
	case "$2" in major)
		((MA++))
		MI=0
		PA=0
		;;
	minor)
		((MI++))
		PA=0
		;;
	patch) ((PA++)) ;; *) exit 2 ;; esac
	echo "${MA}.${MI}.${PA}"
}
log_between() {
	from="$1"
	if [[ "$from" == "v0.0.0" || -z "$from" ]]; then git log --pretty=format:"- %s (%h)"; else git log "${from}..HEAD" --pretty=format:"- %s (%h)"; fi
}
mode="${1:-}"
[[ -z "$mode" ]] && usage
last_tag="$(git describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || echo 'v0.0.0')"
current="$(sed -n '1p' VERSION 2>/dev/null || echo "${last_tag#v}")"
if [[ "$mode" =~ ^(major|minor|patch)$ ]]; then
	new="$(bump "$current" "$mode")"
elif [[ "$mode" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	new="$mode"
else usage; fi
echo "$new" >VERSION
today="$(date +%F)"
notes="$(mktemp)"
{
	echo "## v${new} — ${today}"
	log_between "$last_tag"
	echo
} >"$notes"
if [[ -f CHANGELOG.md ]]; then cat "$notes" CHANGELOG.md >CHANGELOG.md.new && mv CHANGELOG.md.new CHANGELOG.md; else mv "$notes" CHANGELOG.md; fi
git add VERSION CHANGELOG.md
git commit -S -m "chore(release): v${new}"
git tag -s "v${new}" -m "v${new}"
git push --follow-tags
command -v gh >/dev/null 2>&1 && gh release create "v${new}" --title "v${new}" --notes-file <(sed -n '1,/^## v/p' CHANGELOG.md | sed -n '1,/^## v/ p' | sed '$d') || true
echo "OK v${new}"
