################
### Aliases ###
##############

alias ls='ls --color=auto'

# Saves a lot of time
if command -v nvim &> /dev/null; then
    alias v='\nvim'
elif command -v vim &> /dev/null; then
    alias v='\vim'
fi

## Quick access to config files
# "configure z-shell"
alias cfzs='nvim ~/.zshrc'
# "configure bash"
alias cfbs='nvim ~/.bashrc'
# "configure shell aliases"
alias cfsa='nvim ~/.aliasrc.sh'
# "configure neovim"
alias cfnv='nvim ~/.config/nvim/init.vim'
# "configure i3wm"
alias cfi3='nvim ~/.config/i3/config'
# "configure picom"
alias cfpic='nvim ~/.config/picom.conf'
# "configure alacritty"
alias cfal='nvim ~/.config/alacritty/alacritty.yml'
# "configure polybar"
alias cfpy='nvim ~/.config/polybar/config'

# Package manager
alias p='pacman'
alias sp='sudo pacman'
alias y='yay'
