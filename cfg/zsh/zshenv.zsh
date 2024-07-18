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

# More specificially:
#
# /etc/zshenv   - Every shell. Always loaded
# ~/.zshenv     - Every shell, unless using -f
# /etc/zprofile - if it's a login shell
# ~/.zprofile   - if it's a login shell
# /etc/zshrc    - if it's an interactive shell
# ~/.zshrc      - if it's an interactive shell
# /etc/zlogin   - if it's a login shell
# ~/.zlogin     - if it's a login shell

# Don't load global configs, which break our path
setopt noglobalrcs

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
  "$HOME/.local/bin"
  "$HOME/.yarn/.bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  "$HOME/.docker/bin"
  "$HOME/.cargo/bin"
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /System/Cryptexes/App/usr/bin
)

export ZSH_CACHE="$HOME/.cache/zsh"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

if [ -d ~/.env ]; then
  set -o allexport;
  for file ( ~/.env/*.env ) source "$file"
  set +o allexport
  for file ( ~/.env/*.sh ) source "$file"
fi
