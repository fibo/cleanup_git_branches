# git cleanBranches

> Remove unused git branches

[![KLP](https://fibo.github.io/svg/badges/klp.svg)](https://fibo.github.io/kiss-literate-programming)

## Usage

Simply launch the following command in a git repo

```sh
git cleanBranches
```

## Installation

Git recognizes any executables in your path that are named git-* as git commands. So to install:

1. get the [git-cleanBranches](./git-cleanBranches) file
2. make it executable
3. add it to your `$PATH`

So for example, you can do something like

```sh
mkdir -p ~/.shell
cd ~/.shell
git clone https://github.com/fibo/git_cleanBranches.git
echo 'export PATH="$HOME/.shell/git_cleanBranches:$PATH"' >> $HOME/.zprofile
```

With the setup above, to update run the following

```sh
cd ~/.shell/git_cleanBranches
git pull origin main --rebase
```

## Annotated source

To generate sources, enter this repo folder and run `make`.

    #!/bin/sh

Get current working branch and repo default branch.

    WORKING_BRANCH=`git rev-parse --abbrev-ref HEAD`
    DEFAULT_BRANCH=`basename $(git symbolic-ref refs/remotes/origin/HEAD)`

Go to default branch.

    if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
      git switch $DEFAULT_BRANCH
    fi

Remove local branches (excluding main branch) that are already merged.

    git branch --merged | grep -v $DEFAULT_BRANCH | while read BRANCH_NAME
      do
        git branch -d $BRANCH_NAME
      done

Remove local branches and worktrees which remote reference does not exist anymore.

    git fetch --prune
    for BRANCH_REF in $(git branch -v | grep '\[gone\]' | grep '^+' | awk '{print $3}')
      do
        git worktree remove `git worktree list | grep $BRANCH_REF | awk '{print $1}'`
      done
    for BRANCH_NAME in $(git branch -v | grep '\[gone\]' | awk '{print $1}')
      do
        git branch -D $BRANCH_NAME
      done

Back to previous branch.

    if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
      git switch $WORKING_BRANCH
    fi


## Tip

If you need to change default branch, once done remotely (for instance on GitHub),
you need to update your local repository.

Assuming the new default branch is `main`, launch

```sh
git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
```

## License

[MIT](https://fibo.github.io/mit-license)

