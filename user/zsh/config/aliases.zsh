
#############
## UTILITY ##
#############

alias -- -='cd -'
alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'

alias grep='grep --colour=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls='ls --color=auto'
alias la='ls -lAh'
alias l='ls -la'
alias ll='ls -l'

alias history='history'
alias hg='history | grep'

alias szsh='source "${ZDOTDIR}/.zshrc"'
alias _='sudo'

# by default, `help` would be aliased to 'man'
alias run-help &>/dev/null && unalias run-help
autoload -Uz run-help
alias help='run-help'

alias v='$VISUAL'
alias sv='sudo $VISUAL'

alias of="onefetch"

#############
## CONFIGS ##
#############

# "configure shell aliases"
alias cfsa='$VISUAL "${ZDOTDIR}/config/aliases.sh"'
# "configure git aliases"
alias cfga='$VISUAL $ZDOTDIR/config/gitaliases.sh'
# "configure intractive z-shell"
alias cfizs='$VISUAL $ZDOTDIR/.zshrc'
# "configure login z-shell"
alias cflzs='$VISUAL $ZDOTDIR/.zlogin'
# "configure zshenv"
alias cfzenv='$VISUAL $ZDOTDIR/.zshenv'
# "configure vim"
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

##############
### PACMAN ###
##############

alias p='pacman'
alias sp='sudo pacman'
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias p-b="pacman-browse"

#############
#### GIT ####
#############

alias g="git"
alias gcfg="git config"

alias gd="git diff"
alias gds="git diff --staged"

alias gl="git log"
alias glo="git log --oneline"

alias ga="git add"
alias gaa="git add --all"

alias gs="git status"
alias gss="git status --short"

alias gci="git commit"
alias gcim="git commit -m"
alias gcima="git commit --all"
alias gciuh="git commit --amend"

alias gcl="git clone"
alias gpsh="git push"
alias gpl="git pull"

alias gbr="git branch"
alias gco="git checkout"

alias gmr="git merge"
alias gmv="git mv"
alias grm="git rm"

#############
### CARGO ###
#############

alias cg="cargo"
alias cgb="cargo build"
alias cgr="cargo run"
alias cgc="cargo clippy"
alias cgs="cargo search"
alias cgt="cargo test"

##############
### SETTLE ###
##############

alias st="settle"
alias stq="settle query"
alias stge="settle generate"
alias stfl="settle links"
alias stbl="settle backlinks"
alias stls="settle ls"
alias stf="settle find"
alias sts="settle search"
alias stnc="settle not-created"

function vstn() {
    nvim -c "SettleNew '',\"$1\""
}

function vstnp() {
    nvim -c "SettleNew '$1',\"$2\""
}

function vstni() {
    nvim -c "SettleNew 'inbox',\"$1\""
}

function vste() {
    nvim -c "SettleEdit"
}