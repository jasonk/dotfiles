export CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"

ZSH_DIR="$(dirname "${(%):-%x}")"

# add an autoload function path, if directory exists
# http://www.zsh.org/mla/users/2002/msg00232.html
fpath=(
  $ZSH_DIR/functions
  $ZSH_DIR/completions
  $fpath
)
autoload -U $ZSH_DIR/functions/*(:t)

path=( "$ZSH_DIR/bin" $path )

unlimit
limit stack 8192
limit core 0
limit -s

umask 022

# Reload autoloaded functions
freload() for i; do unfunction $i; autoload -U $i; done

source_all() { for config ($ZSH_DIR/$1/*.zsh) source $config }

source_all libs
source_all configs
for module ($ZSH_DIR/modules/*) source $module/init.zsh

case "$OSTYPE" in
  darwin*) source_all configs/mac  ;;
  linux*) source_all configs/linux ;;
esac

autoload -U promptinit
promptinit
prompt jasonk

# This sets the default keymap to 'emacs', which allows you to use
# things like ctrl-A/ctrl-E for beginning-of-line/end-of-line.  Zsh by
# default will use the 'vi' keymap if you have `$EDITOR` or `$VISUAL`
# set to anything that matches `*vi*`.  If you really do want the vi
# keymap, just change this to `bindkey -v`.
bindkey -e
