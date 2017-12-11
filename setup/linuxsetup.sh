#!/bin/bash
echo "########## SETUP START ##########"
echo "Hello, $(whoami)!"

echo "-- setxkbmap fi --"
setxkbmap fi

echo "-- Set timezone to Helsinki/Finland --"
sudo timedatectl set-timezone Europe/Helsinki

echo "-- Package update and installation for git, tree, puppet --"
sudo apt-get update
sudo apt-get install -y git tree puppet

echo "-- Cloning git repository --"
git clone https://github.com/miikkahuuskonen/KeskitettyHallinta.git

echo "-- Copying files to puppet config --"
cd KeskitettyHallinta/puppet/
sudo cp -TRv /home/$(whoami)/KeskitettyHallinta/puppet/ /etc/puppet/
cd /etc/puppet/

echo "-- Applying site.pp --"
sudo puppet apply /etc/puppet/manifests/site.pp

echo "########## SETUP DONE ##########"
