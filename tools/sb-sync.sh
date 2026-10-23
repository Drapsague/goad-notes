#!/bin/bash
# SilverBullet <-> GitHub sync (two-way) + GitHub-flavored export.
# Deployed at /usr/local/bin/sb-sync.sh on the silverbullet host; runs from
# sb-watch.service (inotify watcher) after every space change.
exec 9>/tmp/sb-sync.lock
flock -n 9 || exit 0

SPACE=/opt/silverbullet/data/spaces/goad
cd "$SPACE" || exit 1

git add -A
git diff --cached --quiet || git commit -m "Auto: $(date '+%F %T')"
git pull --rebase --autostash origin main
git push origin main

# Translate SB-flavored markdown -> GFM and push the `github` branch.
# Idempotent: skips itself when main hasn't moved since the last export.
if [ -f "$SPACE/tools/export.sh" ]; then
  bash "$SPACE/tools/export.sh" || true
fi