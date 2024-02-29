# --== Useful Aliases ==--

# Git
alias gitd='git diff'
alias gt='git log --oneline -n 12'
alias gits='git status'

# Editor
alias nv="nvim"

# Custom Scripts
alias tmuxkbs="~/myscripts/help_tmux_kbs.sh"

# Clear nvim swaps
alias clrswp="rm ~/.local/share/nvim/swap/*"

# Connect to local yugabyte DB
alias localysqlsh="docker run --rm --network=\"host\" -it yugabytedb/yugabyte-client ysqlsh -h localhost -p 5433"
