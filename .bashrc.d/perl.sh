# shellcheck shell=bash disable=SC1090
if [ -d "$HOME/perl5/perlbrew" ]; then . "$HOME/perl5/perlbrew/etc/bashrc"; fi
perl5libedit --prepend "$HOME/lib"
