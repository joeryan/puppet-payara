# == Definition: payara::deployment
#
# Configure a payara instance.
#
# === Parameters:
#

define payara::deployment (
  $uid,
  $log_display,
  $elastic_host,
  $elastic_index,
  $log_remove_days  = '30',
  $log_rotate_files = undef,
  $port_offset      = 0,
  $xms              = '128',
  $xmx              = '256',
  $usergroups       = [],
  $app_home         = "/data/apps/payara/${name}",
  $log_home         = "/data/logs/payara/${name}",) {
  include payara::params

  $jmxdebug  = $::environment ? {
    dev     => true,
    default => false,
  }
  $port_list = {
    'app'   => 8080 + $port_offset,
    'jmx'   => 20000 + $port_offset,
    'debug' => 20001 + $port_offset
  }

  ensure_resource('payara::user', $name, {
    uid        => $uid,
    group      => $payara::params::payara_group,
    usergroups => $usergroups,
    app_home   => $app_home,
    log_home   => $log_home,
  }
  )

  service { $name:
    ensure  => running,
    enable  => true,
    require => File["/etc/init.d/${name}"],
  }

  file { "/etc/init.d/${name}":
    content => template('payara/startscript.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  if $log_rotate_files {
    file { "/etc/logrotate.d/payara_${name}":
      content => template('payara/logrotate.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
    }
  }
}
