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
    revision => 'master',
  }

  exec { 'Autogen Rivendell':
    command => './autogen.sh',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Vcsrepo['/rdbuild/rivendell'],
    creates => '/rdbuild/rivendell/configure',
  }

  exec { 'Configure Rivendell':
    command => './configure',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Exec['Unzip Rivendell source'],
    creates => '/rdbuild/rivendell/Makefile',
  }

  exec { 'Build Rivendell':
    command => 'make',
    cwd => '/rdbuild/rivendell',
    path => $::path,
    require => Exec['Configure Rivendell'],
    creates => '/rdbuild/rivendell/rdairplay/rdairplay',
    environment => {
      DOCBOOK_STYLESHEETS => '/usr/share/xml/docbook/stylesheet/docbook-xsl',
    },
  }
}
