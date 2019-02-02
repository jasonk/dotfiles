#!/usr/bin/env bash

MYDIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"

warn() { echo "$@" 1>&2; }
die() { warn "$@"; exit 1; }

home_is_temp() {
  case "$HOME" in
    /home/*)          return 1 ;;
    /Users/*)         return 1 ;;
    /tmp/*)           return 0 ;;
    /var/folders/*)   return 0 ;;
    *) die "Cannot determine if '$HOME' is temporary or not" ;;
  esac
}

make_temp_home() {
  if home_is_temp; then return; fi
  TMPDIR="$(mktemp -d)"

  trap "exit 1"         HUP INT PIPE QUIT TERM
  # shellcheck disable=SC2064
  trap "rm -rf $TMPDIR" EXIT

  export HOME="$TMPDIR"
}

RED="$(echo -e '\033[0;31m')"
GREEN="$(echo -e '\033[0;32m')"
RESET="$(echo -e '\033[0m')"

assert() {
  set +e
  "$@"
  local RC=$?
  set -e
  if [ "$RC" -eq 0 ]; then
    echo "${GREEN}   ✓ PASS ($*)${RESET}"
  else
    echo "${RED}   ✗ FAIL ($*) => $RC${RESET}"
    if [ -n "${ASSERT_FAIL_INTERACTIVE:-}" ]; then
      bash -i
    fi
  fi
  return $RC
}
