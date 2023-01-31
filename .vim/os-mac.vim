" Don't do this, it causes problems as described here:
" https://github.com/neovim/neovim/issues/2093#issuecomment-89594661
"" Fix meta key for Mac
"let c='a'
"while c <= 'z'
"    exec "set <A-".c.">=\e".c
"    exec "imap \e".c." <A-".c.">"
"    let c = nr2char(1+char2nr(c))
"endw
