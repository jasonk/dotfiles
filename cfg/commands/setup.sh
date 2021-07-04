#!/bin/bash

#$# setup -- Ensure everything is setup correctly.
#$# setup [name] -- Run specific setup scripts.
#$# setup --list -- List available setup scripts.

cfg ignore
if [ "$1" = "--list" ]; then
  for I in "$CFG_DIR/setup-scripts"/*; do
    basename "$I"
  done
elif [ "$#" -gt 0 ]; then
  for I in "$@"; do "$CFG_DIR/setup-scripts/$I"; done
else
  for I in "$CFG_DIR/setup-scripts"/*; do
    if [ -x "$I" ]; then "$I"; fi
  done
fi
