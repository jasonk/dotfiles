" Silently execute an external command
" No 'Press Any Key to Continue BS'
" http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
command! -nargs=1 SilentCmd
    \ | execute ':silent !'.<q-args>
    \ | execute ':redraw!'

" copy current file name (relative/absolute) to system clipboard
" from http://stackoverflow.com/a/17096082/22423
" relative path  (src/foo.txt) (yp = yank path)
nnoremap <silent> <leader>yp :let @*=expand("%")<CR>

" absolute path  (/something/src/foo.txt) (yP = yank Path)
nnoremap <silent> <leader>yP :let @*=expand("%:p")<CR>

" filename       (foo.txt) (yf=yank filename)
nnoremap <silent> <leader>yf :let @*=expand("%:t")<CR>

" directory name (/something/src) (yd=yank directory)
nnoremap <silent> <leader>yd :let @*=expand("%:p:h")<CR>
