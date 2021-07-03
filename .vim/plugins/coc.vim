" Branch release
" Plugin 'neoclide/coc.nvim'
" PostInstall cd ~/.config/coc/extensions && npm install
" NotPostInstall cd ~/.config/coc/extensions && npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-tsserver coc-json coc-html coc-css coc-snippets


:hi Pmenu ctermbg=black

" :hi CocFloating ctermbg=color
" :hi CocErrorFloat ctermfg=color

:nmap <silent> <Leader>j :call CocAction('diagnosticNext')<cr>
:nmap <silent> <Leader>k :call CocAction('diagnosticPrevious')<cr>
