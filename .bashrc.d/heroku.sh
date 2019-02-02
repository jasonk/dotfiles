#!/bin/bash

if [ -d "/usr/local/heroku" ]; then
    pathedit --append /usr/local/heroku/bin
fi
