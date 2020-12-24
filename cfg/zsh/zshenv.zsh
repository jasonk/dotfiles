# Defines environment variables.  This is sourced by *all* zsh
# invocations, unless they specify `-f`.  Note that this includes
# scripts that start with `#!/bin/zsh`, so there should not be
# anything in here that assumes that stdio is connected to a terminal
# or that the current process could be interactive.

# This is the first file read by zsh, this is where you should set
# important environment variables that should be the same for *ALL*
# zsh invocations.

# The file load order is:
#   .zshenv (zshenv.zsh)
#   .zshrc (zshrc.zsh)
#   .zlogin (zlogin.zsh)
#   .zlogout (zlogout.zsh)

ulimit -S -c 0
umask 0022

export USER="$(id -un)"
export LOGNAME=$USER
export HOSTNAME="$(/bin/hostname)"

unset MAILCHECK
export FIGNORE=".o:.swp"

if [[ -z "$LANG" ]]; then export LANG='en_US.UTF-8'; fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  "$HOME/bin"
  "$HOME/.yarn/.bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  $path
)

export ZSH_CACHE="$HOME/.cache/zsh"
