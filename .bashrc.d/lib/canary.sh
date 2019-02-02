# This function checks for a canary string (## END OF FILE ##) and
# warns if the canary does not appear on the last line of the file.
# This helps to detect when automated installers modify your
# initialization files without asking.
#
# The naughty list so far:
#   rvm
#   Heroku Toolbelt
#   Sencha Cmd
check_canary() {
  for FILE in "$@"; do
    local CANARY="$(tail -1 "$FILE")"
    if [[ $CANARY != "## END OF FILE ##" ]]; then
      warn "Canary missing from $FILE!"
      warn "Content added to file starts with:"
      egrep -A5 "## END OF FILE ##" "$FILE" \
        | grep -v '## END OF FILE ##'
    fi
  done
}

