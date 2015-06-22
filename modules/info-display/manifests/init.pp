class info-display {
	package { 'iceweasel':
		ensure => latest,
	}

	package {'vim':
		ensure => latest,
	}

	package { 'ntp':
		ensure => latest,
	}

	service {'ntp':
		ensure => running,
		require => Package['ntp'],
	}

	package { 'python':
		ensure => latest,
	}

	service { 'ssh':
		enable => true,
		ensure => running,
	}

	file { '/etc/xdg/lxsession/LXDE-pi/autostart':
		source => 'puppet:///modules/info-display/autostart',
		ensure => present,
		owner => root,
		group => root,
	}
}