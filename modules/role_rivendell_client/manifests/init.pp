class role_rivendell_client {
  require ::role_rivendell_client::packages

  file { '/rdbuild':
    ensure => directory,
  }

  vcsrepo { "/rdbuild/rivendell":
    ensure => present,
    provider => git,
    source => 'https://github.com/ElvishArtisan/rivendell.git',
    require => [ Package['git'], File['/rdbuild'] ],
    user => 'root',
    revision => 'v3.0.0beta00',
  }

  exec { 'Autogen Rivendell':
    command => '/bin/bash autogen.sh',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Vcsrepo['/rdbuild/rivendell'],
    creates => '/rdbuild/rivendell/configure',
    logoutput => true,
  }

  exec { 'Configure Rivendell':
    command => '/bin/bash configure',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Exec['Autogen Rivendell'],
    creates => '/rdbuild/rivendell/Makefile',
    logoutput => true,
  }

  exec { 'Build Rivendell':
    command => 'make',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Exec['Configure Rivendell'],
    creates => '/rdbuild/rivendell/web/rdxport/rdxport.cgi',
    environment => [
      "DOCBOOK_STYLESHEETS='/usr/share/xml/docbook/stylesheet/docbook-xsl'"
    ],
    logoutput => true,
    timeout => 1200, # It takes a while to build...
  }
}
