# https://github.com/maxgoedjen/secretive
DATA="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data"
if [ -S "$DATA/socket.ssh" ]; then export SSH_AUTH_SOCK="$DATA/socket.ssh"; fi

