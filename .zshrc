typeset -U path
path=("$HOME/.local/bin" $path)
export PATH

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history extended_history hist_ignore_dups share_history

# Completion
autoload -Uz compinit
compinit

if [[ "$OSTYPE" == linux* ]]; then
    alias ls='ls --color=auto'
fi

if (( $+commands[mise] )); then
    eval "$(mise activate zsh)"
fi

eval "$(starship init zsh)"
