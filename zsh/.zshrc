##################
### Oh-my-zsh ###
################

# Automatically execute GUI if in tty1
if [[ $TERM == "linux" && $(who | awk '{print $2}') == "tty1" ]]; then
    exec startx; exit
fi

if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
    # Terminal is capable of handling at least 256 colours

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Path to your oh-my-zsh installation.
    export ZSH="/home/icnh/.oh-my-zsh"

    # Set theme to powerlevel10k
    ZSH_THEME="powerlevel10k/powerlevel10k"
    
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(
        #git
        zsh-autosuggestions
        vi-mode
        zsh-syntax-highlighting
    )
    
    # Load oh-my-zsh
    source $ZSH/oh-my-zsh.sh

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
    # Terminal may be TTY or something not very capable

    # Load some random PS1, aka do not load p10k (because it does not work in a
    # tty, at least for me)
    export PS1="%F{green}%m %F{white}%# "

    # Also, notice this does not load oh-my-zsh
fi

# Manually set language environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Autoupdate oh-my-zsh without prompts
DISABLE_UPDATE_PROMPT=true



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
#setopt MATCH
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



################
### Aliases ###
##############

# It is best practice to put your aliases into a separate file, to keep them
# neatly ordered. The following automatically loads the file .aliasrc.sh if it
# exists:
if [[ -r ~/.aliasrc.sh ]]; then
    source ~/.aliasrc.sh
fi

if [[ -r ~/.gitaliases.sh ]]; then
    source ~/.gitaliases.sh
fi



########################
### ZSH Line Editor ###
######################

# Set the $VISUAL parameter
if command -v nvim &> /dev/null; then
    VISUAL=nvim
    bindkey -v
elif command -v emacs &> /dev/null; then
    VISUAL=emacs
    bindkey -e
elif command -v vim &> /dev/null; then
    VISUAL=vim
    bindkey -v
elif command -v vi &> /dev/null; then
    VISUAL=vi
    bindkey -v
fi

## Keybindings and keymaps
# Don't use ksh-like syntax for defining prompts [DEFAULT]
#setopt PROMPT_PERCENT
#setopt NO_PROMPT_SUBST

# Main prompt
#PS1='%m%# '    # (DEFAULT)

# Main prompt at the right of the screen
# Displays time in a 24 hour format, but with seconds
#RPS1='%(?..(%?%)) %w, %*'

# Prompt shown when the shell is waiting for some more input
#PS2='%_> '      # (DEFAULT)

# Prompt displayed within a loop, started by the shell's 'select' mechanism
#PS3='?# '      # (DEFAULT)

# Prompt useful for debugging
#PS4='+%N:%i> ' # (DEFAULT)



#####################
### Miscellanous ###
###################

# Don't use ksh syntax for defining arrays (DEFAULT)
#setopt NO_KSH_ARRAYS

# Don't use $0 (argument zero) as ksh uses it; allow for usage inside functions,
# where there it represents the function's name (DEFAULT)
#setopt FUNCTION_ARG_ZERO

# Don't emulate ksh function autoloading (basically, when a function is
# autoloaded, the corresponding file is merely executed, and must define the
# function itself) (DEFAULT)
#setopt NO_KSH_AUTOLOAD

# If zsh detects an asterisk on the command line when the command is 'rm', it
# will ask you to double-check (DEFAULT)
#setopt NO_RM_STAR_SILENT

# Don't have single letter options be more like those in sh and ksh (DEFAULT)
#setopt NO_SH_OPTION_LETTERS

# Use zsh-like syntax for loops instead of csh-like syntax (DEFAULT)
#setopt NO_CSH_JUNKIE_LOOPS

# Add the ~/bin directory to path if it exists, but no duplicates:
if [[ -d "$HOME/bin" ]]; then
    typeset -U path
    path=($HOME/bin $path)
fi

#if [[ -d "$HOME/.local/bin" ]]; then
    #typeset -U path
    #path = ($HOME/.local/bin $path)
#fi

# zsh beeps when it doesn't like something by default, and that I find annoying
setopt NO_BEEP

# Set XDG_DATA_DIRS variable
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/icnh/.local/share/flatpak/exports/share:/usr/share
