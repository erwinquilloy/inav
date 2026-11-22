#!/usr/bin/env bash
# usage: prepare.sh <inav checkout> <version>
# official source + the disarm hold, committed with fixed metadata so every job gets the same revision id
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
cd "$1"
git apply "$here/patches/disarm_hold_$2.patch"
git add src/main
export GIT_AUTHOR_NAME="github-actions[bot]" GIT_AUTHOR_EMAIL="41898282+github-actions[bot]@users.noreply.github.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
export GIT_AUTHOR_DATE="2026-11-22T00:00:00Z" GIT_COMMITTER_DATE="2026-11-22T00:00:00Z"
git -c commit.gpgsign=false -c core.hooksPath=/dev/null commit -q --no-verify -m "OSD: MSP DisplayPort disarm hold (osd_msp_disarm_hold), unofficial build of INAV $2"
git rev-parse HEAD
