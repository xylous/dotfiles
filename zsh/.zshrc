## Basic options
# Only you, the user, should have access to your files
umask 077

# Any patterns that don't match the search are removed; if there is none, print
# a blank line
setopt NO_NULL_GLOB

# Perform case-insensitive filename matching
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB

# Check if the command typed is actually a directory; if it is, cd into it
setopt AUTO_CD

# Don't allow more than one redirection into a file with this option set, like:
# 'echo foo >file1 >file2'
setopt NO_MULTIOS

# Self-explanatory
setopt NO_BEEP

# Disable the program 'less' from saving history to a file
export LESSHISTFILE="-"

# Load all stock functions
autoload -U compaudit compinit

# Set custom zcompdump file
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

# Vim stuffs
export EDITOR="nvim"
export VISUAL="nvim"
export MYVIMRC="$HOME/.config/nvim/init.vim"
export VIMINIT="source $MYVIMRC"

# Manually set language environment
export LANG="fr_FR.UTF-8"
export LC_COLLATE="fr_FR.UTF-8"
export LC_CTYPE="fr_FR.UTF-8"
export LC_MESSAGES="fr_FR.UTF-8"
export LC_MONETARY="ro_RO.UTF-8"
export LC_NUMERIC="ro_RO.UTF-8"
export LC_TIME="fr_FR.UTF-8"

export LS_COLORS="$(vivid generate molokai 2>/dev/null)"

export PAGER='less'

## History options are kept in a separate file
[[ -z $HIST_OPTIONS_FILE ]] \
    && readonly HIST_OPTIONS_FILE="${ZDOTDIR}/config/history.zsh"
[[ -f ${HIST_OPTIONS_FILE} ]] && source ${HIST_OPTIONS_FILE}

## mzpm
source "$ZDOTDIR/mzpm.zsh"
mzpm 'zsh-users/zsh-history-substring-search'
mzpm 'zsh-users/zsh-autosuggestions'
mzpm 'zsh-users/zsh-syntax-highlighting'
mzpm 'xylous/gitstatus'
mzpm 'xylous/alias-zsh'
mzpm 'xylous/hydrogen'

alias-zsh use "$HOME/.cache/mzpm/alias-zsh/aliases"
alias-zsh load all

# Misc
unset I3SOCK
TRAPUSR1() { rehash } # Pacman rehash post-transaction hook
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# mkdir and cd
function mkcdir()
{
    mkdir "$1" && cd "$1"
}
alias mcd="mkcdir"
