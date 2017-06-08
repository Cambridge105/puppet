class role_rivendell_client {
  package { 'git':
    ensure => latest,
  }
  package { 'wget':
    ensure => latest,
  }
  package { 'vim':
    ensure => latest,
  }

  file { '/rdbuild':
    ensure => directory,
  }

  exec { 'Download Rivendell source':
    creates => '/rdbuild/rivendell-2.16.0.tar.gz',
    command => '/usr/bin/wget https://github.com/ElvishArtisan/rivendell/archive/v2.16.0.tar.gz -O /rdbuild/rivendell-2.16.0.tar.gz',
    require => File['/rdbuild'],
  }

  exec { 'Unzip Rivendell source':
    creates => '/rdbuild/configure',
    command => '/bin/tar xzf /rdbuild/rivendell-2.16.0.tar.gz',
    cwd => '/rdbuild',
    require => Exec['Download Rivendell source'],
  }

  exec { 'Configure Rivendell':
    command => './configure',
    cwd => '/rdbuild/rivendell-2.16.0',
    path => $::path,
    require => Exec['Unzip Rivendell source'],
  }
}
