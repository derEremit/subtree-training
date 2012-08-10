#!/bin/bash
#subtree installation

# dir for generation of the example

testdir=~/temp/subtreetest

#install git subtree if not already present
if ! [ -f /usr/lib/git-core/git-subtree ]
then
  cd /tmp
  git clone git://github.com/apenwarr/git-subtree.git
  cd git-subtree
  sudo bash install.sh
fi


#exampleprojekt

# clean up if previous versions exist
rm -rf ~/temp/subtreetest

#setup repositories
mkdir -p $testdir
cd $testdir

mkdir .repo
cd .repo

mkdir example
cd example
git init --bare
cd ..

mkdir subexample
cd subexample
git init --bare

# checkout and do some commits
cd $testdir

git clone .repo/example
cd example
touch foo bar baz
git init
git add .
git commit -m "init"
git push origin master

cd $testdir
git clone .repo/subexample
cd subexample
touch subfoo subbar subbaz
git init
git add .
git commit -m "init sub"
echo "something" >> subfoo
git add .
git commit -m "something in subfoo"
git push origin master


