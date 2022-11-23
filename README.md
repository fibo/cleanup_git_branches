# cleanup_git_branches

> remove unused git branches with one command

[Usage](#usage) |
[Installation](#installation) |
[Annotated source](#annotated-source) |
[License](#license)

[![KLP](https://fibo.github.io/svg/klp-badge.svg)](https://fibo.github.io/kiss-literate-programming)

## Usage

Simply launch the following command in a git repo

```sh
cleanup_git_branches
```

## Installation

Both *zsh* and *bash* shell are supported.

Just copy and paste the `cleanup_git_branches` function below in your shell profile or (assuming you are using zsh) do something like

```sh
mkdir -p ~/.shell
cd ~/.shell
git clone https://github.com/fibo/cleanup_git_branches.git
echo "source ~/.shell/cleanup_git_branches/fun.sh" >> ~/.zshrc
```

With the setup above, to update run the following

```sh
cd ~/.shell/cleanup_git_branches
git pull origin main
source ~/.zshrc
cd -
```

## Annotated source

To generate sources, enter this repo folder and run `make`.

Create a `cleanup_git_branches` function

    cleanup_git_branches() {

Get current working branch and repo default branch.

      WORKING_BRANCH=`git rev-parse --abbrev-ref HEAD`
      DEFAULT_BRANCH=`basename $(git symbolic-ref refs/remotes/origin/HEAD)`

Go to default branch.

      if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
        git switch $DEFAULT_BRANCH
      fi

Remove local branches (excluding main branch) that are already merged.

      git branch --merged | grep -v $DEFAULT_BRANCH | while read branch
      	do
      		git branch -d $branch
      	done

Remove local branches with no remote reference.

      git fetch -p
      for BRANCH_NAME in $(git branch -v | grep '\[gone\]' | awk '{print $1}')
      	do
      		git branch -D $BRANCH_NAME
      	done

Back to previous branch.

      if [ "$DEFAULT_BRANCH" != "$WORKING_BRANCH" ]; then
        git switch $WORKING_BRANCH
      fi
    }

## License

[MIT](https://fibo.github.io/mit-license)

