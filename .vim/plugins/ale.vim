" Plugin 'w0rp/ale'

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
