# Some ls aliases
alias ls='ls --color=auto'
alias la='ls -lAh'
alias l='ls -l'
alias ll='ls -la'

# Aand some grep aliases
alias grep='grep --colour=auto'

alias szsh='source $ZDOTDIR/.zshrc'
alias _='sudo'

alias v='$VISUAL'

# Before, it would've been aliased to 'man'
unalias run-help
autoload -Uz run-help
alias h='run-help'

## Quick access to config files
# "configure shell aliases"
alias cfsa='$VISUAL $ZDOTDIR/config/aliases.sh'

# "configure git aliases"
alias cfga='$VISUAL $ZDOTDIR/config/gitaliases.sh'

# "configure intractive z-shell"
alias cfizs='$VISUAL $ZDOTDIR/.zshrc'

# Configure zsh plugin manager
alias cfzplg='$VISUAL $MZPM/mzpm.zsh'

# "Configure zsh prompt"
alias cfzspr='$VISUAL $ZDOTDIR/config/prompt.zsh'

# "configure login z-shell"
alias cflzs='$VISUAL $ZDOTDIR/.zlogin'

# "configure zshenv"
alias cfzenv='$VISUAL $ZDOTDIR/.zshenv'

# "configure neovim"
alias cfnv='$VISUAL $XDG_CONFIG_HOME/nvim/init.vim'
alias cfv='$VISUAL $MYVIMRC'

# "configure i3wm"
alias cfi3='$VISUAL $XDG_CONFIG_HOME/i3/config'

# "configure alacritty"
alias cfal='$VISUAL $XDG_CONFIG_HOME/alacritty/alacritty.yml'

# "configure tmux"
alias cftmux='$VISUAL $XDG_CONFIG_HOME/tmux/tmux.conf'

## Package manager
alias p='pacman'
alias sp='sudo pacman'
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias p-b="pacman-browse"
alias ast="archstat"