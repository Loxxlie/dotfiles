# --== Useful Aliases ==--

# Git

gitc() {
    local branches=$(git branch --sort=-committerdate | fzf --header "Select a branch to checkout:")

    if [ -z "$branches" ]; then
        echo "No branches found."
        return 1
    fi

    git checkout "$branches"
    echo "Checked out branch: $branches"
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
