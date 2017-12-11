# Puppet moduuli

#### Asennettavat ohjelmat skriptin avulla:

puppet, git, tree

#### Asennettavat ohjelmat puppetilla:

Atom, Slack, Skype

### Aloitus
1. Päivitetään pakettikanta
	sudo apt-get update

2. Ladataan Atomin asennustiedosto (.deb tiedosto) ja asennetaan Atom
	sudo dpkg -i atom-amd64(1).deb

3. Ladataan Slackin asennustiedosto (.deb tiedosto) ja asennetaan Slack
	sudo dpkg -i slack-desktop-3.0.0-amd64.deb

4. Ladataan Skypen asennustiedosto (.deb tiedosto) ja asennetaan Skypen
	sudo dpkg -i skypeforlinux-64.deb


#### Moduulin init.pp
```
class dev-mod {

        file { '/tmp/atom-amd64.deb':
                ensure => present,
                mode => 664,
                owner => root,
                group => root,
                source => "puppet:///files/atom-amd64.deb"
        }
        
        file { '/tmp/slack-desktop-3.0.0-amd64.deb':
                ensure => present,
                mode => 664,
                owner => root,
                group => root,
                source => "puppet:///files/slack-desktop-3.0.0-amd64.deb"
        }

        file { '/tmp/skypeforlinux-64.deb':
                ensure => present,
                mode => 664,
                owner => root,
                group => root,
                source => "puppet:///files/skypeforlinux-64.deb"
        }

        package { 'atom':
                provider => dpkg,
                ensure => installed,
                source => '/tmp/atom-amd64.deb'
        }

        package { 'slack-desktop':
                provider => dpkg,
                ensure => installed,
                source => '/tmp/slack-desktop-3.0.0-amd64.deb'
        }

        package { 'skypeforlinux':
                provider => dpkg,
                ensure => installed,
                source => '/tmp/skypeforlinux-64.deb'
        }

}
```
