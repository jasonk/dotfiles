autoload -U zsh/terminfo zsh/termcap

() {
  local term
  local -aU terms

  # Special case when running as Emacs, dumb doesn't have a terminfo
  # entry, try dumb-emacs-ansi instead.
  if [[ $TERM = dumb ]] && [[ -n $INSIDE_EMACS ]]; then
    LC__ORIGINALTERM=dumb-emacs-ansi
  fi

  terms=(
    $LC__ORIGINALTERM           # Received by SSH (see ssh.rc)
    # Current TERM with -256color appended when over SSH
    ${SSH_CONNECTION+${TERM%-256color}-256color}
    $TERM                       # Current TERM
    ${TERM%-256color}           # Current TERM without -256color
    xterm-256color              # Well-known TERM
    xterm                       # Even more well-known TERM
  )

  for term in $terms; do
    TERM=$term 2> /dev/null
    if (( ${terminfo[colors]:-0} >= 8 )) || \
      (zmodload zsh/termcap 2> /dev/null) && \
      (( ${termcap[Co]:-0} >= 8)); then
      autoload colors && colors
      break
    fi
  done
  unset LC__ORIGINALTERM
  export TERM
}

# Keep Apple Terminal.app's current working directory updated
# Based on this answer: https://superuser.com/a/315029
# With extra fixes to handle multibyte chars and non-UTF-8 locales

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  function _terminalapp_urlencode() {
    emulate -L zsh
    setopt extendedglob
    local input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
  }
  # Emits the control sequence to notify Terminal.app of the cwd
  # Identifies the directory using a file: URI scheme, including
  # the host name to disambiguate local vs. remote paths.
  function update_terminalapp_cwd() {
    emulate -L zsh

    # Percent-encode the host and path names.
    local URL_HOST URL_PATH
    URL_HOST="$(_terminalapp_urlencode $HOST)" || return 1
    URL_PATH="$(_terminalapp_urlencode $PWD)" || return 1

    # Undocumented Terminal.app-specific control sequence
    printf '\e]7;%s\a' "file://$URL_HOST$URL_PATH"
  }

  # Use a precmd hook instead of a chpwd hook to avoid contaminating output
  add-zsh-hook precmd update_terminalapp_cwd
  # Run once to get initial cwd set
  update_terminalapp_cwd
fi

# http://web.mit.edu/~mkgray/jik/sipbsrc/src/zsh-2.5.0/help/ttyctl
ttyctl -f
