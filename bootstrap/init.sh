#!/usr/bin/env sh

ELVIS_REPO_URL=https://github.com/memtech/elvis.git

apt-get update -qq
apt-get install nodejs npm git-core build-essential -qy

# skip this if the directory already exists
#if [ ! -d elvis ]
#then
  #sudo -u vagrant git clone $ELVIS_REPO_URL
#fi

#cd elvis
#sudo -u vagrant git pull
