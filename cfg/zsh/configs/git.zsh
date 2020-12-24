if (( $+commands[hub] )); then alias git=hub; fi
if (( $+commands[gh] )) ; then eval "$(gh completion -s zsh)"; fi
