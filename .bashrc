################################################################################
# PGIT - A collection of git aliases for personal use.
################################################################################

# pgitb - List all branches. Aliases: pgitbl, pgitl.
alias pgitb='git branch'
alias pgitbl='pgitb'
alias pgitl='pgitb'

# pgitc x - Check out branch x. If x does not exist, create it. Aliases: pgitbc.
function pgitc() {
  branch_name="$1"
  if git rev-parse --quiet --verify "$branch_name" > /dev/null; then
    echo "Checking out existing branch: $branch_name"
    git checkout "$branch_name"
  else
    echo "Creating and checking out new branch: $branch_name"
    git checkout -b "$branch_name"
  fi
}
alias pgitbc='pgitc'

# pgitd x - Delete branch x. Aliases: pgitbd.
alias pgitd='git branch -D'
alias pgitbd='pgitd'

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
    git push --set-upstream origin $(git symbolic-ref HEAD 2>/dev/null)
  fi
  git push --set-upstream origin $1
}

# pgitcmt x? - Push the current branch with commit message x. If x is not provided, branch is commited with message "update".
function pgitcmt() {
  # Do not commit to main directly under any circumstances.
  if [ "$(git symbolic-ref --short HEAD)" = "main" ]; then
    echo "You are on the main branch. You cannot commit directly to this branch. Use pgitcmtmain instead, and do so only if you're certain."
    return 1
  fi
  if [ -z "$1" ]; then
    git add . && git commit -m "update" && pgitpush
  fi
  git add . && git commit -m "$1" && pgitpush
}

# pgitcmtmain x - Push the main branch with commit message x. Unlike pgitcmt, a commit message is required.
function pgitcmtmain() {
  # Verify that the current branch is main.
  if [ "$(git symbolic-ref --short HEAD)" != "main" ]; then
    echo "You are not on the main branch."
    return 1
  fi
  if [ -z "$1" ]; then
    echo "You must provide a commit message."
    return 1
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

# pgitclean - Delete all local branches that have been merged into main.
alias pgitclean="pgitc main && git branch --merged main | grep -v '^\*\|main$' | xargs -n 1 git branch -d"


################################################################################
# POTPURRI
################################################################################

alias srcbashrc="source ~/.bashrc"
