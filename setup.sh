#!/bin/zsh

set -e  # Exit on any error
set -x  # Print each command before executing

# Backup handling
if [ -f ~/.zshrc.backup ] || [ -d ~/.zsh.backup ]; then
    read "response?Backup files exist. Overwrite? (y/N) "
    [[ $response =~ ^[Yy] ]] && {
        echo "Creating new backups..."
        [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
        [ -d ~/.zsh ] && { rm -rf ~/.zsh.backup; mv ~/.zsh ~/.zsh.backup; }
    } || echo "Proceeding without backup..."
else
    echo "Creating backups..."
    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
    [ -d ~/.zsh ] && mv ~/.zsh ~/.zsh.backup
fi

# Create directory structure and copy files
mkdir -p ~/.zsh/{core,plugins,config,local} || { echo "Failed to create directories"; exit 1; }
cp .zshrc ~/.zshrc || { echo "Failed to copy .zshrc"; exit 1; }
cp -rf .zsh/core/* ~/.zsh/core/ || { echo "Failed to copy core files"; exit 1; }
cp -rf .zsh/plugins/* ~/.zsh/plugins/ || { echo "Failed to copy plugins"; exit 1; }
cp -rf .zsh/config/* ~/.zsh/config/ || { echo "Failed to copy config"; exit 1; }

echo "ZSH configuration installed! Please restart your shell or run 'source ~/.zshrc'"


source ~/.zshrc
# Exit successfully
exit 0