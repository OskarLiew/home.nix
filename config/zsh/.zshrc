# Run profile, which is not version controlled
[ -f $HOME/.profile ] && . $HOME/.profile

# With inspiration from https://wiki.archlinux.org/title/Zsh

autoload -Uz promptinit select-word-style edit-command-line

### Comlpetion
zstyle ':completion:*' menu select  # Select in menu

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive

zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}  # Use ls colors

zstyle ':completion:*' complete-options true  # Complete options for cd

zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'  # Show errors
zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %D %d --%f' # Show completion tag
# Order of completion groups
zstyle ':completion:*' group-name '' 
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

_comp_options+=(globdots)  # With hidden files

### Theme
promptinit
prompt pure
RPROMPT="%F{yellow}%D{%H:%M:%S}"  # Clock on right side

### Key bindings
bindkey -v  # Use vi mode
KEYTIMEOUT=1  # 10ms for key sequences: https://www.reddit.com/r/vim/comments/60jl7h/zsh_vimode_no_delay_entering_normal_mode/
# Might make it harder to get of command mode

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Setup keybindings
# Sensible default keys
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Cusotm keys
# Find character with `showkey -a`
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
select-word-style bash  # Jumping words uses path components

# Fix deletion of non-inseted text in viins mode
bindkey "^?" backward-delete-char
bindkey '^W' backward-kill-word

# Edit commands in editor
zle -N edit-command-line
bindkey '^e' edit-command-line

# Enable da" and ci( type vi commands
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

### History

setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


### Directory stack

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.


### Aliases

source $XDG_CONFIG_HOME/aliases/aliases

# ensure compatibility tmux <-> direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    unset -m "DIRENV_*"
fi
eval "$(direnv hook bash)"
