class role_rivendell_client {
  package { 'git':
    ensure => latest,
  }
  package { 'curl':
    ensure => latest,
  }

  file { '/rdbuild':
    ensure => directory,
  }

  exec { 'Download Rivendell source':
    creates => '/rdbuild/rivendell-2.16.0.tar.gz',
    exec => '/usr/bin/curl https://github.com/ElvishArtisan/rivendell/archive/v2.16.0.tar.gz > /rdbuild/rivendell-2.16.0.tar.gz',
    require => File['/rdbuild'],
  }

  exec { 'Configure Rivendell':
    exec => './configure',
    cwd => '/rdbuild',
  }
}
