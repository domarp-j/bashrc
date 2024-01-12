################################################################################
# PGIT - A collection of git aliases for personal use.
################################################################################

# pgitb - List all branches. Aliases: pgitbl.
alias pgitb='git branch'
alias pgitbl='pgitb'

# pgitbc x - Check out branch x. If x does not exist, create it.
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

# pgitbd x - Delete branch x.
alias pgitbd='git branch -D'

# pgitpull x? - Pull remote x to local. If x is not provided, pull remote to current branch.
function pgitpull() {
  if [ -z "$1" ]; then
    git pull origin $(git symbolic-ref HEAD 2>/dev/null)
  fi
  git pull origin $1
}

# pgitpush x? - Push local to remote x. If x is not provided, push to current branch in remote.
function pgitpush() {
  if [ -z "$1" ]; then
    git push origin $(git symbolic-ref HEAD 2>/dev/null)
  fi
  git push origin $1
}

# pgitonly x - Delete all branches except x.
function pgitonly() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name, e.g. \"main\"."
    return 1
  fi
  git checkout $1 && git branch | grep -v "$1" | xargs git branch -D && pgitpull $1
}

# pgitcmt x? - Push the current branch with commit message x. If x is not provided, branch is commited with message "update".
function pgitcmt() {
  if [ -z "$1" ]; then
    git add . && git commit -m "update" && pgitpush
  fi
  git add . && git commit -m "$1" && pgitpush
}

# pgit - List all pgit commands.
CURRENT_FILE_PATH="$(realpath "${BASH_SOURCE[0]}")"
alias pgit="grep '^# pgit' "$CURRENT_FILE_PATH" | sed 's/^# //' | sort"

# pgitsrc - Navigate to the pgit source code from anywhere. Aliases: pgitsource.
alias pgitsrc="cd $(dirname "$CURRENT_FILE_PATH")"
alias pgitsource="pgitsrc"

# pgitwhere - Print the path to the pgit source code. Useful when running source within your own .bashrc file.
alias pgitwhere="echo $CURRENT_FILE_PATH"
