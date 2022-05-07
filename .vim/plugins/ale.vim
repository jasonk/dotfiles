" Disable 'dense-analysis/ale'

let g:ale_linters = {
  \ 'javascript': [ 'eslint' ],
  \ 'typescript': [ 'eslint', 'tsserver' ]
  \ }

let g:ale_fixers = {
  \ 'javascript': [ 'eslint' ],
  \ 'typescript': [ 'eslint', 'tsserver' ]
  \ }

let g:ale_linters_ignore = {
  \ 'typescript' : [ 'tslint' ],
  \ }

let g:ale_completion_enabled = 1

let g:ale_completion_autoimport = 1

nnoremap <silent> <leader>af :ALEFix<CR>
nnoremap <silent> <leader>al :ALELint<CR>
nnoremap <silent> gd         :ALEGoToDefinition<CR>

nnoremap <F11> :ALEToggleBuffer<CR>

let g:ale_sign_info    = 'I>'
let g:ale_sign_warning = 'W>'
let g:ale_sign_error   = 'E>'

nmap <silent> <leader>j :ALENext<CR>
nmap <silent> <leader>k :ALEPrevious<CR>
nmap <silent> <leader>ej :ALENext -error<CR>
nmap <silent> <leader>ek :ALEPrevious -error<CR>
nmap <silent> <leader>wj :ALENext -warning<CR>
nmap <silent> <leader>wk :ALEPrevious -warning<CR>
nmap <silent> <leader>ij :ALENext -info<CR>
nmap <silent> <leader>ik :ALEPrevious -info<CR>

let g:ale_set_highlights = 1
let g:ale_fixers         = {
      \ '*'          : [ 'remove_trailing_lines', 'trim_whitespace' ],
      \ 'sh'         : [ 'shfmt'                                    ],
      \ 'bash'       : [ 'shfmt'                                    ],
      \ 'javascript' : [ 'eslint'                                   ],
      \ 'typescript' : [ 'eslint'                                   ],
      \ 'markdown'   : [ 'prettier'                                 ],
      \ 'yaml'       : [ 'prettier'                                 ],
      \ 'json'       : [ 'prettier'                                 ],
      \ 'go'         : [ 'goimports'                                ],
      \ 'rust'       : [ 'rustfmt'                                  ],
      \ 'ruby'       : [ 'rubocop'                                  ],
      \ 'graphql'    : [ 'prettier'                                 ],
      \ 'hcl'        : [ 'terraform'                                ],
      \ 'terraform'  : [ 'terraform'                                ],
      \ 'html'       : [ 'prettier'                                 ],
      \ }
