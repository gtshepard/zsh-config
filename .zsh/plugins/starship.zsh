# Initialize starship only if it's installed
if command -v starship >/dev/null 2>&1; then
    # Set custom config path
    export STARSHIP_CONFIG=".zsh/config/starship.toml"
    
    # Initialize starship
    eval "$(starship init zsh)"
fi 