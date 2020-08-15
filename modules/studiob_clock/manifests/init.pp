class studiob_clock {
  require info_display
  class { 'info_display::kiosk_browser':
    url => 'http://localhost/index.html?studio=b',
  }

  # HDMI configuration for Studio B's LCD display embedded in the mixing desk front panel

  file_line {'HDMI hotplug':
    line  => 'hdmi_force_hotplug=1',
    path  => '/boot/config.txt',
    match => '.*hdmi_force_hotplug.*', # /.*match/
  }

  file_line {'HDMI group':
    line  => 'hdmi_group=2',
    path  => '/boot/config.txt',
    match => '.*hdmi_group.*', # /.*match/
  }

  file_line {'HDMI mode':
    line  => 'hdmi_mode=87',
    path  => '/boot/config.txt',
    match => '.*hdmi_mode.*', # /.*match/
  }

  file_line {'HDMI CVT':
    line  => 'hdmi_cvt 1024 600 60 6 0 0 0',
    path  => '/boot/config.txt',
    match => '.*hdmi_cvt.*', # /.*match/
  }
}
