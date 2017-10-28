class role-studioa-pi {
	require info-display
	
	file { '/etc/xdg/lxsession/LXDE-pi/autostart':
		source => 'puppet:///modules/role-studioa-pi/autostart',
		ensure => present,
		owner => root,
		group => root,
	}

	file { '/home/pi/.config/lxsession/LXDE/autostart':
		source => 'puppet:///modules/role-studioa-pi/autostart',
		ensure => present,
		owner => pi,
		group => pi,
	}


	cron { 'pollmiclive':
		command => '/usr/bin/python /home/pi/studio-screen/pollMicLive.py 8081',
		ensure => present,
		special => 'reboot',
		user => 'root',
	}
}