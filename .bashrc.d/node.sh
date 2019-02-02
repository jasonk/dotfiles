#!/bin/bash
pathedit --prepend "/usr/local/share/npm/bin"
pathedit --prepend "$HOME/node/bin"

NODE_PATH="$HOME/node/lib/node_modules:$NODE_PATH"
