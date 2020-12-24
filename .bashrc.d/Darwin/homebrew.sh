#!/bin/bash

if have_cmd brew; then
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  pathedit --prepend /usr/local/opt/openssl/bin
fi
