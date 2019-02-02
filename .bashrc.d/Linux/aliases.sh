# Directory coloring, put in Linux because it doesn't work in OS X, which has
# a BSD ls instead of the GNU one
eval `dircolors ~/.dir_colors`
alias ls='ls --color=always -F'
