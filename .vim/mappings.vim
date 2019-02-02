" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

" Find the next merge conflict marker
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Yank entire buffer with gy
nnoremap gy :0,$ y<cr>

" Select entire buffer
nnoremap vy ggVG

" Make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" ---------------
" Window Movement
" ---------------
nnoremap <silent> gh :WriteBufferIfNecessary<CR>:wincmd h<CR>
nnoremap <silent> <M-h> :wincmd h<CR>
nnoremap <silent> gj :WriteBufferIfNecessary<CR>:wincmd j<CR>
nnoremap <silent> gk :WriteBufferIfNecessary<CR>:wincmd k<CR>
nnoremap <silent> <M-k> :wincmd k<CR>
nnoremap <silent> gl :WriteBufferIfNecessary<CR>:wincmd l<CR>
nnoremap <silent> <M-l> :wincmd l<CR>

"   4 Window Splits
"
"   -----------------
"   g1 | g2 | g3 | g4
"   -----------------
nnoremap <silent> g1 :WriteBufferIfNecessary<CR>:wincmd t<CR>
nnoremap <silent> g2 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<CR>
nnoremap <silent> g3 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<bar>
      \:wincmd l<CR>
nnoremap <silent> g4 :WriteBufferIfNecessary<CR>:wincmd b<CR>

" Equal Size Windows
nnoremap <silent> g= :wincmd =<CR>
" Swap Windows
nnoremap <silent> gx :wincmd x<CR>

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" map F2 to the menu
map <F2> :emenu <C-Z>

" Made a bunch of changes, then found out you need to be root to write them?
" " No problem, just :w!! to rerun it through sudo
cmap w!! w !sudo tee % >/dev/null

" make j and k still move a line at a time even if the current line spans
" multiple window lines (jump to the next row in the editor, rather than
" the next actual line of text)
nnoremap j gj
nnoremap k gk

" use ctrl+[hjkl] to move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Make line completion easier.
inoremap <C-l> <C-x><C-l>

" Scroll larger amounts with C-j / C-k
"nnoremap <C-j> 15gjzz
"nnoremap <C-k> 15gkzz
"vnoremap <C-j> 15gjzz
"vnoremap <C-k> 15gkzz

" Highlight search word under cursor without jumping to next
nnoremap <leader>h *<C-O>

" Toggle spelling mode with ,s
nnoremap <silent> <leader>s :set spell!<CR>

" Quickly switch to last buffer
nnoremap <leader>, :e#<CR>

" Underline the current line with '-'
nnoremap <silent> <leader>ul :t.\|s/./-/\|:nohls<cr>

" Underline the current line with '='
nnoremap <silent> <leader>uul :t.\|s/./=/\|:nohls<cr>

" Surround the commented line with lines.
"
" Example:
"          # Test 123
"          becomes
"          # --------
"          # Test 123
"          # --------
nnoremap <silent> <leader>cul :normal "lyy"lpwvLr-^"lyyk"lP<cr>

" Format the entire file
nnoremap <leader>fef mx=ggG='x

" Format a json file with Underscore CLI
" Inspirited by https://github.com/spf13/spf13-vim/blob/3.0/.vimrc#L390
nnoremap <leader>gj <Esc>:%!underscore print<CR><Esc>:set filetype=json<CR>

" Split window vertically or horizontally *and* switch to the new split!
nnoremap <silent> <leader>hs :split<Bar>:wincmd j<CR>:wincmd =<CR>
nnoremap <silent> <leader>vs :vsplit<Bar>:wincmd l<CR>:wincmd =<CR>

" Close the current window
nnoremap <silent> <m-w> :close<CR>

" Allow ctrl-Q to quit the editor
nmap  <C-q>    :wqa<CR>

"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
"
map  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly &&
    \ &modified <CR> :write<CR> :endif<CR>:bnext<CR>
imap  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly &&
    \ &modified <CR> :write<CR> :endif<CR>:bnext<CR>

" Disable the ever-annoying Ex mode shortcut key. Type visual my ass. Instead,
" make Q repeat the last macro instead. *hat tip* http://vimbits.com/bits/263
nnoremap Q @@

" This prevents vim from moving comments to the left edge, leaving them
" indented instead...
inoremap # X#

" Removes doc lookup mapping because it's easy to fat finger and never useful.
nnoremap K k
vnoremap K k

" Toggle paste mode with F5
nnoremap <silent> <F5> :set paste!<CR>

" Paste and select pasted
nnoremap <expr> gpp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Paste and select pasted
nnoremap gp :normal pgp<cr>

" swap the ` and ' keys, since ` is more useful, but off in the corner
nnoremap ' `
nnoremap ` '

" space bar folding - hit space to fold/unfold (if a fold exists there)
nnoremap <silent> <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

" http://www.vim.org/tips/tip.php?tip_id=1
" let * and # search within the visual selection
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>
" and let <cr> in normal mode clear the hlsearch value
nnoremap <cr> :noh<cr>:<bs><cr>

inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

nnoremap <F11> :ALEToggleBuffer<CR>
nnoremap <F12> :call g:ToggleSimplification()<CR>

"map   <silent> <F2>    :write<CR>
"map   <silent> <F3>    :Explore<CR>
"nmap  <silent> <F4>    :exe ":ptag ".expand("<cword>")<CR>
"map   <silent> <F6>    :copen<CR>
"map   <silent> <F7>    :cp<CR>
"map   <silent> <F8>    :cn<CR>
"map   <silent> <F12>   :let &number=1-&number<CR>

"imap  <silent> <F2>    <Esc>:write<CR>
"imap  <silent> <F3>    <Esc>:Explore<CR>
"imap  <silent> <F4>    <Esc>:exe ":ptag ".expand("<cword>")<CR>
"imap  <silent> <F6>    <Esc>:copen<CR>
"imap  <silent> <F7>    <Esc>:cp<CR>
"imap  <silent> <F8>    <Esc>:cn<CR>
"imap  <silent> <F12>   :let &number=1-&number<CR>

" make tab in visual mode indent the block
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode change indent
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" Let C-k and C-j navigate the ALE fixlist
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
