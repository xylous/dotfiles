## mzp
export MZPM="${ZDOTDIR}/mzpm"
export PLUGIN_DIR="${MZPM}/plugins"

plugins=(
    'zsh-users/zsh-autosuggestions'
    'zsh-users/zsh-syntax-highlighting'
    'vi-mode'
    'colours'
)

# Load in plugin manager
source ${MZPM}/mzpm.zsh

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

## Prompt is handled by another file as well
source ${ZDOTDIR}/config/prompt.zsh
