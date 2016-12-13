class payara::install {
  package { 'payara-micro':
    ensure  => 'latest',
    require => Package['rotate'],
  }
  package { 'rotate': ensure => present }
}

