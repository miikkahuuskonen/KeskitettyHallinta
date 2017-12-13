# Puppet moduuli

Toteutettu: Linux Xubuntu 16.04.3 ja Puppet 3.8.5 // Testattu MacBook Pro 15" (mid2010) 13.12.2017

Tehdään moduuli puppetille, joka asentaa orjakoneille ohjelmistokehitykseen tarvittavia perustyökaluja, kuten
Atom, Slack sekä git. Lisäksi asennetaan Skype yhteydenpito-ohjelmaksi.

### Asennettavat ohjelmat skriptin avulla:

puppet, git, tree

### Asennettavat ohjelmat puppetilla:

Atom, Slack, Skype

### Aloitus - skriptin toiminta
Haetaan ja ajetaan skripti (linuxsetup.sh), joka ensin asettaa näppäimistön suomenkieliseksi ```setxkbmap fi``` ja alueeksi
Europe/Helsinki ```sudo timedatectl set-timezone Europe/Helsinki```.

```bash
wget -O - https://raw.githubusercontent.com/miikkahuuskonen/KeskitettyHallinta/master/setup/linuxsetup.sh | bash
```

Tämän jälkeen skripti päivittää pakettikannan ```sudo apt-get update``` ja asentaa ohjelmat git, tree ja puppet: 
```sudo apt-get install -y git tree puppet```.

Skripti kloonaa git-repon: ```git clone https://github.com/miikkahuuskonen/KeskitettyHallinta.git```
ja lisäksi luo käyttäjän kotihakemistoon .atom/ kansion valmiiksi siihen tulevaa asetustiedostoa varten.

Seuraavaksi skripti luo files kansion KeskitettyHallinta/puppet/ hakemistoon ja hakee files-kansioon puppetilla asennettavien ohjelmien .deb tiedostot. Tähän ratkaisuun päädyin tätä tehtävää varten, koska githubin versionhallinta ei tykkää yli 50mb tiedostoista ja lataaminen puppet-moduulin avulla ei onnistunut.

```
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.0-amd64.deb
wget https://atom-installer.github.com/v1.22.1/atom-amd64.deb
wget https://repo.skype.com/latest/skypeforlinux-64.deb
```
Tässä on huomioitavaa, että latauspaikka voi vaihtua ja lisäksi versionhallinta ainakaan Slackin ja Atomin kohdalla ei toimi, koska linkit viittaavat tiettyihin versioihin. Nämä testattu 13.12.2017 toimiviksi.

Tämän jälkeen skripti kopioi KeskitettyHallinta/puppet/ hakemiston ja korvaa hakemiston /etc/puppet/ sisällön:

```
sudo cp -TRv /home/$(whoami)/KeskitettyHallinta/puppet/ /etc/puppet/
```

Seuraavaksi otetaan moduuli käyttöön:
```
sudo puppet apply /etc/puppet/manifests/site.pp
```

Puppetin moduulin asennus ja käyttöönotto on valmis.

### Moduulin init.pp sisältö

Moduuli hakee ohjelmien asennustiedostot files-kansiosta ja asentaa ohjelmat.
Lisäksi se hakee moduulin templates osiosta asetuksen Skypelle, joka estää ohjelman automaattisen käynnistymisen ja
Atomille, jonka asetuksissa estetään tietojen lähetys kehittäjälle sekä welcome-ruudun avautuminen.

Moduulia tehdessäni huomasin, että Atomin asetukset ovat käyttäjän kotihakemistossa .atom/ kansion alla, joka luodaan vasta Atom ensiavauksen jälkeen, mutta joka korvataan asetustiedostolla tässä moduulissa.

Ensimmäisiä kertoja moduulia ajettaessa, ei Slack-desktop suostunut asentumaan täysin vaan valitti, että 'libappindicator1' puuttuu eikä asennus ole täydellinen. Asiaa tutkiessani löysin avun osoitteesta [https://unix.stackexchange.com/questions/191551/missing-libappindicator1],
jossa kehoitettiin asentamaan kyseinen osanen, joten lisäsin sen moduuliin asennettavaksi.

Puppet toimii root-oikeuksilla ja näin ollen käyttäjän kotihakemistoa on ei voida määrittää, tein moduuliin muuttujan $userhome, joka viittaa hakemistoon /home/xubuntu (Xubuntu on oletuskäyttäjä käyttöjärjesatelmässä).

#### init.pp
```
class dev-mod {
        File { owner => '0', group => '0', mode => '0644', }
        Package { ensure => 'installed', allowcdrom => true, }
	$userhome = '/home/xubuntu'
	
	package { 'libappindicator1':
                ensure => installed,
        }

	file { "${userhome}/.config/autostart":
		ensure => 'directory',
	}

        file { '/tmp/atom-amd64.deb':
                ensure => present,
                source => "puppet:///files/atom-amd64.deb"
        }

        file { '/tmp/slack-desktop-3.0.0-amd64.deb':
                ensure => present,
                source => "puppet:///files/slack-desktop-3.0.0-amd64.deb"
        }

        file { '/tmp/skypeforlinux-64.deb':
                ensure => present,
                source => "puppet:///files/skypeforlinux-64.deb"
        }

        package { 'atom':
                provider => dpkg,
                source => '/tmp/atom-amd64.deb'
        }

        package { 'slack-desktop':
                provider => dpkg,
                source => '/tmp/slack-desktop-3.0.0-amd64.deb'
        }

        package { 'skypeforlinux':
                provider => dpkg,
                source => '/tmp/skypeforlinux-64.deb'
        }

        file { "${userhome}/.config/autostart/skypeforlinux.desktop":
                content => template('dev-mod/skypeforlinux.desktop'),
        }

	file { "${userhome}/.atom/config.cson":
		ensure => 'present',
		replace => 'yes',
		owner => xubuntu,
                group => xubuntu,
                content => template('dev-mod/config.cson'),
        }

}

```
Moduulin asennus on nyt valmis.



### Lähteet:
https://www.puppetcookbook.com

http://terokarvinen.com/2017/simpler-puppet-manifests-resource-defaults-and-manifest-ordering

https://jwpitkanen.wordpress.com/kurssit/hallinta-harjoitus-4/

https://github.com/Miikka-Alatalo/puppet/tree/master/tehtavat/h4
