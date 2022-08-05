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

Just copy and paste the `cleanup_git_branches` function below in your shell profile or do something like

```sh
mkdir -p ~/.shell
cd ~/.shell
git clone https://github.com/fibo/cleanup_git_branches.git
# Assuming you are using zsh
echo "source ~/.shell/cleanup_git_branches/fun.sh" >> ~/.zshrc
```

## Annotated source

Create a `cleanup_git_branches` function

    cleanup_git_branches() {
      DEFAULT_BRANCH=`basename $(git symbolic-ref refs/remotes/origin/HEAD)`

Remove local branches (excluding main branch) that are already merged

      git switch $DEFAULT_BRANCH
      git branch --merged | grep -v $DEFAULT_BRANCH | while read branch
      	do
      		git branch -d $branch
      	done

Remove local branches with no remote reference

      git fetch -p
      for BRANCH_NAME in $(git branch -vv | grep '\[gone\]' | awk '{print $1}')
      	do
      		git branch -D $BRANCH_NAME
      	done
    }

## License

[MIT](https://fibo.github.io/mit-license)

