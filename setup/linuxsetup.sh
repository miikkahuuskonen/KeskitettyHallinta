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

mkdir .config/autostart/

echo "-- Downloading Atom, Slack and Skype .deb files--"
cd KeskitettyHallinta/puppet/

mkdir files
cd files

wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.0-amd64.deb
wget https://atom-installer.github.com/v1.22.1/atom-amd64.deb
wget https://repo.skype.com/latest/skypeforlinux-64.deb

cd

echo "-- Copying files to puppet config --"
cd KeskitettyHallinta/puppet/
sudo cp -TRv /home/$(whoami)/KeskitettyHallinta/puppet/ /etc/puppet/
cd /etc/puppet/

echo "-- Applying site.pp --"
sudo puppet apply /etc/puppet/manifests/site.pp

echo "########## SETUP DONE ##########"
