#!/bin/bash

echo "$@"

REPO="jasonk/dotfiles"
BRANCH="master"

CFGURL="https://raw.githubusercontent.com/$REPO/$BRANCH/master/cfg"
#CFGURL="file://$HOME/cfg" # For Dev
GHREPO="https://github.com/$REPO"

# Command Line Tools
# https://apple.stackexchange.com/a/195963
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# Homebrew
if ! command -v brew 2>/dev/null 1>/dev/null; then
  HBURL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
  /bin/bash -c "$(curl -fsSL "$HBURL")"
fi

curl -fsSL "$CFGURL/Brewfile" | brew bundle --file=/dev/stdin

if [ ! -d "$HOME/.cfg" ]; then
  REPO="$GHREPO" curl -fsSL "$CFGURL/checkout.sh"
fi
