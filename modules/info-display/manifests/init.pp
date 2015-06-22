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
}