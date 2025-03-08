#!/bin/zsh

# Docker Desktop management
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    alias dstart='open -a Docker'
    alias dstop='osascript -e "quit app \"Docker\""'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    alias dstart='systemctl --user start docker-desktop'
    alias dstop='systemctl --user stop docker-desktop'
fi

# Wait for Docker to be ready
function dwait() {
    echo "Waiting for Docker to be ready..."
    while ! docker system info > /dev/null 2>&1; do
        sleep 1
    done
    echo "Docker is ready!"
}

# Start Docker and wait for it to be ready
function dready() {
    dstart
    dwait
}

# Common Docker aliases
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dlogs='docker logs'
alias dexec='docker exec -it'
alias dprune='docker system prune -af' 