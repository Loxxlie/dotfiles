# --== Useful Aliases ==--

# Git

gitc() {
    local branch=$(git branch --sort=-committerdate | fzf --header "Select a branch to checkout:" | sed 's/^[* ]\{1,\}//')

    if [ -z "$branch" ]; then
        echo "No branch selected."
        return 1
    fi

    branch=$(echo "$branch" | xargs)
    git checkout "$branch"
    echo "Checked out branch: $branch"
}

alias gitd='git diff'
alias gt='git log --oneline -n 12'
alias gits='git status'

# Editor
alias nv="nvim"

# Clear nvim swaps
alias clrswp="rm ~/.local/share/nvim/swap/*"

# Connect to local yugabyte DB
alias localysqlsh="docker run --rm --network=\"host\" -it yugabytedb/yugabyte-client ysqlsh -h localhost -p 5433"
