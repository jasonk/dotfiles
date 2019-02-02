#!/usr/bin/env bash
###################
# Copyright 2019 Jason Kohles <email@jasonkohles.com>
# MIT Licensed
# https://github.com/jasonk/dotfiles
####################
set -euo pipefail

: "${RAW:="https://raw.githubusercontent.com/jasonk/dotfiles/master/cfg"}"
INIT_FILES=(
  bin/cfg
  ignores/auth-risks
  ignores/caches
  ignores/cruft
  ignores/history
)

warn() { echo "$@" 1>&2; }
die() { warn "$@"; exit 1; }

cd "$HOME"
[ -d "$HOME/.cfg" ] && die "Already have a $HOME/.cfg directory!";
[ -d "$HOME/cfg" ] && die "Already have a $HOME/cfg directory!";

git init --bare "$HOME/.cfg"

mkdir -p cfg/bin cfg/ignores

cd cfg

for I in "${INIT_FILES[@]}"; do
  curl -sSL -o "$I" "$RAW/$I"
done

chmod +x bin/cfg

cd "$HOME"

./cfg/bin/cfg setup
mkdir -p bin
( cd bin && ln -sf ../cfg/bin/cfg . )
./cfg/bin/cfg add cfg
./cfg/bin/cfg add bin/cfg

cfg commit -am 'Initial commit from create-new-repo.sh'
