# Alter window title

# https://github.com/ohmyzsh/ohmyzsh/blob/58ff4e1d2e6a81ea97a05b142c28a931a9924b70/lib/termsupport.zsh

autoload add-zsh-hook

title() {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  # ESC]0;stringBEL -- Set icon name and window title to string.
  # ESC]1;stringBEL -- Set icon name to string.
  # ESC]2;stringBEL -- Set window title to string

  # Don't set title over serial console.
  case $TTY in
    /dev/ttyS[0-9]*) return;;
  esac

  if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    # Set title atomically in one print statement so that it works
    # when XTRACE is enabled.
    print -Pn "\e]1;${1:q}\a\e]2;${2:q}\a"
  else
    case "$TERM" in
      cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
        print -Pn "\e]1;${1:q}\a\e]2;${2:q}\a"
        ;;
      screen*|tmux*) print -Pn "\ek${1:q}\e\\" ;;
      *)
        # Try to use terminfo to set the title
        # If the feature is available set title
        if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
          echoti tsl
          print -Pn "$1"
          echoti fsl
        fi
        ;;
    esac
  fi
}

# TODO?
#if [[ ! -x $HOME/.cache/title ]] || \
#  (( $EPOCHSECONDS - $(zstat +mtime $HOME/.cache/title) > 60*60*24 )); then
#cat <<EOF > $HOME/.cache/title
##!/bin/zsh
#$(which title)
#title "\$@"
#EOF
#  chmod +x $HOME/.cache/title
#fi

_jasonk_title_preexec() {
  emulate -L zsh
  setopt extended_glob

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

add-zsh-hook preexec _jasonk_title_preexec
