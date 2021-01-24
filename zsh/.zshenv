# Vim stuffs
export EDITOR="nvim"
export VISUAL="nvim"
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

# Add only unique entries to $path and $PATH
typeset -U path PATH
# Add $HOME/bin to $PATH via the $path array
export path=($HOME/bin $path)
# Enforce $PATH to child processes
export PATH

# Same as before, but with function definitions
typeset -U fpath FPATH
export fpath=(${ZDOTDIR}/custom-functions $fpath)
export FPATH
