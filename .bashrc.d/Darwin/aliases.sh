# cdf: cd to the directory in the Finder's front window
alias cdf='cd "$(~/bin/posd)"'

# posfind: search the directory frontmost in the Finder
function posfind { find "`~/bin/posd`" -name "*$1*"; }

# posgrep: grep the directory frontmost in the Finder
function posgrep { grep -iIrn "$1" "`~/bin/posd`"; }

alias ls='ls -FG'

alias updatedb='sudo /usr/libexec/locate.updatedb'
