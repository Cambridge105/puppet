class info_display::kiosk_browser(
  String $url = 'http://localhost/',
  String $scale_factor = '1', # Smaller number = zoom out
  ) {

  $autostart_file = "@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@xset s off
@xset -dpms
@xset s noblank
@chromium -url ${url} --start-fullscreen --kiosk --incognito --disable-infobars --force-device-scale-factor=${scale_factor}
"
  file { '/etc/xdg/lxsession/LXDE-pi/autostart':
    ensure  => present,
    content => $autostart_file,
    owner   => 'root',
    group   => 'root',
  }

  file { '/home/pi/.config/lxsession':
    ensure => directory,
    owner  => 'pi',
    group  => 'pi',
  }
  file { '/home/pi/.config/lxsession/LXDE-pi':
    ensure  => directory,
    owner   => 'pi',
    group   => 'pi',
    require => File['/home/pi/.config/lxsession'],
  }
  file { '/home/pi/.config/lxsession/LXDE-pi/autostart':
    ensure  => present,
    content => $autostart_file,
    owner   => 'pi',
    group   => 'pi',
    require => File['/home/pi/.config/lxsession/LXDE-pi'],
  }
}
