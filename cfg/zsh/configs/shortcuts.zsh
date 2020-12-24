# If you are typing a long command and find that you should have run
# something else first, you can press ctrl-Q, which will push the
# current command onto the buffer stack and return to the prompt.
# After you run the other command, the one you stored will get popped
# off the stack and populated back into the prompt.
bindkey "^Q" push-input
