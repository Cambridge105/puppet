class studioa-pi {
	require info-display

	cron { 'poll-miclive':
		command => '/usr/bin/python /home/pi/studio-screen/pollMicLive.py 8081',
		ensure => present,
		special => 'reboot',
	}
}