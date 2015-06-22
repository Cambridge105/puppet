class role-studioa-pi {
	require info-display

	cron { 'pollmiclive':
		command => '/usr/bin/python /home/pi/studio-screen/pollMicLive.py 8081',
		ensure => present,
		special => 'reboot',
		user => 'root',
	}
}