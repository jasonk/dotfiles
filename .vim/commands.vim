" Silently execute an external command
" No 'Press Any Key to Continue BS'
" http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
command! -nargs=1 SilentCmd
    \ | execute ':silent !'.<q-args>
    \ | execute ':redraw!'
