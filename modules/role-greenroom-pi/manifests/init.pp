class role-greenroom-pi {
	require info-display

	cron { 'pollmiclive':
		command => '/usr/bin/python /home/pi/studio-screen/pollStudioState.py 8081',
		ensure => present,
		special => 'reboot',
		user => 'root',
	}
}