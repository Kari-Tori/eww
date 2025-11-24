#!/usr/bin/env bash
set -Eeuo pipefail
# Wymagania: git, gh, jq. Opcjonalnie: git-sizer, git-lfs.
# Użycie:
#   tools/repo-metrics.sh > logs/repo-metrics-$(date +%F_%H%M%S).json
#   tools/repo-metrics.sh --check

RC_REPO_DISK_WARN_MB="${RC_REPO_DISK_WARN_MB:-500}"
RC_REPO_DISK_BLOCK_MB="${RC_REPO_DISK_BLOCK_MB:-1024}"
RC_BLOB_WARN_MB="${RC_BLOB_WARN_MB:-25}"
RC_BLOB_BLOCK_MB="${RC_BLOB_BLOCK_MB:-100}"
RC_FILE_WARN_MB="${RC_FILE_WARN_MB:-25}"
RC_FILE_BLOCK_MB="${RC_FILE_BLOCK_MB:-100}"
RC_RELEASE_ASSET_BLOCK_GIB="${RC_RELEASE_ASSET_BLOCK_GIB:-2}"
RC_LFS_WARN_GB="${RC_LFS_WARN_GB:-8}"
RC_LFS_BLOCK_GB="${RC_LFS_BLOCK_GB:-10}"

need(){ command -v "$1" >/dev/null 2>&1 || { echo "ERR: missing $1" >&2; exit 2; }; }
need git; need gh; need jq

cd "$(git rev-parse --show-toplevel)"

read -r OWNER REPO <<<"$(gh repo view --json owner,name -q '.owner.login + " " + .name')"

COUNT_JSON="$(git count-objects -vH | awk -F': ' '{gsub(/ /,"",$1); print "\""$1"\":\""$2"\""}' | paste -sd, -)"
COMMITS="$(git rev-list --count HEAD || echo 0)"
CONTRIBS="$(git shortlog -sne | wc -l || echo 0)"
TOP_BLOBS="$(git rev-list --objects --all \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
  | awk '$1=="blob"{print $3"\t"$4}' | sort -nr | head -n 20 \
  | awk 'BEGIN{print "["}{printf "%s{\"size\":%s,\"path\":\"%s\"}", (NR>1?",":""), $1, $2}END{print "]"}')"

GIT_DIR_SIZE_BYTES="$(du -sb .git | awk '{print $1}')"
TREE_SIZE_BYTES="$(du -sb . | awk '{print $1}')"
WORKTREE_SIZE_BYTES="$(( TREE_SIZE_BYTES - GIT_DIR_SIZE_BYTES ))"

DISK_KIB="$(gh api graphql -f query='query($o:String!,$r:String!){repository(owner:$o,name:$r){diskUsage}}' -f o="$OWNER" -f r="$REPO" --jq '.data.repository.diskUsage' || echo 0)"
DISK_MB="$(( DISK_KIB / 1024 ))"

VIEWS="$(gh api repos/$OWNER/$REPO/traffic/views || echo '{}')"
CLONES="$(gh api repos/$OWNER/$REPO/traffic/clones || echo '{}')"

REL_JSON="$(gh api repos/$OWNER/$REPO/releases --paginate || echo '[]')"
REL_ASSETS="$(echo "$REL_JSON" | jq '[.[]?.assets[]? | {name,size}]')"
REL_MAX_ASSET_GIB="$(echo "$REL_ASSETS" | jq '([.[].size]|max // 0) / (1024*1024*1024)')"

ACTIONS_BILL="$(gh api -X GET /user/billing/actions 2>/dev/null || echo '{}')"
PACKAGES_BILL="$(gh api -X GET /user/billing/packages 2>/dev/null || echo '{}')"
SHARED_BILL="$(gh api -X GET /user/billing/shared-storage 2>/dev/null || echo '{}')"

if command -v git-lfs >/dev/null 2>&1; then
  LFS_DIR_BYTES="$(du -sb .git/lfs/objects 2>/dev/null | awk '{print $1+0}')"
else
  LFS_DIR_BYTES=0
fi
LFS_DIR_GB="$(awk -v b="$LFS_DIR_BYTES" 'BEGIN{printf "%.3f", b/1024/1024/1024}')"

if command -v git-sizer >/dev/null 2>&1; then
  GITSIZER="$(git-sizer --json 2>/dev/null || echo '{}')"
else
  GITSIZER='{}'
fi

OUT="$(jq -n \
  --arg owner "$OWNER" --arg repo "$REPO" \
  --argjson disk_mb "$DISK_MB" --argjson disk_kib "$DISK_KIB" \
  --argjson worktree_bytes "$WORKTREE_SIZE_BYTES" \
  --argjson gitdir_bytes "$GIT_DIR_SIZE_BYTES" \
  --argjson commits "$COMMITS" --argjson contributors "$CONTRIBS" \
  --argjson views "$VIEWS" --argjson clones "$CLONES" \
  --argjson releases "$REL_JSON" --argjson release_assets "$REL_ASSETS" \
  --argjson rel_max_asset_gib "$REL_MAX_ASSET_GIB" \
  --argjson actions_bill "$ACTIONS_BILL" --argjson packages_bill "$PACKAGES_BILL" --argjson shared_bill "$SHARED_BILL" \
  --argjson gitsizer "$GITSIZER" \
  --argjson top_blobs "$TOP_BLOBS" \
  --arg count_objects "{$COUNT_JSON}" \
  '{
    repo: {owner:$owner,name:$repo},
    sizes: {diskUsageMB:$disk_mb, diskUsageKiB:$disk_kib, worktreeBytes:$worktree_bytes, gitDirBytes:$gitdir_bytes},
    git: {commits:$commits, contributors:$contributors, countObjects:.countObjects},
    history: {topBlobs:$top_blobs},
    traffic: {views:$views, clones:$clones},
    releases: {raw:$releases, assets:$release_assets, maxAssetGiB:$rel_max_asset_gib},
    billing: {actions:$actions_bill, packages:$packages_bill, shared:$shared_bill},
    analyzers: {gitSizer:$gitsizer},
    ts: now
  }'
)"
echo "$OUT"

if [[ "${1:-}" == "--check" ]]; then
  FAIL=0
  if (( DISK_MB >= RC_REPO_DISK_BLOCK_MB )); then
    echo "BLOCK: repo diskUsage ${DISK_MB} MB >= ${RC_REPO_DISK_BLOCK_MB} MB" >&2; FAIL=1
  elif (( DISK_MB >= RC_REPO_DISK_WARN_MB )); then
    echo "WARN: repo diskUsage ${DISK_MB} MB >= ${RC_REPO_DISK_WARN_MB} MB" >&2
  fi
  REL_MAX_INT="$(printf "%.0f" "$(echo "$REL_MAX_ASSET_GIB" | tr -d '\n')")"
  if (( REL_MAX_INT >= RC_RELEASE_ASSET_BLOCK_GIB )); then
    echo "BLOCK: release asset >= ${RC_RELEASE_ASSET_BLOCK_GIB} GiB" >&2; FAIL=1
  fi
  MAX_BLOB_BYTES="$(echo "$TOP_BLOBS" | jq '.[0].size // 0')"
  MAX_BLOB_MB="$(( MAX_BLOB_BYTES / (1024*1024) ))"
  if (( MAX_BLOB_MB >= RC_BLOB_BLOCK_MB )); then
    echo "BLOCK: largest blob ${MAX_BLOB_MB} MB >= ${RC_BLOB_BLOCK_MB} MB" >&2; FAIL=1
  elif (( MAX_BLOB_MB >= RC_BLOB_WARN_MB )); then
    echo "WARN: largest blob ${MAX_BLOB_MB} MB >= ${RC_BLOB_WARN_MB} MB" >&2
  fi
  LFS_INT="$(printf "%.0f" "${LFS_DIR_GB%.*}")"
  if (( LFS_INT >= RC_LFS_BLOCK_GB )); then
    echo "BLOCK: local LFS ${LFS_DIR_GB} GB >= ${RC_LFS_BLOCK_GB} GB" >&2; FAIL=1
  elif (( LFS_INT >= RC_LFS_WARN_GB )); then
    echo "WARN: local LFS ${LFS_DIR_GB} GB >= ${RC_LFS_WARN_GB} GB" >&2
  fi
  exit "$FAIL"
fi
