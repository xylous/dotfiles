# Add only unique entries to $path and $PATH
typeset -U path PATH
# Add $HOME/bin to $PATH via the $path array
export path=($HOME/bin $HOME/.local/bin $path)
# Enforce $PATH to child processes
export PATH
# Just Haskell things
export STACK_ROOT="${XDG_DATA_HOME}/stack"
