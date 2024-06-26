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

# Vim stuff
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

# Define LS_COLORS and use it when completing filenames
[[ -f "${ZDOTDIR}/config/LSCOLORS.txt" ]] \
    && export LS_COLORS="$(cat ${ZDOTDIR}/config/LSCOLORS.txt)"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export PAGER='less'

## History options are kept in a separate file
[[ -z $HIST_OPTIONS_FILE ]] \
    && readonly HIST_OPTIONS_FILE="${ZDOTDIR}/config/history.zsh"
[[ -f ${HIST_OPTIONS_FILE} ]] && source ${HIST_OPTIONS_FILE}

## Aliases are kept in a separate file
[[ -f "${ZDOTDIR}/config/aliases.zsh" ]] \
    && source "${ZDOTDIR}/config/aliases.zsh"

## mzpm
[[ -f "${ZDOTDIR}/mzpm.zsh" ]] \
    && source "${ZDOTDIR}/mzpm.zsh" \
    && mzpm 'zsh-users/zsh-history-substring-search' \
    && mzpm 'zsh-users/zsh-autosuggestions' \
    && mzpm 'zsh-users/zsh-syntax-highlighting' \
    && mzpm 'xylous/gitstatus' \
    && mzpm 'xylous/hydrogen'

## Prompt settings
# Enable vim mode
bindkey -v

# Pressing UP and DOWN keys will go up and down in the entries in hitory that
# start with what has already been typed in
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# Required for the code above to work properly
function zle-line-init() {
    (( ! ${+terminfo[smkx]} )) || echoti smkx
}
zle -N zle-line-init

# Highlight current entry in the tab completion menu
zstyle ':completion:*' menu select
zmodload zsh/complist

# Be able to hjkl to navigate tab completion menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

# Be able to use Ctrl-[N|P] to navigate tab completion menu
bindkey '^N' expand-or-complete
bindkey '^P' reverse-menu-complete

# Remove character under cursor when the <Delete> key is pressed
bindkey "^[[3~" vi-delete-char
bindkey -a "^[[3~" vi-delete-char

# Move just a character when Ctrl-[LEFT|RIGHT] is pressed
bindkey "^[[1;5D" backward-char
bindkey "^[[1;5C" forward-char

# Misc
unset I3SOCK
TRAPUSR1() { rehash } # Pacman rehash post-transaction hook
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# mkdir and cd
function mkcdir()
{
    mkdir "$1" && cd "$1"
}
alias mcd="mkcdir"

# GPG stuff. I dunno.
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# open the given filename with Zathura and then exit the shell
function book()
{
    exec zathura "$1" &!
    exit
}

SSH_AGENT_FILE="${HOME}/.ssh/.agent"
. "${SSH_AGENT_FILE}" >/dev/null
# If the agent PIDs (the one stored in the file and the one running on the
# system) differ, rewrite the file
if ! ps -p "${SSH_AGENT_PID}" | grep ssh-agent >/dev/null; then
    ssh-agent >"${SSH_AGENT_FILE}"
    . "${SSH_AGENT_FILE}" >/dev/null
fi

# Stop debuginfod from creating massive cache folders
# (while possibly ruining debugging tools in the process)
export DEBUGINFOD_URLS=""
