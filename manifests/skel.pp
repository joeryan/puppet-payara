# == Definition: payara::skel
#
# Create payara dir layout
#
# === Parameters:
#
define payara::skel ($user, $group, $log_home) {
  file { [$name, "${name}/data", "${name}/configuration", "${name}/deployments", "${name}/tmp"]:
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $log_home:
    ensure => 'directory',
    owner  => $user,
    group  => 'root',
    mode   => '0755',
  }

}
