skip_global_compinit=1  # Disable ubuntu global compinit

# Set ZSH config path
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set ZSH environment variables
export HISTFILE="$XDG_DATA_HOME/zsh/history"    # History filepath
export HISTSIZE=10000                           # Maximum events for internal history
export SAVEHIST=10000                           # Maximum events in history file
export HISTDUP="erase"

# Color output
export LESS='-R --use-color -Dd+r$Du+b$'
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# bat
export BAT_THEME="ansi"

# fzf
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_DEFAULT_OPTS="--scroll-off=2 --reverse --height 40%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'bat -n --color=always {}'"
export FZF_ALT_C_COMMAND="fd --type d . $HOME"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'tree -C {} | head -n 10'"

# Ranger
export RANGER_LOAD_DEFAULT_RC=false

