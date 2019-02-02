#!/usr/bin/env bash
set -euo pipefail

CFGDIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$(dirname "$0")/test-utils.sh"
SCRIPT="$CFGDIR/checkout.sh"

export REPO="$(git rev-parse --show-toplevel)"
[ -n "$REPO" ] || die "Must run from a cloneable repo"
echo "Cloning from $REPO"

make_temp_home

# Make sure we don't have extra stuff before starting

cd "$HOME"

assert [ ! -d .cfg ]
assert [ ! -d cfg ]
assert [ ! -d bin ]

cat "$SCRIPT" | bash

cd "$HOME"

assert [ -d .cfg ]
assert [ -d cfg ]
assert [ -d bin ]
assert [ -L bin/cfg ]

assert [ "$(readlink bin/cfg)" != "../cfg/bin/cfg" ]
