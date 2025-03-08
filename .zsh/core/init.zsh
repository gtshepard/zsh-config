# Core ZSH configuration directory
export ZSH_CONFIG_DIR="$HOME/.zsh"

# Set config directory for external tools
export ZSH_CONFIG_FILES="$ZSH_CONFIG_DIR/config"

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicates in history
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates
setopt HIST_REDUCE_BLANKS    # Remove blank lines
setopt INC_APPEND_HISTORY    # Add commands as they are typed
setopt EXTENDED_HISTORY      # Add timestamps to history

# Directory navigation
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # Push directory onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_MINUS          # Use +/- operators

# Completion settings
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select  # Enable menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive completion

# Vim key bindings
bindkey -v                           # Use vim key bindings
export KEYTIMEOUT=1                 # Reduce vim mode switching delay

# Show vim mode in prompt
function zle-line-init zle-keymap-select {
    # Update prompt when vim mode changes
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# # Keep some emacs-style bindings that are useful even in vim mode
# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^R' history-incremental-search-backward
# bindkey '^S' history-incremental-search-forward
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line
# bindkey '^W' backward-kill-word
# bindkey '^?' backward-delete-char    # Backspace

# # Colors
# autoload -U colors && colors
# export CLICOLOR=1
# export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Load all enabled plugins
for plugin in .zsh/plugins/*.zsh; do
    source $plugin
done

# # Load any local machine-specific settings if they exist
# [[ -f $ZSH_CONFIG_DIR/local/$(hostname).zsh ]] && source $ZSH_CONFIG_DIR/local/$(hostname).zsh

# # Load any role-specific settings (work/personal) if they exist
# [[ -f $ZSH_CONFIG_DIR/local/role.zsh ]] && source $ZSH_CONFIG_DIR/local/role.zsh 