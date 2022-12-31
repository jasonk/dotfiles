#!/bin/bash
set -eo pipefail
shopt -s nullglob
cd "$(dirname "$0")"

PACKS="pack/jasonk/start"

mkdir -p "$PACKS"

REPOS=()
PLUGINS=()
CMD_RE="^\" *(Plugin|PostInstall|Setup|Disabled|Branch) *'?([^']*)'?$"
is_repo() {
  local value="$1"
  local i
  for i in "${REPOS[@]}"; do
    if [ "${i}" == "${value}" ]; then return 0; fi
  done
  return 1;
}

process() {
  local FILE REPO NAME REPODIR
  FILE="$1"
  REPO=""
  NAME=""
  REPODIR=""
  BRANCH=""
  while IFS='' read -r LINE; do
    if [[ $LINE =~ $CMD_RE ]]; then
      CMD="${BASH_REMATCH[1]}"
      ARG="${BASH_REMATCH[2]}"
      case "$CMD" in
        Disabled) return ;;
        Branch) BRANCH="$ARG" ;;
        Plugin)
          REPO="$ARG"
          NAME="$(basename "$REPO" .vim)"
          REPODIR="$PACKS/$NAME"
          REPOS+=( "$NAME" )
          echo "Installing $NAME into $REPODIR from github:$REPO"
          if [ -d "$REPODIR" ]; then
            (
              cd "$REPODIR"
              if [ -n "${BRANCH:-}" ]; then git checkout "$BRANCH"; fi
              git pull --ff-only --no-rebase
            )
          else
            if [ -n "${BRANCH:=}" ]; then
              git clone -b "$BRANCH" "https://github.com/$REPO" "$REPODIR"
            else
              git clone "https://github.com/$REPO" "$REPODIR"
            fi
          fi
          ;;
        PostInstall)
          echo "Running postinstall for $NAME in $REPODIR"
          ( cd "$REPODIR" && bash -c "$ARG" )
          ;;
        Setup)
          echo "Running setup for $NAME in $REPODIR"
          ( cd "$REPODIR" && vim -u NONE -c "$ARG" -c q )
          ;;
        *) echo "Unknown command $CMD" ;;
      esac
    fi
  done < "$FILE"
  PLUGINS+=( "$FILE" )
}

for FILE in plugins/*.vim; do
  process "$FILE"
done


(
  cd "$PACKS"
  for DIR in *; do
    if ! is_repo "$DIR"; then rm -rf "$DIR"; fi
  done
)

(
  echo '" Do not edit this file!  It is generated by setup.sh'
  for PLUG in "${PLUGINS[@]}"; do echo "source ~/.vim/$PLUG"; done
) > ./plugins.vim
