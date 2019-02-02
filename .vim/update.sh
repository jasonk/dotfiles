#!/bin/bash
set -e
cd "$(dirname "$0")"

PACKS="pack/jasonk/start"

cd "$PACKS"
for I in *; do
  ( cd "$I" && git pull )
done
