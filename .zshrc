# Git aliases for common operations

# Status
alias gs='git status'

# Add
alias ga='git add'
alias gaa='git add --all'

# Commit
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'

# Branch
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'

# Pull/Push
alias gp='git push'
alias gpl='git pull'
alias gpf='git push --force'
alias gpmr='git pull origin main --rebase'

# Remote
alias gr='git remote'
alias grv='git remote -v'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all'

# Merge
alias gm='git merge'
alias gma='git merge --abort'

# Rebase
alias grb='git rebase'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

# Stash
alias gst='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'

# Log
alias gl='git log'
alias glo='git log --oneline'
alias glg='git log --graph --oneline'

# Diff
alias gd='git diff'
alias gds='git diff --staged'

# Reset
alias grs='git reset'
alias grh='git reset --hard'
alias grs1='git reset --soft HEAD~1'

# Clean
alias gcl='git clean -fd'

# Show
alias gsh='git show'

# Git Functions

# Create and push a new branch to origin
gnb() {
    if [ -z "$1" ]; then
        echo "Usage: gnb <branch-name>"
        return 1
    fi
    git checkout -b "$1" && git push -u origin "$1"
}

# Delete branch locally and remotely
gbd() {
    if [ -z "$1" ]; then
        echo "Usage: gbd <branch-name>"
        return 1
    fi
    git branch -d "$1" && git push origin --delete "$1"
}

# Commit all changes with a message
gac() {
    if [ -z "$1" ]; then
        echo "Usage: gac <commit-message>"
        return 1
    fi
    git add --all && git commit -m "$1"
}

# Fetch, prune and pull current branch
gfp() {
    current_branch=$(git symbolic-ref --short HEAD)
    git fetch --all --prune && git pull origin "$current_branch"
}

# Interactive checkout for branches using fzf (requires fzf installed)
gch() {
    git checkout "$(git branch --all | grep -v HEAD | fzf | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# Stash with a description
gss() {
    if [ -z "$1" ]; then
        echo "Usage: gss <stash-message>"
        return 1
    fi
    git stash push -m "$1"
}

# Cherry-pick with error handling
gcp() {
    if [ -z "$1" ]; then
        echo "Usage: gcp <commit-hash>"
        return 1
    fi
    if git cherry-pick "$1"; then
        echo "Successfully cherry-picked $1"
    else
        echo "Cherry-pick failed. Resolving conflicts needed."
        echo "After resolving, run 'git cherry-pick --continue'"
        echo "Or run 'git cherry-pick --abort' to abort"
    fi
}

# Rebase Functions

# Interactive rebase last N commits
grn() {
    if [ -z "$1" ]; then
        echo "Usage: grn <number-of-commits>"
        return 1
    fi
    git rebase -i HEAD~"$1"
}

# Interactive rebase from a specific commit hash
grf() {
    if [ -z "$1" ]; then
        echo "Usage: grf <commit-hash>"
        return 1
    fi
    git rebase -i "$1^"
}

# Tags
alias gt='git tag'                      # List tags
alias gtl='git tag -l'                  # List tags with pattern
alias gta='git tag -a'                  # Create annotated tag
alias gtd='git tag -d'                  # Delete tag
alias gtp='git push --tags'      # Push all tags
alias gtpf='git push --tags --force'  # Force push all tags

# Tag Functions

# Create and push annotated tag
gtn() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: gtn <tag-name> <tag-message>"
        return 1
    fi
    git tag -a "$1" -m "$2" && git push origin "$1"
}

# Delete tag locally and remotely
gtrd() {
    if [ -z "$1" ]; then
        echo "Usage: gtrd <tag-name>"
        return 1
    fi
    git tag -d "$1" && git push origin :refs/tags/"$1"
}

# List tags with dates and messages
gtls() {
    git for-each-ref --sort='-creatordate' --format '%(creatordate:short) %(refname:short) %(subject)' refs/tags
}

# Checkout tag
gtc() {
    if [ -z "$1" ]; then
        echo "Usage: gtc <tag-name>"
        return 1
    fi
    git checkout tags/"$1"
}

# Restore
alias grt='git restore'                    # Restore working tree files
alias grts='git restore --staged'          # Unstage files
alias grtw='git restore --worktree'        # Restore working tree only
alias grta='git restore --source=HEAD --staged --worktree .'  # Restore everything to HEAD

# Restore Functions

# Restore file(s) from specific commit
grf() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: grf <commit> <file(s)>"
        echo "Example: grf HEAD~1 path/to/file.txt"
        echo "Example: grf abc123 *.js"
        return 1
    fi
    git restore --source="$1" "$2"
}

# Restore and stage file(s) from specific commit
grfs() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: grfs <commit> <file(s)>"
        echo "Example: grfs HEAD~1 path/to/file.txt"
        return 1
    fi
    git restore --source="$1" --staged "$2"
}

# Interactive restore using fzf (requires fzf)
gri() {
    local files=$(git status -s | fzf -m | awk '{print $2}')
    if [ -n "$files" ]; then
        echo "$files" | xargs git restore
    fi
}

# Interactive unstage using fzf (requires fzf)
gris() {
    local files=$(git diff --cached --name-only | fzf -m)
    if [ -n "$files" ]; then
        echo "$files" | xargs git restore --staged
    fi
}

# Reset/Unstage
alias gu='git restore --staged'     # Unstage files (shorter alias)
alias gua='git restore --staged .'  # Unstage all files

# Advanced Git Functions

# Show commit history for a specific file
glf() {
    if [ -z "$1" ]; then
        echo "Usage: glf <file>"
        return 1
    fi
    git log --follow -p -- "$1"
}

# Interactive git add using fzf
gai() {
    local files=$(git status -s | fzf -m | awk '{print $2}')
    if [ -n "$files" ]; then
        echo "$files" | xargs git add
    fi
}

# Show diff of last N commits
gdn() {
    if [ -z "$1" ]; then
        echo "Usage: gdn <number-of-commits>"
        return 1
    fi
    git diff HEAD~"$1" HEAD
}

# Show files changed in last N commits
gscn() {
    if [ -z "$1" ]; then
        echo "Usage: gscn <number-of-commits>"
        return 1
    fi
    git show --name-only HEAD~"$1"..HEAD
}

# Find commits containing specific text
gfind() {
    if [ -z "$1" ]; then
        echo "Usage: gfind <text>"
        return 1
    fi
    git log -S "$1" --pretty=format:'%C(yellow)%h %C(red)%ad %C(blue)%an%C(green)%d %C(reset)%s' --date=short
}

# Show blame with ignore whitespace
gbl() {
    if [ -z "$1" ]; then
        echo "Usage: gbl <file>"
        return 1
    fi
    git blame -w -C -C -C "$1"
}

# Commit stats for author
gstat() {
    local author=${1:-$(git config user.email)}
    echo "Commits by $author:"
    git log --author="$author" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "Added lines: %s\nRemoved lines: %s\nTotal lines: %s\n", add, subs, loc }' -
}

# List all aliases and functions
ghelp() {
    echo "Git Aliases:"
    alias | grep -E '^g[a-z]' | sed 's/^alias //'
    echo "\nGit Functions:"
    declare -f | grep -E '^g[a-z]+ \(\)' | sed 's/{//'
}

# Amend commit without editing message
alias gcan='git commit --amend --no-edit'

# Show current branch name
alias gcb='git rev-parse --abbrev-ref HEAD'

# List branches sorted by last commit date
alias gbs='git for-each-ref --sort="-committerdate" --format="%(committerdate:short) %(refname:short)" refs/heads/'

# Grep through codebase, excluding .git directory
alias gg='git grep --break --heading --line-number'

# Show most recently modified branches
alias gbr='git for-each-ref --sort=-committerdate refs/heads/ --format="%(committerdate:relative)%09%(refname:short)"'

