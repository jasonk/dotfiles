#!/bin/bash
set -x

echo "$@"

REPO="jasonk/dotfiles"
BRANCH="master"

CFGURL="https://raw.githubusercontent.com/$REPO/$BRANCH/cfg"
#CFGURL="file://$HOME/cfg" # For Dev

if ! command -v brew 2>/dev/null 1>/dev/null; then
  HBURL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
  /bin/bash -c "$(curl -fsSL "$HBURL")"
fi

curl -fsSL "$CFGURL/Brewfile" | brew bundle --file=/dev/stdin

export GHREPO="https://github.com/$REPO"
if [ ! -d "$HOME/.cfg" ]; then
  REPO="$GHREPO" curl -fsSL "$CFGURL/checkout.sh"
fi
