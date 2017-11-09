## Linkki automaattisiin Puppetin asetuksiin:
```bash
wget -O - https://raw.githubusercontent.com/miikkahuuskonen/KeskitettyHallinta/master/setup/linuxsetup.sh | bash
```

## Manuaalinen asennus:

### Näppäimistön kieli, aikavyöhykkeen asetus, pakettinhallinnan päivitys ja tarvittavien pakettien asennus:
```bash
setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki
sudo apt-get update
sudo apt-get install -y git tree puppet
```
### Git-repon kloonaus:
```bash
git clone https://github.com/miikkahuuskonen/KeskitettyHallinta.git
```
### Tiedostojen kopionti ja puppetin modulin käyttöönotto:
```bash
cd KeskitettyHallinta/puppet
sudo cp -TRv /home/$(whoami)/KeskitettyHallinta/puppet/ /etc/puppet/
cd /etc/puppet/

sudo puppet apply -e 'class {"hellomiikka":}'
```
