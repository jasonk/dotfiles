#!/bin/bash

#FILES=(
#  /usr/local/etc/bash_completion
#  /usr/local/etc/profile.d/bash_completion.sh
#)

if [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
 source /usr/local/etc/profile.d/bash_completion.sh
fi
#for F in "${FILES[@]}"; do
#  # shellcheck disable=SC1090
#  [[ -r "$F" ]] && source "$F"
#done

# /usr/local/etc/bash
