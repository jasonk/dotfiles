# Good Zsh References #

http://www.bash2zsh.com/zsh_refcard/refcard.pdf


## Debugging ##

Do `set -x` to turn on tracing, or `zsh -x` to enable it at startup.
Or do `functions -t foo` to trace a single function.

Also zsh has a profiler, put `zmodload zsh/zprof` at the top of your
`zshrc` then say `zprof` to get a printout of which functions the
shell is spending all its time in.
