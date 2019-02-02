filetype plugin indent on

set softtabstop=2       " set the soft tab stop level to 2
set tabstop=2           " set the tab stop level
set shiftwidth=2        " shifting is 2 spaces as well (for ai, >>, <<, etc)
set shiftround          " use multiple of shiftwidth when indenting with < and >
set expandtab           " expand tabs to spaces
set cindent             " disable c-indenting
set smartindent         " enable smart indenting
set smarttab            " make tab/bs at the beginning of a line use shiftwidth
set copyindent          " copy the previous indent when autoindenting
set showmatch           " show matching parenthesis
set matchtime=2         " tenths of a second to blink
set background=dark     " let vim know I use a dark background terminal
set viminfo='20,\"50    " keep a .viminfo file, limit to 50 entries
set ruler               " always show the cursor position
set number              " Show line numbers
set ignorecase          " ignore case when searching...
set smartcase           " unless the thing being searched for has a capital
set pastetoggle=<F9>    " use F9 to toggle paste mode
set foldmethod=indent   " syntax markers specify folding...
set modelines=1         " modelines have security issues
set hlsearch            " hilight search matches
set autoread            " read open files again when changed outside Vim
set autowrite           " write a modified buffer on each :next , ...
set browsedir=current   " which directory to use for the file browser
set incsearch           " use incremental search
"set nowrap              " do not wrap lines
set laststatus=2        " always show status
set title               " set xterm window title
set encoding=utf8       " encoding
set visualbell          " visual bell instead of beeping
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set shortmess=atI
set lazyredraw
set magic
set noautoindent

"set mousehide           " hide mouse when typing
"set mouse=a             " enable mouse in all modes

" Better complete options to speed it up
set complete=.,w,b,u,U

set cpo-=<                  " enable recognition of special key codes in <>
set wcm=<C-Z>               " wildchar for activiting inside a macro

if $TERM =~ '-256color'
    set t_Co=256
endif

set directory=~/.vim/.tmp//
set spellfile=~/.vim/spell/custom.en.utf-8.add
" Persistent Undo
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/.undo
endif

if exists('+colorcolumn')
    set colorcolumn=80 " Color column 80 differently as a wrapping guide
endif

syntax enable           " syntax coloring
syntax sync fromstart   " always resync syntax hilighting from the beginning

" show invisible characters
set list listchars=trail:_,tab:__,precedes:<,extends:>,nbsp:_
if has( 'multi_byte' )
    set listchars=trail:•,tab:▸•,precedes:«,extends:»,nbsp:▢
endif

set backup             " Turn on backups
set backupdir=~/.vim/.backup// " Double // causes backups to use full file path

set wildmenu           " Turn on WiLd menu
" longest common part, then all.
set wildmode=longest,full
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" dictionary autocompletion, use ctrl-N to complete the current word
set dictionary+=/usr/share/dict/words

set hidden             " Change buffer - without saving
set history=768        " Number of things to remember in history.
set confirm            " Enable error files & error jumping.
set clipboard^=unnamed " Yanks go on clipboard instead.
set timeoutlen=400     " Time to wait for a command (after leader for example).
set ttimeout
set ttimeoutlen=100    " Time to wait for a key sequence.
set nofoldenable       " Disable folding entirely.
set foldlevelstart=99  " I really don't like folds.
" :help fo-table
" set formatoptions=rql1j
set formatoptions=rql1
set iskeyword+=\$,-    " Add extra characters that are valid parts of variables
set nostartofline      " Don't go to the start of the line after some commands
"set scrolloff=3        " Keep three lines below the last line when scrolling
set gdefault           " this makes search/replace global by default
set switchbuf=useopen  " Switch to an existing buffer if one exists

" print options  (pc = percentage of the media size)
set printoptions=left:8pc,right:3pc

set textwidth=70




" set indentkeys=0{,0},:,0#,!^F,o,O,e
" when to reindent the current line:
"   0{  if you type '{' as the first character in a line
"   0}  if you type '}' as the first character in a line
"   :   if you type ':' after a label or case statement
"   0#  if you type '#' as the first character in a line
"   !^F if you type ctrl-F (which is not inserted)
"   o   if you type a <CR> anywhere or use the 'o' command (not in insert mode)
"   O   if you use the 'O' command (not in insert mode)
"   e   if you type the second 'e' for an "else" at the start of a line
