"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for Perl
"-------------------------------------------------------------------------------
 noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

let tlist_perl_settings  = 'perl;c:constants;l:labels;s:subroutines;d:POD'

let g:Perl_NoKeyMappings = 1

let g:gitgutter_sign_removed_first_line = "^_"
