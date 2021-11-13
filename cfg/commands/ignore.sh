#!/bin/bash

#$# ignore -- Rebuild the git exclude file
#$# ignore [file..] -- Add files to an ignore list

for file in "$@"; do
  realpath --relative-to="$HOME" "$file" >> "$CFG_DIR/ignores/cli-added"
done
(
  # These patterns are the basis of all the ignore rules.
  # They must be first.
  echo '/*'    # By default ignore everything
  echo '!/.*'  # then unignore all the top-level dotfiles
  echo '/.cfg' # Except we want to keep ignoring the bare .cfg repo
  echo '!/bin' # also unignore our bin directory
  echo '!/cfg' # and our cfg directory
  cat "$CFG_DIR"/ignores/*
) > "$GIT_DIR/info/exclude"
