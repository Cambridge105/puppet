class info_display {
  package { 'chromium':
    ensure => latest,
  }

  package {'vim':
    ensure => present,
  }

  package { 'ntp':
    ensure => present,
  }

  package { 'git':
    ensure => present,
  }

  service {'ntp':
    ensure  => running,
    require => Package['ntp'],
  }

  package { 'python':
    ensure => present,
  }

  package { 'python-pip':
    ensure => present,
  }

  package { 'web.py':
    ensure   => present,
    provider => pip,
    require  => Package['python-pip'],
  }

  service { 'ssh':
    ensure => running,
    enable => true,
  }

  file { '/home/pi/.config/lxsession/LXDE-pi':
    ensure => directory,
    owner  => 'pi',
    group  => 'pi',
  }
  file { '/etc/timezone':
    ensure  => present,
    content => "Europe/London\n",
  }
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Europe/London',
  }

  vcsrepo { '/home/pi/studio-screen':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/Cambridge105/studio-screen.git',
    require  => [ Package['git'] ],
    user     => 'pi',
    revision => 'master',
  }

  class { 'nginx':
    server_purge => true,
  }

  nginx::resource::server { 'localhost':
    server_name    => ['localhost'],
    listen_options => 'default_server',
    www_root       => '/home/pi/studio-screen',
  }

  ini_setting { 'xserver-command':
    ensure  => present,
    path    => '/etc/lightdm/lightdm.conf',
    section => 'SeatDefaults',
    setting => 'xserver-command',
    value   => 'X -s 0 dpms',
  }

  cron { 'update-schedule':
    ensure  => present,
    command => 'wget -O /home/pi/studio-screen/schedule.js http://cambridge105.fm/schedule_info/get_schedule_entries_min.php',
    user    => 'pi',
    hour    => [0, 12, 21],
    minute  => [15],
  }
}
