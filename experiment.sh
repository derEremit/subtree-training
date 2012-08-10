#! /bin/bash

#begin with subtree work
cd $testdir
cd example
git remote add subexamplerepo ../.repo/subexample

# add subtree
git subtree add --prefix=subex subexamplerepo master

# do something on subexample
echo "subbar" >> subex/subbar
git add .
git commit -m "subbar in subbar"
echo "subfoo" >> subex/subfoo
git add .
git commit -m "subfoo in subfoo"

# do something on example
echo "baz" >> baz
git add .
git commit -m "baz in baz"
echo "foo" >> foo
git add .
git commit -m "foo in foo"

git push

# subtree split to get changes in subex back upstream
# creates a branch subex/master that contains commits that were for files
# in that subdir
git subtree split -P subex -b subex/master
# you can immediately push those upstream
git push subexamplerepo subex/master:master

# they are now in subexample repo and can be worked on
# upstream work

cd $testdir
cd subexample
git pull
echo "subbar upstream work" >> subbar
git add .
git commit -m "subbar upstream work"
echo "subbaz upstream work" >> subbaz
git add .
git commit -m "subbaz upstream work"
git push

#merge back downstream
cd $testdir
cd example

git fetch subexamplerepo
git subtree pull --squash --prefix=subex subexamplerepo master

