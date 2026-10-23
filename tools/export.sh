#!/usr/bin/env bash
# Export the SilverBullet space to the `github` branch as GitHub-flavored
# markdown. Designed to be called at the END of sb-sync.sh.
#
# - Rebuilds the branch from scratch each time: single snapshot commit, force-
#   pushed. No history to maintain, no conflicts possible.
# - Dedup: skips when main's HEAD did not change since the last export
#   (state kept in .git/sb-export.state, invisible to SilverBullet).
set -euo pipefail

SPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$(mktemp -d "${TMPDIR:-/tmp}/sb-export.XXXXXX")"
trap 'rm -rf "$OUT"' EXIT
LOG="${TMPDIR:-/tmp}/sb-export.log"

STATE="$SPACE/.git/sb-export.state"
HEAD_SHA="$(git -C "$SPACE" rev-parse HEAD)"
[ -f "$STATE" ] && grep -qxF "$HEAD_SHA" "$STATE" && exit 0
echo "[sb-sync] export start $(date '+%F %T') main=${HEAD_SHA:0:7}" >>"$LOG"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[sb-sync] export failed: python3 not found — install it (Debian/Ubuntu: apt install python3, Alpine: apk add python3)" | tee -a "$LOG"
  exit 1
fi

python3 "$SPACE/tools/export.py" --space "$SPACE" --out "$OUT" >>"$LOG" 2>&1 \
  || { echo "[sb-sync] export failed, see $LOG"; exit 1; }

(
  cd "$OUT"
  git init -q
  git symbolic-ref HEAD refs/heads/github
  git add -A
  git -c user.name="SB Export" -c user.email="export@silverbullet.local" \
    commit -q --allow-empty -m "Export: $(date '+%F %T') from main@${HEAD_SHA:0:7}"
  git remote add origin "$(git -C "$SPACE" config --get remote.origin.url)"
  git push -q -f origin github
)

echo "$HEAD_SHA" >"$STATE"
echo "[sb-sync] exported to github branch ($(git -C "$OUT" rev-parse --short HEAD))" >>"$LOG"