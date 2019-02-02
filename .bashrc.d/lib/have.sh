#!/bin/bash

# To use this from one of your .bashrc.d scripts:
# if have cmd 'foo'; then ...; fi
# if have file /path/to/file; then ...; fi

have() {
  local TYPE="$1"
  local WHAT="$2"
  case "$TYPE" in
    cmd|command)
      command -v "$WHAT" >/dev/null
      return $?
      ;;
    file)
      test -f "$WHAT" >/dev/null
      return $?
      ;;
    dir|directory)
      test -d "$WHAT" >/dev/null
      return $?
      ;;
    *)
      echo "Error: Invalid type ($TYPE) for have()" 1>&2
      return 1
      ;;
  esac
}
