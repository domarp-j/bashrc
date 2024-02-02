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
  if [ -z "$branch_name" ]; then
    echo "You must provide a branch name."
    return 1
  fi
  if git rev-parse --quiet --verify "$branch_name" > /dev/null; then
    echo "Checking out existing branch: $branch_name"
    git checkout "$branch_name"
  else
    echo "Creating and checking out new branch: $branch_name"
    git checkout -b "$branch_name"
  fi
}
alias pgitbc='pgitc'

# pgitd x - Delete any branch that regex-matches x.
function pgitd() {
  if [ -z "$1" ]; then
    echo "You must provide an input."
    return 1
  fi
  git branch | grep -E "$1" | xargs -n 1 git branch -D
}

# pgitdf - Get the diff of the current branch. Aliases: pgitdiff, pgitdif.
alias pgitdf='git diff'
alias pgitdiff='pgitdf'
alias pgitdif='pgitdf'

# pgitpull x? - Pull remote x to local. If x is not provided, pull remote to current branch.
function pgitpull() {
  if [ -z "$1" ]; then
    git pull origin $(git symbolic-ref HEAD 2>/dev/null)
  fi
  git pull origin $1
}

# pgitpush x? - Push local to remote x. If x is not provided, push to current branch in remote.
function pgitpush() {
  # Reject if x is main or if x is blank but current branch is main.
  if [ "$1" = "main" ] || ([ -z "$1" ] && [ "$(git symbolic-ref --short HEAD)" = "main" ]); then
    echo "You cannot push directly to the main branch. Use pgitpushmain instead."
    return 1
  fi
  if [ -z "$1" ]; then
    git push --set-upstream origin $(git symbolic-ref HEAD 2>/dev/null)
  fi
  git push --set-upstream origin $1
}

# pgitpushmain - Push the current branch to main. Do so with caution.
function pgitpushmain() {
  # Ask for confirmation (yes or y) before pushing to main.
  read -p "Are you sure you want to push to main? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Push to main aborted."
    return 1
  fi
  git push --set-upstream origin main
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
    echo "You are not on the main branch. Commit aborted."
    return 1
  fi
  if [ -z "$1" ]; then
    echo "You must provide a commit message."
    return 1
  fi
  git add . && git commit -m "$1" && git push --set-upstream origin main
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

# pgitm x - Merge x into your current branch. Aliases: pgitmerge.
function pgitm() {
  if [ -z "$1" ]; then
    echo "You must provide a branch name."
    return 1
  fi
  git merge "$1"
}
alias pgitmerge="pgitm"


################################################################################
# POTPURRI
################################################################################

alias srcbashrc="source ~/.bashrc"
alias codebashrc="code ~/.bashrc"
