### History ###
# After a substitution, the line appears again with the changes; extremely
# useful, as you may mess up the substitution
setopt HIST_VERIFY

# Save history of commands to ~/.zsh_history
HISTFILE="${XDG_CACHE_HOME}/zsh/history"

# Max size within one session
HISTSIZE=1000

# The longer, the better
SAVEHIST=10000

# Append new history to old history in the order that the commands were
# executed, don't overwrite any of the history
setopt INC_APPEND_HISTORY

# Share history with concurrent zsh sessions
setopt SHARE_HISTORY

# Save more information about commands in history, e.g. timestamps
setopt EXTENDED_HISTORY

# Save no duplicates (works great with zsh-autosuggestions)
setopt HIST_IGNORE_ALL_DUPS

# Remove trailing/leading blanks
setopt HIST_REDUCE_BLANKS

# Don't store 'history' commands
setopt HIST_NO_STORE

# Don't store functions
setopt HIST_NO_FUNCTIONS

# No. damn. beeping.
setopt NO_HIST_BEEP
