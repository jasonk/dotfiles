" Branch release
" Plugin 'neoclide/coc.nvim'
" PostInstall cd ~/.config/coc/extensions && npm install
" NotPostInstall cd ~/.config/coc/extensions && npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-tsserver coc-json coc-html coc-css coc-snippets


:hi Pmenu ctermbg=black ctermfg=white
:hi Ignore ctermbg=black ctermfg=grey
:hi CocListFgBlack ctermbg=black ctermfg=grey

" :hi CocFloating ctermbg=color
" :hi CocErrorFloat ctermfg=color

:nmap <silent> <Leader>j :call CocAction('diagnosticNext')<cr>
:nmap <silent> <Leader>k :call CocAction('diagnosticPrevious')<cr>


:nmap <silent> <Leader>t :call CocAction('doHover')<cr>
":nmap <silent> <Leader>t :call <SID>show_documentation()<cr>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
