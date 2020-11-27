#IGNORE_BRACES
#INTERACTIVE_COMMENTS
#NO_BANG_HIST
#KSH_OPTION_PRINT
#NO_MULTIOS
#POSIX_BUILTINS
#PROMPT_BANG
#SINGLE_LINE_ZLE


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

# Don't use ksh-like syntax for building prompts (DEFAULT)
#setopt PROMPT_PERCENT
#setopt NO_PROMPT_SUBST

# If zsh detects an asterisk on the command line when the command is 'rm', it
# will ask you to double-check (DEFAULT)
#setopt NO_RM_STAR_SILENT

# Don't have single letter options be more like those in sh and ksh (DEFAULT)
#setopt NO_SH_OPTION_LETTERS

