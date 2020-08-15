class camera_server {

  file_line {'start_x':
    line  => 'start_x=1',
    path  => '/boot/config.txt',
    match => '.*start_x.*', # /.*match/
  }
  file_line {'gpu_mem':
    line  => 'gpu_mem=128',
    path  => '/boot/config.txt',
    match => '.*gpu_mem.*', # /.*match/
  }

  file { '/usr/local/bin/camera_server.sh':
    content => '#!/bin/bash
/usr/bin/raspivid -o - -t 0 -n -vf -hf -w 640 -h 360 -fps 12 -b 60000 | cvlc -vvv stream:///dev/stdin  --sout \'#rtp{sdp=rtsp://:8000/}\' :demux=h264',
    mode => '0755',
  }

  file { '/etc/systemd/system/camera_server.service':
    content => '[Unit]
Description=CCTV camera service

[Service]
Type=exec
ExecStart=/usr/local/bin/camera_server.sh
User=pi

[Install]
WantedBy=multi-user.target
',
  }

  service { 'camera_server.service':
    ensure   => running,
    enable   => true,
    require  => File['/etc/systemd/system/camera_server.service'],
    provider => systemd,
  }
}
