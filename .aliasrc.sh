#!/usr/bin/sh
alias ls='ls --color=auto'
alias s='source $ZDOTDIR/.zshrc'

# Saves a lot of time
if command -v nvim &> /dev/null; then
    alias v='\nvim'
elif command -v vim &> /dev/null; then
    alias v='\vim'
fi

## Quick access to config files
# "configure shell aliases"
alias cfsa='$VISUAL $XDG_CONFIG_HOME/.aliasrc.sh'

# "configure git aliases"
alias cfga='$VISUAL $XDG_CONFIG_HOME/.gitaliases.sh'

# "configure intractive z-shell"
alias cfizs='$VISUAL $ZDOTDIR/.zshrc'

# "configure login z-shell"
alias cfizs='$VISUAL $ZDOTDIR/.zlogin'

# "configure global zshenv"
alias scfgze='sudo $VISUAL /etc/zsh/zshenv'

# "configure bash"
alias cfbs='$VISUAL $HOME/.bashrc'

# "configure neovim"
alias cfnv='$VISUAL $XDG_CONFIG_HOME/nvim/init.vim'

# "configuree vim"
alias cfv='$VISUAL $MYVIMRC'

# "configure i3wm"
alias cfi3='$VISUAL $XDG_CONFIG_HOME/i3/config'

# "configure picom"
alias cfpic='$VISUAL $XDG_CONFIG_HOME/picom.conf'

# "configure alacritty"
alias cfal='$VISUAL $XDG_CONFIG_HOME/alacritty/alacritty.yml'

# "configure polybar"
alias cfpy='$VISUAL $XDG_CONFIG_HOME/polybar/config'


## Package manager
alias p='pacman'
alias sp='sudo pacman'
alias y='yay'
