" Activate the standard windows keybindings
source $VIMRUNTIME/mswin.vim
behave mswin

if has("gui_running")
    " Set a nicer font
    set guifont=Consolas:h11:cDEFAULT
    " Hide the toolbar
    set guioptions-=T
endif
