# Editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

if (( $+commands[gron] )) ; then
  alias norg="gron --ungron"
  alias ungron="gron --ungron"
fi

#vault="$(command -v vault 2>/dev/null)"
#if (( $+commands[vault] )) ; then
  # complete -C "$vault" vault
#fi
