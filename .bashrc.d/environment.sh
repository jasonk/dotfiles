shopt -s checkwinsize
shopt -s histappend # append to the history file instead of overwriting it

ulimit -S -c 0

export USER="`id -un`"
export LOGNAME=$USER
export HOSTNAME=`/bin/hostname`
export HISTSIZE=1000

pathedit --prepend $HOME/bin
pathedit --append /usr/local/bin /usr/local/sbin /opt/local/bin /opt/local/sbin /usr/sbin /sbin
manpathedit --append /usr/local/man /opt/local/share/man /usr/share/man
unset MAILCHECK
export LANG="en_US.UTF-8"
export TZ=EST5EDT
#export LESS=isR
#export LESS=FiRWx4XS
export LESS=FiRWx4X
export LESSOPEN="|lesspipe.sh %s"
export FIGNORE=".o:.swp"
export PAGER=less

umask 0022

function ttyreset() {
    # Make the cursor visible if something has hidden it
    echo -en "\033[?25h"
    # Run the regular reset command
    /usr/bin/reset
}
