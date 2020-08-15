class info_display::kiosk_browser(
  String $url = 'http://localhost/'
  ) {

  $autostart_file = "@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@xset s off
@xset -dpms
@xset s noblank
@chromium-browser -url ${url} --start-fullscreen --kiosk --incognito --disable-infobars
"
  file { '/etc/xdg/lxsession/LXDE-pi/autostart':
    ensure  => present,
    content => $autostart_file,
    owner   => 'root',
    group   => 'root',
  }

  file { '/home/pi/.config/lxsession/LXDE/autostart':
    ensure  => present,
    content => $autostart_file,
    owner   => 'pi',
    group   => 'pi',
  }

}
