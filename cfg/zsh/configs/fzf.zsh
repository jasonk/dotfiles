if (( $+commands[brew] )); then
  [[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi
