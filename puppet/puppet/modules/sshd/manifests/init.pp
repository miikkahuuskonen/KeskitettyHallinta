class sshd {
	Package { ensure => 'installed', allowcdrom => true, }
	File { owner => '0', group => '0', mode => '0644', }
	Service { ensure => 'running', enable => true,  }

        package { 'openssh-server': }

         file { '/etc/ssh/sshd_config':
                content => template('sshd/sshd_config'),
                notify => Service['ssh'],
	}

        service { 'ssh': }
}
