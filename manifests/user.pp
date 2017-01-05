# == Definition: payara::user
#
# create payara application user.
#
# === Parameters:
#
define payara::user ($uid, $group, $usergroups, $app_home, $log_home) {
  user { $name:
    uid     => $uid,
    gid     => $group,
    home    => $app_home,
    shell   => '/bin/bash',
    groups  => $usergroups,
    require => [],
  }
  ensure_resource('payara::skel', $app_home, {
    user     => $name,
    group    => $group,
    log_home => $log_home,
  }
  )
}
