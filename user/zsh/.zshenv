# Add only unique entries to $path and $PATH
typeset -U path PATH
# Add $HOME/bin to $PATH via the $path array
export path=("${HOME}/bin" "${HOME}/.local/bin" "${HOME}/.local/share/cargo/bin" ${path})
# Enforce $PATH to child processes
export PATH
# Add $ZDOTDIR/completion to fpath, for user defined completions
export fpath=("${ZDOTDIR}/completion" ${fpath})
# Enforce $PATH to child processes
export FPATH
# Just Haskell things
export STACK_ROOT="${XDG_DATA_HOME}/stack"
