################################################################################
# PGIT - A collection of git aliases for personal use.
################################################################################

# pgitb - List out all branches.
alias pgitb='git branch'

# pgitc - Check out an existing branch.
alias pgitc='git checkout'

# pgitcb - Check out a new branch.
alias pgitcb='git checkout -b'

# pgitxsync x - Sync branch x with remote.
function pgitxsync() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git checkout $1 && git pull origin $1 && git branch
}

# pgitxonly x - Delete all branches except x. Sync branch x with remote.
function pgitxonly() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git checkout $1 && git branch | grep -v "$1" | xargs git branch -D && git pull origin $1 && git branch
}

# pgitpull - Sync the current branch with remote.
alias pgitpull='git pull origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgitpush "my commit message" - Push the current branch with a custom commit message.
function pgitpush() {
  git add . && git commit -m "$1" && git push origin $(git symbolic-ref HEAD 2>/dev/null)
}

# pgitpushfast - Push the current branch with a simple commit message ("update").
alias pgitpushfast='git add . && git commit -m "update" && git push origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgit - List all pgit commands.
CURRENT_FILE_PATH="$(realpath "${BASH_SOURCE[0]}")"
alias pgit="grep '^# pgit' "$CURRENT_FILE_PATH" | sed 's/^# //' | sort"

# pgitsource - Navigate to the pgit source code from anywhere.
alias pgitsource="cd $(dirname "$CURRENT_FILE_PATH")"

# pgitwhere - Print the path to the pgit source code. Useful when running source within your own .bashrc file.
alias pgitwhere="echo $CURRENT_FILE_PATH"
