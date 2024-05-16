if [ -d ~/.docker/bin ]; then
  path+="$HOME/.docker/bin"
  export DOCKER_CLI_HINTS='false'
fi

if [ -d ~/.config/krew ]; then
  path+="$HOME/.config/krew/bin"
fi
