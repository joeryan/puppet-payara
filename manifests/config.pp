# == Definition: payara::config
#
# Configure a payara instance.
#
# === Parameters:
#
# @param app_home    [String]  Payara app dir
#
# @param user        [String]  Payara app user
#
# @param properties  [Hash]  Payara properties
#
define payara::config (
  $app_home,
  $user       = $name,
  $properties = {
  }
) {
  $content = $properties.map |$prop| { "${prop[0]}=${prop[1]}" }

  file { "${app_home}/configuration/logback.xml":
    content => template('payara/logback.xml.erb'),
    owner   => $user,
    group   => 'payara',
    require => File["${app_home}/configuration"],
  }

  file { "${app_home}/configuration/logging.properties":
    content => template('payara/logging.properties.erb'),
    owner   => $user,
    group   => 'payara',
    require => File["${app_home}/configuration"],
  }

  file { "${app_home}/configuration/bootstrap.properties":
    ensure  => file,
    content => join($content, "\n"),
    owner   => $user,
    group   => 'payara',
    require => File["${app_home}/configuration"],
  }
}
