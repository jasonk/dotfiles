# shellcheck shell=bash disable=SC2034
# set prompt stuff for interactive shells

if [ "$PS1" ]; then
  RED="\[\033[0;31m\]"
  LIGHT_RED="\[\033[1;31m\]"
  GREEN="\[\033[0;32m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
  BLUE="\[\033[0;34m\]"
  LIGHT_BLUE="\[\033[1;34m\]"

  GRAY="\[\033[0;37m\]"
  WHITE="\[\033[1;37m\]"
  RESET="\[\033[0m\]"
  BOLD=$(tput bold)
  NORMAL=$(tput sgr0)
  TITLEBAR=''
  case "$TERM" in
    rxvt|*xterm*)   TITLEBAR='\[\033]0;\u@\h:\W\007\]' ;;
  esac

  function prompt_git_branch {
    local ref
    ref="$(git symbolic-ref HEAD 2>/dev/null)"
    if [ -z "$ref" ]; then return; fi
    echo " ${ref#refs/heads/}"
  }
  function set_prompt {
    PROMPT="\u@\h:\W$BLUE$(prompt_git_branch) $GRAY"
    PS1="$TITLEBAR${GRAY}[$PROMPT$GRAY]\\$ $RESET"
    # Save the history after every line
    history -a
  }
  if ! [[ "$PROMPT_COMMAND" =~ set_prompt ]]; then
    PROMPT_COMMAND="set_prompt;$PROMPT_COMMAND"
  fi
fi
