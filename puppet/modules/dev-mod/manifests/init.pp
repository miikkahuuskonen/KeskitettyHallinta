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

