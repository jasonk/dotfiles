# Append each command to .zsh_history as it's used, to provide
# a shared history file of all commands.
setopt INC_APPEND_HISTORY

# Even though we are using a shared history file, we turn this off so
# that individual sessions don't read new entries from the file.  This
# means that .zsh_history will contain a record of all the commands
# run in every session, but while sessions are running they will
# maintain their own histories.
unsetopt SHARE_HISTORY

# Ignore all duplicate entries in the history file
setopt HIST_IGNORE_ALL_DUPS

# Save command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=30000
SAVEHIST=30000

# Ctrl-r search in the history with patterns
if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey '^r' history-incremental-pattern-search-backward
fi
