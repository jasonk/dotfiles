# shellcheck shell=bash
vault="$(command -v vault)"
if [ -n "$vault" ]; then complete -C "$vault" vault; fi
