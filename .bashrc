# Git Shortcuts
# To use this, add "source /path/to/.pgit" to .bashrc or .bash_profile.

# pgitb - List out all branches.
alias pgitb='git branch'

# pgitc - Check out an existing branch.
alias pgitc='git checkout'

# pgitcb - Check out a new branch.
alias pgitcb='git checkout -b'

# pgitmainsync - Sync main with remote.
alias pgitmainsync='git checkout main && git pull origin main && git branch'

# pgitmainonly - Delete all branches except main. Sync main with remote.
alias pgitmainonly='git checkout main && git branch | grep -v "main" | xargs git branch -D && pgitmainsync'

# pgitmastersync - Sync master with remote.
alias pgitmastersync='git checkout master && git pull origin master && git branch'

# pgitmasteronly - Delete all branches except master. Sync master with remote.
alias pgitmasteronly='git checkout master && git branch | grep -v "main" | xargs git branch -D && pgitmastersync'

# pgitpull - Sync the current branch with remote.
alias pgitpull='git pull origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgitpush "my commit message" - Push the current branch with a custom commit message.
function pgitpush() {
  git add . && git commit -m "$1" && git push origin $(git symbolic-ref HEAD 2>/dev/null)
}

# pgitpushfast - Push the current branch with a simple commit message ("update").
alias pgitpushfast='git add . && git commit -m "update" && git push origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgithelp - List all pgit commands.
# Find all lines in this file that begin with "# pgit". Filter out the "#", sort the lines alphabetically, then output to the terminal.
alias pgithelp='grep "^# pgit" */.bashrc | sed "s/# //" | sort'
