#!/bin/bash

patheditor_clean_duplicates() {
  local saw=":"
  local nb=${#new[*]}
  local i=0
  for (( i = 0 ; i < nb ; i++ )) do
    local x=${new[$i]}
    if [[ $saw =~ ":$x:" ]]; then unset new[$i]; fi
    saw="$saw:$x"
  done
}
patheditor_clean_missing() {
  local nb=${#new[*]}
  local i=0
  for (( i = 0 ; i < nb ; i++ )) do
    local x=${new[$i]}
    if [[ ! -d $x ]]; then unset new[$i]; fi
  done
}

patheditor() {
  local var=$1; shift;
  local act=$1; shift;

  # extract the current settings
  local full=`eval echo \\\$$var`;
  local oldifs=$IFS
  IFS=":"
  local -a new=($full)
  IFS=$oldifs

  case "$act" in
    --append)
      new=( ${new[@]} $@ )
      ;;
    --prepend)
      new=( $@ ${new[@]} )
      ;;
    --replace)
      new=( $@ )
      ;;
    --before)
      local nb=${#new[*]}
      local i=0
      local -a newerlist
      local before="$1" ; shift
      local did=0
      for (( i = 0 ; i < nb ; i++ )) do
        local x=${new[$i]}
        if [ "$x" = "$before" ]; then
          newerlist=( ${newerlist[@]} $@ )
          did=1
        fi
        newerlist[${#newerlist[@]}]=${new[$i]}
      done
      if [ $did -eq 0 ]; then
        newerlist=( ${newerlist[@]} $@ )
      fi
      new=( ${newerlist[@]} )
      ;;
    --after)
      local nb=${#new[*]}
      local i=0
      local -a newerlist
      local after="$1" ; shift
      local did=0
      for (( i = 0 ; i < nb ; i++ )) do
        local x=${new[$i]}
        newerlist[${#newerlist[@]}]=${new[$i]}
        if [ "$x" = "$after" ]; then
          newerlist=( ${newerlist[@]} $@ )
          did=1
        fi
      done
      if [ $did -eq 0 ]; then
        newerlist=( ${newerlist[@]} $@ )
      fi
      new=( ${newerlist[@]} )
      ;;
    --clean-duplicates) patheditor_clean_duplicates ;;
    --clean-missing)
      ;;
    --cleanup)
      local saw=":"
      local nb=${#new[*]}
      local i=0
      for (( i = 0 ; i < nb ; i++ )) do
        local x=${new[$i]}
        if [[ ! -d $x ]]; then
          unset new[$i]
        elif [[ $saw =~ ":$x:" ]]; then
          unset new[$i]
        fi
        saw="$saw:$x"
      done
      ;;
  esac

  IFS=":"
  echo "export $var=\"${new[*]}\""
  IFS=$oldifs
}

pathedit() {
  eval `patheditor PATH "$@"`
}
manpathedit() {
  eval `patheditor MANPATH "$@"`
}
perl5libedit() {
  eval `patheditor PERL5LIB "$@"`
}
fignoreedit() {
  eval `patheditor FIGNORE "$@"`
}
cdpathedit() {
  eval `patheditor CDPATH "$@"`
}
