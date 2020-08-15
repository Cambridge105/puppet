class studiob_clock {
  require info_display
  class { 'info_display::kiosk_browser':
    url => 'http://localhost/index.html?studio=b',
  }
}
