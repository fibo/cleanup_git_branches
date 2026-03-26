.PHONY: git-cleanBranches

git-cleanBranches:
	grep '    ' README.md | sed -e 's/    //' > git-cleanBranches

