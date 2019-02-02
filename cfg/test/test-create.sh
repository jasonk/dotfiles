#!/usr/bin/env bash
set -euo pipefail

CFGDIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$(dirname "$0")/test-utils.sh"
SCRIPT="$CFGDIR/create-new-repo.sh"
export RAW="file://$CFGDIR"

make_temp_home

# Make sure we don't have extra stuff before starting

cd "$HOME"

assert test ! -d .cfg
assert test ! -d cfg
assert test ! -d bin

cat "$SCRIPT" | bash

cd "$HOME"

assert test -d .cfg
assert test -d cfg
assert test -d bin
