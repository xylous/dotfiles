##################
### Oh-my-zsh ###
################

export ZSH="/home/icnh/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
            git
            zsh-syntax-highlighting
            zsh-autosuggestions
        )

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8




###############################
### Expansion and globbing ###
#############################

# Set qualifiers on (DEFAULT)
#setopt BARE_GLOB_QUAL

# Treats characters resulting from parameter expansion as being valid for
# fileame expansion and generation (DEFAULT)
#setopt NO_GLOB_SUBST

# Doesn't expand relative pathnames to absolute pathnames (DEFAULT)
#setopt NO_SH_FILE_EXPANSION
#setopt NO_SH_GLOB
#setopt NO_KSH_GLOB

# Count strings in parameters as single words (DEFAULT)
#setopt NO_SH_WORD_SPLIT

# Enable error messages when searching (DEFAULT)
#setopt NOMATCH
#setopt BAD_PATTERN

# Any patterns that don't match the search are removed; if there is none, print
# a blank line
setopt NO_NULL_GLOB

# Allow for overwriting files that have already been created (DEFAULT)
#setopt CLOBBER

# Whenever you type something that has no arguments and isn't a command, zsh
# will check to see if what you typed is actually a directory.
setopt AUTO_CD

# Don't allow more than one redirection into a file with this option set, like:
# 'echo foo >file1 >file2'
setopt NO_MULTIOS

# When unset, if a command you type doesn't exist, then zsh throws an error
# When set, all commands are checked, and if one/more doesn't exist, but one
# with a similar name exists, zsh will ask you if you actually meant that
#setopt NO_CORRECT      # (DEFAULT)

# Just like NO_CORRECT, but applies to all words on the line
#setopt NO_CORRECT_ALL  # (DEFAULT)



################
### History ###
##############

# Enable csh-style bang history mechanism (DEFAULT)
#setopt BANG_HIST

# After a substitution, the line appears again with the changes; extremely
# useful, as you may mess up the substitution
setopt HIST_VERIFY

# Save history of commands to ~/.zsh_history
HISTFILE=~/.zsh_history

# Save 1000 lines within one session
HISTSIZE=1000
#HISTSIZE=30    # (DEFAULT)

# Save 10000 lines
SAVEHIST=10000

# Append new history to old history in the order that the commands were
# executed, don't overwrite any of the history
setopt INC_APPEND_HISTORY
# Alternatively,
#setopt APPEND_HISTORY
# But that is not recommended for versions 3.1.6 and newer

# Share history between different instances of zsh running
setopt SHARE_HISTORY

# Save more information in history (the time when the command was executed and
# how long it ran for, to be precise) in addition to the command itself
setopt EXTENDED_HISTORY

# Don't save duplicate lines adjacent to one another
setopt HIST_IGNORE_DUPS

# Tidy up the line logged into history; remove superfluous blanks
setopt HIST_REDUCE_BLANKS

# Don't store history or fc commands in history
setopt HIST_NO_STORE

# Don't store function definitions
setopt HIST_NO_FUNCTIONS

# Doesn't beep when you try to scroll up or down, beyond the end of the history
# list
setopt NO_HIST_BEEP



###############
### Prompt ###
#############

# Don't use ksh-like syntax for defining prompts [DEFAULT]
#setopt PROMPT_PERCENT
#setopt NO_PROMPT_SUBST

# Main prompt
#PS1=$'\e[0;32m%m \e[1;34m%# \e[0m'
#PS1='%m%# '    # (DEFAULT)

# Main prompt at the right of the screen
# Displays time in a 24 hour format, but with seconds
RPS1='%(?..(%?%)) %w, %*'

# Prompt shown when the shell is waiting for some more input
PS2='%_> '      # (DEFAULT)

# Prompt displayed within a loop, started by the shell's 'select' mechanism
PS3='?# '      # (DEFAULT)

# Prompt useful for debugging
PS4='+%N:%i> ' # (DEFAULT)


#############################
### Background Processes ###
###########################

# Background processes are ran at a lower priority (DEFAULT)
#setopt BG_NICE

# Print a message immediately after a background processes finishes, then
# reprint the line you were on, as far as you've got (DEFAULT)
#setopt NOTIFY

# Whenever you exit the shell, kill all background processes (DEFAULT)
#setopt HUP



#####################
### Miscellanous ###
###################

# Don't use ksh syntax for defining arrays (DEFAULT)
#setopt NO_KSH_ARRAYS

# Don't use $0 (argument zero) as ksh uses it; allow for usage inside functions,
# where there it represents the function's name (DEFAULT)
#setopt FUNCTION_ARG_ZERO

# TODO: learn what this does (DEFAULT)
#setopt NO_KSH_AUTOLOAD

# If zsh detects an asterisk on the command line when the command is 'rm', it
# will ask you to double-check (DEFAULT)
#setopt NO_RM_STAR_SILENT

# Don't have single letter options be more like those in sh and ksh (DEFAULT)
#setopt NO_SH_OPTION_LETTERS

# Use zsh-like syntax for loops instead of csh-like syntax (DEFAULT)
#setopt NO_CSH_JUNKIE_LOOPS

# Add the ~/bin directory to path, if it exists:
#if [[ -d "$HOME/bin" ]]; then
#    PATH="$HOME/bin:$PATH"
#fi

# Enable vi mode
bindkey -v

# zsh beeps when it doesn't like something by default, and that I find annoying
setopt NO_BEEP



################
### Aliases ###
##############

# It is best practice to put your aliases into a separate file, to keep them
# neatly ordered. The following automatically loads the file .aliasrc.sh if it
# exists:
if [[ -r ~/.aliasrc.sh ]]; then
    source ~/.aliasrc.sh
fi
