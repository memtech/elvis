#!/usr/bin/env sh

# vagrant provisioning script to be run every time you log in to the box

ELVIS_REPO_URL=https://github.com/memtech/elvis.git

echo "*********************************"
echo
echo Downloading and installing Elvis
echo
echo "*********************************"

# skip this if the directory already exists
if [ ! -d elvis ]
then
  git clone $ELVIS_REPO_URL
fi

cd elvis

git pull
npm install .

echo "*****************************************************"
echo 
echo "Welcome to Elvis!  Type 'bin/hubot' to try me out."
echo
echo "*****************************************************"
