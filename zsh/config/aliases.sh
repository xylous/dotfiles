# Some ls aliases
alias ls='ls --color=auto'
alias la='ls -lAh'
alias l='ls -la'
alias ll='ls -l'

# Aand some grep aliases
alias grep='grep --colour=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# zsh should show all of history by default in my opinion
alias history='history 0'
alias hg='history | grep'

# Aaaand the most useful cd aliases, maybe ever
alias -- -='cd -'
alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'

alias szsh='source $ZDOTDIR/.zshrc'
alias _='sudo'

alias v='$VISUAL'

# By default, it would've been aliased to 'man'
alias run-help &>/dev/null && unalias run-help
autoload -Uz run-help
alias help='run-help'
alias h='run-help'

## Quick access to config files
alias sv='sudo $VISUAL'

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

# "configure xinitrc"
alias cfxin='$VISUAL $XDG_CONFIG_HOME/X11/xinitrc'

# "configure alacritty"
alias cfal='$VISUAL $XDG_CONFIG_HOME/alacritty/alacritty.yml'

# "configure tmux"
alias cftmux='$VISUAL $XDG_CONFIG_HOME/tmux/tmux.conf'

# "Configure polybar"
alias cfpy='$VISUAL $XDG_CONFIG_HOME/polybar/config'

## Package manager
alias p='pacman'
alias sp='sudo pacman'
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias p-b="pacman-browse"

## Misc
alias drive="node ~/projects/drive"
alias wikirefs="node ~/projects/wikirefs/wikirefs.js"
alias ixl="node ~/projects/ixl/ixl.js"
