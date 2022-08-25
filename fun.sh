cleanup_git_branches() {
  DEFAULT_BRANCH=`basename $(git symbolic-ref refs/remotes/origin/HEAD)`
  git switch $DEFAULT_BRANCH
  git branch --merged | grep -v $DEFAULT_BRANCH | while read branch
  	do
  		git branch -d $branch
  	done
  git fetch -p
  for BRANCH_NAME in $(git branch -v | grep '\[gone\]' | awk '{print $1}')
  	do
  		git branch -D $BRANCH_NAME
  	done
}
