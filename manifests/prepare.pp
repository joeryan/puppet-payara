#
# Payara installation preparation class
#
class payara::prepare ($payara_uid, $payara_gid, $payara_user, $payara_group, $payara_app_dir, $payara_log_dir) {
  File {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { [$payara_app_dir, $payara_log_dir]: }

  user { $payara_user:
    ensure  => present,
    uid     => $payara_uid,
    gid     => $payara_gid,
    require => Group[$payara_group],
  }

  group { $payara_group:
    ensure => present,
    gid    => $payara_gid,
  }
}

