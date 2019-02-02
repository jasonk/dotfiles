augroup MyAutoCommands
autocmd!

" If vim is run without arguments, open the last opened file
autocmd VimEnter * nested if argc() == 0 && bufname("%") == ""
    \  && bufname("2") + 0 != "" | exe("normal `0") | endif

" Change the working directory to the directory containing the current file
autocmd BufEnter * :lcd %:p:h

" No formatting on o key newlines
autocmd BufNewFile,BufEnter * set formatoptions-=o

" When editing a file, always jump to the last cursor position.
" This must be after the uncompress commands.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line ("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Fix trailing whitespace in my most used programming langauges
autocmd BufWritePre *.py,*.coffee,*.rb,*.erb,*.md,*.scss,*.vim,Cakefile,
    \*.hbs
    \ silent! :StripTrailingWhiteSpace

" Help mode bindings
" <enter> to follow tag, <bs> to go back, and q to quit.
" From http://ctoomey.com/posts/an-incremental-approach-to-vim/
autocmd filetype help nnoremap <buffer><cr> <c-]>
autocmd filetype help nnoremap <buffer><bs> <c-T>
autocmd filetype help nnoremap <buffer>q :q<CR>

" Fix accidental indentation in html files
" http://morearty.com/blog/2013/01/22/fixing-vims-indenting-of-html-files/
"autocmd FileType html setlocal indentkeys-=*<Return>

" Leave the return key alone when in command line windows, since it's used
" to run commands there.
autocmd! CmdwinEnter * :unmap <cr>
autocmd! CmdwinLeave * :call MapCR()

" Resize splits when the window is resized
" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
au VimResized * :wincmd =

"Turn on spell-checking for git commit messages
autocmd BufRead COMMIT_EDITMSG setlocal spell!

"When writing a file that starts with a hashbang, automatically make it
"executable
au bufwritepost * if getline(1) =~ "^#!\&.*/bin/"
    \ | silent !chmod a+x <afile> | endif
augroup END
