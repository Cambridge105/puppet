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

  package { 'python3':
    ensure => present,
  }

  package { 'python3-pip':
    ensure => present,
  }

  package { 'web.py':
    ensure   => present,
    provider => pip3,
    require  => Package['python3-pip'],
  }

  service { 'ssh':
    ensure => running,
    enable => true,
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
  # WORKAROUND: https://github.com/voxpupuli/puppet-nginx/issues/1372#issuecomment-611736052
  #
  # This implements Workaround 1 for nginx failing to start on boot because /run/nginx
  # doesn't exist. Once that issue has been resolved, we should remove this
  file { '/etc/systemd/system/nginx.service.d':
    ensure => directory,
  }
  file { '/etc/systemd/system/nginx.service.d/runtime.conf':
    ensure  => present,
    content => "[Service]
RuntimeDirectory=nginx
",
  }
  # WORKAROUND 2: Make sure puppet keeps the file mode to 0700 for /run/nginx
  File <| title == '/run/nginx/client_body_temp' or title == '/run/nginx/proxy_temp' |> {
    mode => '0700',
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
