#!/bin/bash
echo "#################################"
echo "Hello, $(whoami)!"

setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki

sudo apt-get update
sudo apt-get install -y git tree puppet

git clone https://github.com/miikkahuuskonen/KeskitettyHallinta.git

cd KeskitettyHallinta/puppet/
sudo cp -TRv /home/$(whoami)/KeskitettyHallinta/puppet/ /etc/puppet/
cd /etc/puppet/

sudo puppet apply -e 'class {"hellomiikka":}'

cat /tmp/hellomiikka.txt

echo "#################################"
echo "Everythings ready, happy hacking!"
