" copy current file name (relative/absolute) to system clipboard
" from http://stackoverflow.com/a/17096082/22423
" relative path  (src/foo.txt)
nnoremap <silent> <leader>yp :let @*=expand("%")<CR>

" absolute path  (/something/src/foo.txt)
nnoremap <silent> <leader>yP :let @*=expand("%:p")<CR>

" filename       (foo.txt)
nnoremap <silent> <leader>yf :let @*=expand("%:t")<CR>

" directory name (/something/src)
nnoremap <silent> <leader>yd :let @*=expand("%:p:h")<CR>

" Don't do this, it causes problems as described here:
" https://github.com/neovim/neovim/issues/2093#issuecomment-89594661
"" Fix meta key for Mac
"let c='a'
"while c <= 'z'
"    exec "set <A-".c.">=\e".c
"    exec "imap \e".c." <A-".c.">"
"    let c = nr2char(1+char2nr(c))
"endw
