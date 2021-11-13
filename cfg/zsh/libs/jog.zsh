#!/usr/bin/env zsh
# Inspired by https://github.com/natethinks/jog

function zshaddhistory() {
  if [[ $1 == $'jog\n' ]] || [[ $1 == 'jog '* ]]; then return; fi
  printf '%s\t%q\n' "$PWD" "${1%%$'\n'}" >> ~/.cache/jog-history
}
function jog() {
  grep -a --color=never "^${PWD}"$'\t' ~/.cache/jog-history |
    tail | sed 's/^[^\t]+\t//' | xargs -n1 echo
}
