#!/usr/bin/sh
alias ls='ls --color=auto'
alias szsh='source $ZDOTDIR/.zshrc'
alias s='sudo'

# Saves a lot of time
alias v='$EDITOR'

## Quick access to config files
# "configure shell aliases"
alias cfsa='$VISUAL $ZDOTDIR/.aliases.sh'

# "configure git aliases"
alias cfga='$VISUAL $ZDOTDIR/.gitaliases.sh'

# "configure git"
alias cfgit='git config --global -e'

# "configure intractive z-shell"
alias cfizs='$VISUAL $ZDOTDIR/.zshrc'

# "configure login z-shell"
alias cflzs='$VISUAL $ZDOTDIR/.zlogin'

# "sudo configure global zshenv"
alias scfgzenv='sudo $VISUAL /etc/zsh/zshenv'

# "configure zshenv"
alias cfzenv='$VISUAL $ZDOTDIR/.zshenv'

# "edit z-shell history"
alias ezhist='$VISUAL $ZDOTDIR/.zsh_history'

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
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias p-b="pacman-browse"
alias a="aurpkger"
alias ast="archstat"
