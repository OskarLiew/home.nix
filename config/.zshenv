# Read nix env vars
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# XDG
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_BIN_HOME" ] && export XDG_BIN_HOME="$HOME/.local/bin"

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


