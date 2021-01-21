# Vim stuffs
export EDITOR="nvim"
export VISUAL="nvim"
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

# Add $HOME/bin to $PATH via the $path array
export path=($HOME/bin $path)
# Enforce $PATH to child processes
export PATH
