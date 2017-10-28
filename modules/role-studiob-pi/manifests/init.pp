class role-studiob-pi {
	require info-display
	
	file { '/etc/xdg/lxsession/LXDE-pi/autostart':
		source => 'puppet:///modules/role-studiob-pi/autostart',
		ensure => present,
		owner => root,
		group => root,
	}

	file { '/home/pi/.config/lxsession/LXDE/autostart':
		source => 'puppet:///modules/role-studiob-pi/autostart',
		ensure => present,
		owner => pi,
		group => pi,
	}

}