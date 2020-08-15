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

  package { 'git':
    ensure => latest,
  }

  service {'ntp':
    ensure => running,
    require => Package['ntp'],
  }

  package { 'python':
    ensure => latest,
  }

  package { 'python-pip':
    ensure => latest,
  }

  package { 'web.py':
    provider => pip,
    require => Package['python-pip'],
    ensure => installed,
  }

  service { 'ssh':
    enable => true,
    ensure => running,
  }

  file { '/home/pi/.config/lxsession/LXDE':
    ensure => directory,
    owner => pi,
    group => pi,
  }
  ->

  file { '/etc/timezone':
      ensure => present,
      content => "Europe/London\n",
  }
  file { '/etc/localtime':
    ensure => "link",
    target => "/usr/share/zoneinfo/Europe/London",
  }

  vcsrepo { "/home/pi/studio-screen":
    ensure => latest,
    provider => git,
    source => 'https://github.com/Cambridge105/studio-screen.git',
    require => [ Package['git'] ],
    user => 'pi',
    revision => 'master',
  }

  ini_setting { "xserver-command":
    ensure => present,
    path => "/etc/lightdm/lightdm.conf",
    section => "SeatDefaults",
    setting => "xserver-command",
    value => "X -s 0 dpms",
  }

  cron { 'update-schedule':
    command => 'wget -O /home/pi/studio-screen/schedule.js http://cambridge105.fm/schedule_info/get_schedule_entries_min.php',
    user => 'pi',
    ensure => present,
    hour => [0, 12, 21],
    minute => [15],
  }
}
