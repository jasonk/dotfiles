#!/bin/bash

#$# setup -- Ensure everything is setup correctly.
#$# setup [name] -- Run specific setup scripts.
#$# setup --list -- List available setup scripts.

list-setups() {
  for I in "$CFG_DIR/setup-scripts"/*; do
    if [ -x "$I" ]; then basename "$I"; fi
  done
}
run-setup() {
  local SETUP="$CFG_DIR/setup-scripts/$1"
  if [ -x "$SETUP" ]; then
    "$SETUP";
  else
    warn "Unknown setup command '$1'"
  fi
}

cfg ignore
if (( $# )); then
  while (( $# )); do
    case "$1" in
      --list) list-setups ; shift 1 ;;
      -*) die "Unknown option '$1'" ;;
      *) run-setup "$1" ; shift 1 ;;
    esac
  done
else
  for I in $(list-setups); do run-setup "$I"; done
fi
