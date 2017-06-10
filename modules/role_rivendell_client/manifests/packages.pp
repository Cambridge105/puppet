class role_rivendell_client::packages {
  package { 'git':
    ensure => latest,
  }
  package { 'wget':
    ensure => installed,
  }
  package { 'vim':
    ensure => installed,
  }
  package { 'openssh-server':
    ensure => installed,
  }

  package { 'mariadb-server':
    ensure => latest,
  }
  package { 'mariadb-client':
    ensure => latest,
  }

  package { 'libqt4-sql-mysql':
    ensure => installed,
  }

  # All the stuff we need for building Rivendell...
  package {'autoconf':
    ensure => installed,
  }
  package {'build-essential':
    ensure => installed,
  }
  package {'libtool':
    ensure => installed,
  }
  package { 'libqt4-dev':
    ensure => installed,
  }
  package { 'libsamplerate-dev':
    ensure => installed,
  }
  package { 'libsndfile-dev':
    ensure => installed,
  }
  package { 'libcdparanoia-dev':
    ensure => installed,
  }
  package { 'libid3-dev':
    ensure => installed,
  }
  package { 'libcurl4-openssl-dev':
    ensure => latest,
  }
  package { 'libpam-dev':
    ensure => installed,
  }
  package { 'libsoundtouch-dev':
    ensure => installed,
  }
  package { 'libmad0-dev':
    ensure => installed,
  }
  package { 'libasound-dev':
    ensure => installed,
  }
  package { 'libmp4v2-dev':
    ensure => installed,
  }
  package { 'libfaad-dev':
    ensure => installed,
  }
  package { 'libflac++-dev':
    ensure => installed,
  }
  package { 'xsltproc':
    ensure => installed,
  }
  package {'docbook-xsl':
    ensure => installed,
  }
  package { 'fop':
    ensure => installed,
  }
}
