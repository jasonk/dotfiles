if (( $+commands[gh] )) ; then eval "$(gh completion -s zsh)"; fi

alias glp="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# The old way to ignore system config files
export GIT_CONFIG_NOSYSTEM=1
# The new way
export GIT_CONFIG_SYSTEM=/dev/null
