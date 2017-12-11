```
class desktop {

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
