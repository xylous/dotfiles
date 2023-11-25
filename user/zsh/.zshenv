# Add only unique entries
typeset -U path PATH fpath FPATH
# Add $HOME/bin to $PATH via the $path array
export path=("${HOME}/bin" "${HOME}/.local/bin" "${HOME}/.local/share/cargo/bin" ${path})
# Enforce $PATH to child processes
export PATH
# Add $ZDOTDIR/completion to fpath, for user defined completions
export fpath=("${ZDOTDIR}/completion" ${fpath})
# Enforce $PATH to child processes
export FPATH

# Haskell
export STACK_ROOT="${XDG_DATA_HOME}/stack"
