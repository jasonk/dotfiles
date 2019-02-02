#!/bin/bash

if have cmd brew; then
  BREW_PREFIX=$(brew --prefix)
  if [ -f $BREW_PREFIX/etc/bash_completion ]; then
    . $BREW_PREFIX/etc/bash_completion
  fi
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  pathedit --prepend /usr/local/opt/openssl/bin
fi
