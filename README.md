# ZSH Configuration

A modular ZSH configuration focused on Git workflow optimization with short, memorable aliases and functions.

## Features

- Short, intuitive Git aliases (2-3 letters)
- Advanced Git functions for common workflows
- Interactive features using fzf
- Tag management shortcuts
- Comprehensive restore/reset commands
- Branch management utilities

## Key Commands

### Basic Git Operations
- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gpl` - git pull

### Advanced Functions
- `gfind` - Search through commit history
- `gstat` - Show commit statistics for author
- `ghelp` - List all available commands
- `glf` - Show file history
- `gbl` - Better git blame

### Interactive Commands (requires fzf)
- `gch` - Interactive branch checkout
- `gai` - Interactive staging
- `gri` - Interactive restore
- `gris` - Interactive unstage

### Tag Management
- `gt` - List tags
- `gtn` - Create and push annotated tag
- `gtrd` - Delete tag locally and remotely
- `gtls` - List tags with dates

## Installation

1. Clone this repository:

```bash
git clone https://github.com/gtshepard/zsh-config.git ~/.zsh
```

2. Copy the .zshrc to your home directory:

Note: If you already have a `.zshrc`, make sure to backup your existing configuration first:

```bash
mv ~/.zshrc ~/.zshrc.backup
```


```bash
cp ~/.zsh-config/.zshrc ~/.zshrc
```

3. Reload your shell:

```bash
source ~/.zshrc
```

