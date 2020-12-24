# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [ -z "$LESSOPEN" ]; then
  if (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
  fi
fi

if [ -z "$LESSOPEN" ]; then
  if [ -f /opt/homebrew/bin/src-hilite-lesspipe.sh ]; then
    export LESSOPEN="| /opt/homebrew/bin/src-hilite-lesspipe.sh %s"
  fi
fi

export READNULLCMD="less"
