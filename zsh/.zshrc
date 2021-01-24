## Oh-my-zsh
# Path to your oh-my-zsh installation
export ZSH="${ZDOTDIR}/.oh-my-zsh"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-autosuggestions
    vi-mode zsh-syntax-highlighting
)

# Load oh-my-zsh
source ${ZSH}/oh-my-zsh.sh

# Manually set language environment
export LANG=en_US.UTF-8

# Set compilation flags
export ARCHFLAGS="-arch x86_64"

# Autoupdate oh-my-zsh without prompts
DISABLE_UPDATE_PROMPT=true

## Basic options
# Any patterns that don't match the search are removed; if there is none, print
# a blank line
setopt NO_NULL_GLOB

# Check if the command typed is actually a directory; if it is, cd into it
setopt AUTO_CD

# Don't allow more than one redirection into a file with this option set, like:
# 'echo foo >file1 >file2'
setopt NO_MULTIOS

# This is pretty self-explanatory
setopt NO_BEEP

# Disable the program 'less' from saving history to a file
export LESSHISTFILE="-"

# Load all stock functions
autoload -U compaudit compinit

# Set custom zcompdump file
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

# Unalias 'run-help' (set by oh-my-zsh to 'man') because it provides help on
# zsh builtins, and seeing the manual instead of shell-builtins is frustrating
unalias run-help &> /dev/null
autoload run-help
alias help='run-help'

## History options are kept in a separate file
[[ -z $HIST_OPTIONS_FILE ]] \
    && readonly HIST_OPTIONS_FILE="${ZDOTDIR}/config/history.zsh"
[[ -f ${HIST_OPTIONS_FILE} ]] && source ${HIST_OPTIONS_FILE}

## Load aliases from other files
[[ -z $aliases_file ]] \
    && readonly aliases_file="${ZDOTDIR}/config/aliases.sh"
[[ -z $gitaliases_file ]] \
    && readonly gitaliases_file="${ZDOTDIR}/config/gitaliases.sh"
[[ -f ${aliases_file} ]] && source ${aliases_file}
[[ -f ${gitaliases_file} ]] && source ${gitaliases_file}

## Prompt is handled in another file as well
source ${ZDOTDIR}/config/prompt.zsh
