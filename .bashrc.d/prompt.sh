#!/bin/bash
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
        local ref=$(git symbolic-ref HEAD 2>/dev/null) || return
        echo " ${ref#refs/heads/}"
    }
    function set_prompt {
        local LAST_STATUS=$?
        if [ $LAST_STATUS -eq 0 ]; then
            LAST_STATUS=$GREEN$LAST_STATUS
        else
            LAST_STATUS=$RED$LAST_STATUS
        fi
        PROMPT="\u@\h:\W$BLUE$(prompt_git_branch) $LAST_STATUS$GRAY"
        PS1="$TITLEBAR$GRAY[$PROMPT$GRAY]\\$ $RESET"
        # Save the history after every line
        history -a
    }
    if ! [[ "$PROMPT_COMMAND" =~ set_prompt ]]; then
      PROMPT_COMMAND="set_prompt;$PROMPT_COMMAND"
    fi


#    function set_prompt {
#        local vcs base_dir sub_dir ref last_command
#        last_status=$?
#        local gray="\[\033[0;37m\]"
#        local red="\[\033[0;31m\]"
#        local green="\[\033[0;32m\]"
#        local reset="\[\033[0m\]"
#
#        if [ $last_status == 0 ]; then
#            status_color=$green
#        else
#            status_color=$red
#        fi
#
#        sub_dir() {
#            local sub_dir
#            sub_dir=$(stat -f "${PWD}")
#            sub_dir=${sub_dir#$1}
#            echo ${sub_dir#/}
#        }
#
#        git_dir() {
#            base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
#            if [ -n "$base_dir" ]; then
#                base_dir=`cd $base_dir; pwd`
#            else
#                base_dir=$PWD
#            fi
#            sub_dir=$(git rev-parse --show-prefix)
#            sub_dir="/${sub_dir%/}"
#            ref=$(git symbolic-ref -q HEAD || git name-rev --name-only HEAD 2>/dev/null)
#            ref=${ref#refs/heads/}
#            vcs="git"
#            alias pull="git pull"
#            alias commit="git commit -a"
#            alias push="commit ; git push"
#            alias revert="git checkout"
#        }
#
#        svn_dir() {
#            [ -d ".svn" ] || return 1
#            base_dir="."
#            while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
#            base_dir=`cd $base_dir; pwd`
#            sub_dir="/$(sub_dir "${base_dir}")"
#            ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
#            vcs="svn"
#            alias pull="svn up"
#            alias commit="svn commit"
#            alias push="svn ci"
#            alias revert="svn revert"
#        }
#
#        cvs_dir() {
#            [ -d "CVS" ] || return 1
#            base_dir="."
#            while [ -d "$base_dir/../CVS" ]; do base_dir="$base_dir/.."; done
#            base_dir=`cd $base_dir; pwd`
#            sub_dir="/$(sub_dir "${base_dir}")"
#            ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
#            vcs="svn"
#            alias pull="svn up"
#            alias commit="svn commit"
#            alias push="svn ci"
#            alias revert="svn revert"
#        }
#
#        bzr_dir() {
#            base_dir=$(bzr root 2>/dev/null) || return 1
#            if [ -n "$base_dir" ]; then
#                base_dir=`cd $base_dir; pwd`
#            else
#                base_dir=$PWD
#            fi
#            sub_dir="/$(sub_dir "${base_dir}")"
#            ref=$(bzr revno 2>/dev/null)
#            vcs="bzr"
#            alias pull="bzr pull"
#            alias commit="bzr commit"
#            alias push="bzr push"
#            alias revert="bzr revert"
#        }
#        
#        git_dir || svn_dir || bzr_dir
#
#        if [ -n "$vcs" ]; then
#            alias st="$vcs status"
#            alias d="$vcs diff"
#            alias up="pull"
#            alias cdb="cd $base_dir"
#            base_dir="$(basename "${base_dir}")"
#            working_on="$base_dir:"
#            __vcs_prefix="($vcs)"
#            __vcs_ref="[$ref]"
#            __vcs_sub_dir="${sub_dir}"
#            __vcs_base_dir="${base_dir/$HOME/~}"
#        else
#            __vcs_prefix=''
#            __vcs_base_dir="${PWD/$HOME/~}"
#            __vcs_ref=''
#            __vcs_sub_dir=''
#            working_on=""
#        fi
#
#        last_command=$(history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")
##        if [ $last_command = 'set_prompt' ]; then
##            __tab_title="$working_on[$last_command]"
##        else
##            __tab_title="$working_on[$last_command]"
##        fi
#        echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
#        __pretty_pwd="${PWD/$HOME/~}"
#        __status_color=$status_color
#        __last_status=$last_status
#
#        # Save the history after every line
#        history -a
#    }

    #PS1="\[\033[0;37m\][\u@\h \W $status_color$last_status\[\033[0;37m\]]\\$ \[\033[0m\]"
#    PS1='\[\033]2;\h::$__pretty_pwd\a\033]1;$__tab_title\a\]\u:$__vcs_prefix\[${_bold}\]${__vcs_base_dir}\[${_normal}\]${__vcs_ref}\[${_bold}\]${__vcs_sub_dir}\[${_normal}\]\$ '

# Show the currently running command in the terminal title:
# http://www.davidpashley.com/articles/xterm-titles-with-bash.html
#    if [ "$SHELL" = '/bin/bash' ]; then
#        case $TERM in
#            rxvt|*term|xterm-color)
#                set -o functrace
#                #trap 'echo -ne "\033]0;${BASH_COMMAND}\007"' DEBUG
##                #export PS1="\033]0;$TERM\007$PS1"
#            ;;
#        esac
#    fi
#    if [ -z "$TM_SUPPORT_PATH"]; then
#    case $TERM in
#      rxvt|*term|xterm-color)
#        trap 'echo -n "\[\033[1;$working_on>$BASH_COMMAND<\007\c"' DEBUG
#      ;;
#    esac
#    fi
fi
