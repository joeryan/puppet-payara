class payara::install {
  package { 'payara-micro':
    ensure  => 'latest',
    require => [Package['rotate'], Java::Oracle['8']]
  }

  package { 'rotate': ensure => present }

  java::oracle { '8':
    ensure  => present,
    version => 8,
  }
}

