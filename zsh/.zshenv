# Add only unique entries to $path and $PATH
typeset -U path PATH
# Add $HOME/bin to $PATH via the $path array
export path=($HOME/bin $HOME/.deno/bin $path)
# Enforce $PATH to child processes
export PATH
