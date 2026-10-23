#!/usr/bin/env bash
# Export the SilverBullet space to the `github` branch as GitHub-flavored
# markdown. Called at the END of sb-sync.sh.
#
# Design:
# - Converted files land in a temp dir ($OUT). A temporary index ($IDX) turns
#   that dir into a git tree INSIDE the space repo's object store.
# - The branch is pushed directly from a raw commit sha — no temp clone, no
#   local branch created in the space, and it pushes through the space repo's
#   own remote/auth (same credentials as the `main` push).
# - One snapshot commit per export (chained on top of the previous export when
#   reachable), force-pushed. No merge logic, no conflicts possible.
# - Dedup: skipped when main's HEAD is unchanged since the last export
#   (state kept in .git/sb-export.state, invisible to SilverBullet).
set -euo pipefail

SPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITDIR="$(git -C "$SPACE" rev-parse --absolute-git-dir)"
OUT="$(mktemp -d "${TMPDIR:-/tmp}/sb-export.XXXXXX")"
IDX="$GITDIR/sb-export.index"
trap 'rm -rf "$OUT" "$IDX"' EXIT
LOG="${TMPDIR:-/tmp}/sb-export.log"
BRANCH="refs/heads/github"

STATE="$GITDIR/sb-export.state"
HEAD_SHA="$(git -C "$SPACE" rev-parse HEAD)"
[ -f "$STATE" ] && grep -qxF "$HEAD_SHA" "$STATE" && exit 0
echo "[sb-sync] export start $(date '+%F %T') main=${HEAD_SHA:0:7}" >>"$LOG"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[sb-sync] export failed: python3 not found — install it (Debian/Ubuntu: apt install python3, Alpine: apk add python3)" | tee -a "$LOG"
  exit 1
fi

python3 "$SPACE/tools/export.py" --space "$SPACE" --out "$OUT" >>"$LOG" 2>&1 \
  || { echo "[sb-sync] export failed, see $LOG"; exit 1; }

# Sanity: the conversion produced actual content
[ -n "$(find "$OUT" -type f -print -quit)" ] \
  || { echo "[sb-sync] export failed: converter produced no files" | tee -a "$LOG"; exit 1; }

# Build the tree of converted files inside the space repo's object store
TREE="$(
  (
    export GIT_DIR="$GITDIR" GIT_WORK_TREE="$OUT" GIT_INDEX_FILE="$IDX"
    cd "$OUT"
    git add -A
    git write-tree
  )
)"

# Snapshot commit: always a fresh root commit, force-pushed — no parent
# chaining (keeps this robust even if the github branch was never fetched).
COMMIT="$(git -C "$SPACE" -c user.name="SB Export" -c user.email="export@silverbullet.local" \
  commit-tree "$TREE" -m "Export: $(date '+%F %T') from main@${HEAD_SHA:0:7}")"

git -C "$SPACE" push -q -f origin "$COMMIT:$BRANCH"

echo "$HEAD_SHA" >"$STATE"
echo "[sb-sync] exported $COMMIT to github branch (from main@${HEAD_SHA:0:7})" >>"$LOG"