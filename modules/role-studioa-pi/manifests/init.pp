class role-studioa-pi {
  require info_display
  require info_display::kiosk_browser

  cron { 'pollmiclive':
    command => '/usr/bin/python /home/pi/studio-screen/pollMicLive.py 8081',
    ensure => present,
    special => 'reboot',
    user => 'root',
  }
}
