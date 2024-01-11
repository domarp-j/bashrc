################################################################################
# PGIT - A collection of git aliases for personal use.
################################################################################

# pgitb - List all branches.
alias pgitb='git branch'

# pgitbc - Check out a branch. If the branch does not exist yet, create it.
function pgitbc() {
  branch_name="$1"
  if git rev-parse --quiet --verify "$branch_name" > /dev/null; then
    echo "Checking out existing branch: $branch_name"
    git checkout "$branch_name"
  else
    echo "Creating and checking out new branch: $branch_name"
    git checkout -b "$branch_name"
  fi
}

# pgitbd - Delete a branch.
alias pgitbd='git branch -D'

# pgitsync branch-to-sync - Sync the the given local branch with its remote counterpart.
function pgitsync() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git checkout $1 && git pull origin $1 && pgitb
}

# pgitonly branch-to-keep - Delete all branches except the given branch. Sync the branch with remote.
function pgitonly() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git checkout $1 && git branch | grep -v "$1" | xargs git branch -D && git pull origin $1 && pgitb
}

# pgitpull - Sync the current branch with its remote counterpart.
alias pgitpull='git pull origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgitpullx remote-branch - Sync the current branch with a specified remote branch.
function pgitpullfrom() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git pull origin $1
}

# pgitpush - Push the current branch to its remote counterpart.
alias pgitpush='git push origin $(git symbolic-ref HEAD 2>/dev/null)'

# pgitcommit "my commit message" - Push the current branch with a custom commit message.
function pgitcommit() {
  git add . && git commit -m "$1" && pgitpush
}

# pgitcommitfast - Push the current branch with a simple commit message ("update").
alias pgitcommitfast='git add . && git commit -m "update" && pgitpush'

# pgit - List all pgit commands.
CURRENT_FILE_PATH="$(realpath "${BASH_SOURCE[0]}")"
alias pgit="grep '^# pgit' "$CURRENT_FILE_PATH" | sed 's/^# //' | sort"

# pgitsource - Navigate to the pgit source code from anywhere.
alias pgitsource="cd $(dirname "$CURRENT_FILE_PATH")"

# pgitwhere - Print the path to the pgit source code. Useful when running source within your own .bashrc file.
alias pgitwhere="echo $CURRENT_FILE_PATH"
