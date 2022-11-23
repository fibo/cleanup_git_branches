cleanup_git_branches() {
  WORKING_BRANCH=`git rev-parse --abbrev-ref HEAD`
  DEFAULT_BRANCH=`basename $(git symbolic-ref refs/remotes/origin/HEAD)`
  if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
    git switch $DEFAULT_BRANCH
  fi
  git branch --merged | grep -v $DEFAULT_BRANCH | while read branch
  	do
  		git branch -d $branch
  	done
  git fetch -p
  for BRANCH_NAME in $(git branch -v | grep '\[gone\]' | awk '{print $1}')
  	do
  		git branch -D $BRANCH_NAME
  	done
  if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
    git switch $WORKING_BRANCH
  fi
}
