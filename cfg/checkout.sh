#!/usr/bin/env bash
###################
# Copyright 2019 Jason Kohles <email@jasonkohles.com>
# MIT Licensed
# https://github.com/jasonk/dotfiles
####################
set -euo pipefail

warn() { echo "$@" 1>&2; }
die() { warn "$@"; exit 1; }

OVERWRITE=false
FORCE=false
while [ $# -gt 0 ]; do
  case "$1" in
    --overwrite)  OVERWRITE=true            ; shift 1 ;;
    --force)      FORCE=true                ; shift 1 ;;
    -*)           die "Unknown option '$1'"           ;;
    *)            REPO="$1"                 ; shift   ;;
  esac
done

# You can provide the repo either as an env variable or the first
# argument to this script.
[ -z "${REPO:-}" ] && die "Must specify repository URL"

# Go home and make sure we aren't trying to checkout where we already
# have a cfg install
cd "$HOME"
if $FORCE; then
  rm -rf "$HOME/.cfg" "$HOME/cfg"
else
  [ -d "$HOME/.cfg" ] && die "Already have a $HOME/.cfg directory!";
  [ -d "$HOME/cfg" ] && die "Already have a $HOME/cfg directory!";
fi

# Make a temporary directory to clone into, since we can't clone
# directly into your home directory as it probably isn't empty.
TMPDIR="$(mktemp -d)"
trap "exit 1"         HUP INT PIPE QUIT TERM
# shellcheck disable=SC2064
trap "rm -rf $TMPDIR" EXIT

export GIT_DIR="$HOME/.cfg"
export GIT_WORK_TREE="$HOME"

# Clone the repo and put the git data into ~/.cfg and the work tree
# into a temporary directory
git clone --separate-git-dir="$HOME/.cfg" "$REPO" "$TMPDIR"

# For any file that is currently reported as 'deleted' (because it
# didn't exist in your home directory) we just check it out from the
# repo to populate it.
git status -uno --porcelain \
  | sed -n 's/^ D //p' \
  | tr '\n' '\0' \
  | xargs -0 git checkout --

# Then we update the ignore files, so you won't see all the ignored
# stuff by default.
"$HOME/cfg/bin/cfg" ignore

# We don't do anything about added/changed files, because you will
# have to review those yourself..

echo "################################################################"
echo "Now you should review and make sure your dotfiles on this"
echo "system are the way you want them.  Once you are sure everything"
echo "is ready, run 'cfg setup' to complete the setup tasks."
echo "################################################################"
"$HOME/cfg/bin/cfg" status
