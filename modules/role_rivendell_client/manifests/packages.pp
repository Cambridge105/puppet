class role_rivendell_client::packages {
  package { 'git':
    ensure => latest,
  }
  package { 'wget':
    ensure => latest,
  }
  package { 'vim':
    ensure => latest,
  }
  package {'autoconf':
    ensure => latest,
  }
  package {'build-essential':
    ensure => latest,
  }
}
