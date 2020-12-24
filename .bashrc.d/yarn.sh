#!/bin/bash

if have_cmd yarn; then
  pathedit --prepend "$(yarn global dir)/node_modules/.bin"
fi
