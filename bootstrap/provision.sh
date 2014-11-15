#!/usr/bin/env sh

# vagrant provisioning script for first-time load of a dev box

echo "*********************************"
echo
echo  Installing nodejs, redis, etc.
echo
echo "*********************************"

apt-get update -qq
apt-get install nodejs npm git-core build-essential redis-server -qy

# ubuntu still ships it as 'nodejs' rather than 'node'
if [ ! -f /usr/bin/node ]
then
  ln -s /usr/bin/nodejs /usr/bin/node
fi

# auto-download and install elvis on login
grep elvis /home/vagrant/.bashrc || echo ". update-elvis.sh" >> /home/vagrant/.bashrc
