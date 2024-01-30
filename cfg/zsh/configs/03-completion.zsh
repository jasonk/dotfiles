# load completions
autoload -U zutil
autoload compinit && {
  autoload -U complist
  compinit -i -d "$CACHE/zcompdump"
}

setopt auto_menu
setopt auto_remove_slash
setopt complete_in_word
setopt always_to_end
setopt glob_complete
unsetopt list_beep

zstyle ':completion:*' completer _expand_alias _complete _match _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:*:kill:*:processes' \
  list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command "ps -eo pid,user,comm,cmd -w -w"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$CACHE/completions/"
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
  max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:history-words:*' remove-all-dups true

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:*:git-fetch:argument-rest:' \
  tag-order '!remote-repositories'
zstyle ':completion:*:*:git-pull:argument-1:' \
  tag-order '!remote-repositories'

zstyle ':completion:*:(ssh|scp|sftp|rsync):*:users' users "$USERNAME" root
# ssh: reorder output sorting: user over hosts
zstyle ':completion::*:ssh:*:*' tag-order "users hosts"

# Host completion
_custom_hosts() {
  # Complete ~/.zsh/local/hosts.*
  local host
  for host in "$ZSH"/local/hosts.*(N-.); do
    _wanted hosts expl "remote host name" compadd "$@" $(<$host)
  done
}
zstyle -e ':completion:*' hosts '_custom_hosts "$@"'

# Don't use known_hosts_file (slow)
#zstyle ":completion:*:hosts" known-hosts-files ''

# In menu, select items with +
zmodload -i zsh/complist
bindkey -M menuselect "+" accept-and-menu-complete

# automatically rehash commands if completion fails
# http://www.zsh.org/mla/users/2011/msg00531.html
zstyle ':completion:*' rehash true

## for all completions: menuselection
#zstyle ':completion:*' menu select=1
#
## for all completions: grouping the output
#zstyle ':completion:*' group-name ''
#
# for all completions: color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# for all completions: selected item
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;47

# completion of .. directories
zstyle ':completion:*' special-dirs true

## fault tolerance
#zstyle ':completion:*' completer _complete _correct _approximate
## (1 error on 3 characters)
##zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# case insensitivity
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'

# for all completions: grouping / headline / ...
zstyle ':completion:*:messages' \
  format $'\e[01;35m -- %d -- \e[00;00m'
zstyle ':completion:*:warnings' \
  format $'\e[01;31m -- No Matches Found -- \e[00;0#m'
zstyle ':completion:*:descriptions' \
  format $'\e[01;33m -- %d -- \e[00;00m'
zstyle ':completion:*:corrections' \
  format $'\e[01;33m -- %d -- \e[00;00m'

# statusline for many hits
zstyle ':completion:*:default' \
  select-prompt $'\e[01;35m -- Match %M    %P -- \e[#00;00m'

# for all completions: show comments when present
zstyle ':completion:*' verbose yes

## case-insensitive -> partial-word (cs) -> substring completion:
#zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'  

# ~dirs: reorder output sorting: named dirs over userdirs
zstyle ':completion::*:-tilde-:*:*' group-order named-directories users

## kill: advanced kill completion
#zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
#zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

zstyle :compinstall filename '~/.zshrc'

# http://www.smallbulb.net/2018/797-zsh-completion-with-visual-hints
LISTMAX=0
unsetopt LIST_AMBIGUOUS MENU_COMPLETE COMPLETE_IN_WORD
setopt AUTO_MENU AUTO_LIST LIST_PACKED
unambigandmenu() {
  echo -n "\e[31m...\e[0m"
  # avoid opening the list on the first expand
  unsetopt AUTO_LIST
  zle expand-or-complete
  setopt AUTO_LIST
  zle magic-space
  zle backward-delete-char
  zle expand-or-complete
  zle redisplay
}
zle -N unambigandmenu
bindkey "^i" unambigandmenu
