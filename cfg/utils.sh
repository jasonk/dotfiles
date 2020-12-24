#!/bin/bash
set -euo pipefail

RED="\033[0;31m"
LIGHT_RED="\033[1;31m"
GREEN="\033[0;32m"
LIGHT_GREEN="\033[1;32m"
BLUE="\033[0;34m"
LIGHT_BLUE="\033[1;34m"

GRAY="\033[0;37m"
WHITE="\033[1;37m"
RESET="\033[0m"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"

warn() { echo "$@" 1>&2; }
die() { warn "$@"; exit 1; }

find_bashinit() {
  for X in .bash_profile .bash_login .profile; do
    if [[ -f "$HOME/$X" ]]; then
      echo "$HOME/$X"
      return
    fi
  done
  echo "$HOME/.bash_profile"
}

update_bashinit() {
  local bashinit
  bashinit=$(find_bashinit)
  echo "$1" >> "$bashinit"
  if [ -n "$2" ]; then
    echo ""
    echo ""
    echo "------------------"
    echo "$bashinit updated:"
    echo "------------------"
    echo "$2"
    echo "------------------"
    echo "Make sure you reload that file (or restart your terminal)"
    echo "before proceeding"
    echo "------------------"
  fi
}

is_mac() { [ "$(uname)" = "Darwin" ]; }
is_linux() { [ "$(uname)" = "Linux" ]; }
is_root() { [ "$(id -un)" = "root" ]; }

skip_if_mac() { if is_mac; then exit; fi; }
skip_unless_mac() { if ! is_mac; then exit; fi; }
skip_if_linux() { if ! is_linux; then exit; fi; }
skip_unless_linux() { if ! is_linux; then exit; fi; }

have() { type "$1" >/dev/null; }

require_root() {
  if ! is_root; then
    warn "$0 must be run as root, re-running with sudo"
    exec sudo "$0"
  fi
}

problem() {
  local PROBLEM="$1"
  printf "\n${RED}PROBLEM: ${LIGHT_RED}%s${RESET}\n\n" "$@"
  cat
  echo ""
  exit 1
}
