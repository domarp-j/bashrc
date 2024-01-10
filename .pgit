# Git Shortcuts
# To use this, add "source /path/to/.pgit" to .bashrc or .bash_profile.

# List out all branches.
alias pgitb='git branch'

# Check out a branch.
alias pgitc='git checkout'
alias pgitcb='git checkout -b'

# Print out a list of all aliases that begin with 'git'.
alias pgitlist="(alias | grep '^alias pgit' | sed 's/alias //g' && declare -F | awk '{print \$3}' | grep '^pgit') | grep pgit"

# Remove all branches except main/master to keep branch list clean.
alias pgitmainonly='git checkout main && git pull origin main && git branch | grep -v "main" | xargs git branch -D'
alias pgitmasteronly='git checkout master && git pull origin master && git branch | grep -v "main" | xargs git branch -D'

# Sync main/master with remote.
alias pgitmainsync='git checkout main && git pull origin main && git branch'
alias pgitmastersync='git checkout master && git pull origin master && git branch'

# Sync the current branch with remote.
alias pgitpull='git pull origin $(git symbolic-ref HEAD 2>/dev/null)'

# Push the current branch with a simple commit message.
alias pgitpushfast='git add . && git commit -m "update" && git push origin $(git symbolic-ref HEAD 2>/dev/null)'

# Push the current branch with a custom commit message.
function pgitpush() {
  git add . && git commit -m "$1" && git push origin $(git symbolic-ref HEAD 2>/dev/null)
}
