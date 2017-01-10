# == Class: payara
#
# Installs the payara micro application server:
# http://www.payara.fish/payara_micro
#
# === Parameters
#
# [*uid]: uid of the payara installation. Default 200
#
# [*gid]: gid of the payara installation. Default 200
#
# [user*]: user of the payara installation. Default payara
#
# [group*]: group of the payara installation. Default payara
#
# [payara_app_dir*]: Location of the payara instances. Default /data/apps/payara
#
# [payara_log_dir*]: Location of the payara instances log files. Default /data/logs/payara
#
# [payara_log_host*]: Syslog host. Default localhost
#

class payara (
  $uid            = $payara::params::payara_uid,
  $gid            = $payara::params::payara_gid,
  $user           = $payara::params::payara_user,
  $group          = $payara::params::payara_group,
  $payara_app_dir = $payara::params::payara_app_dir,
  $payara_log_dir = $payara::params::payara_log_dir) inherits payara::params {
  class { 'payara::prepare':
    payara_uid     => $uid,
    payara_gid     => $gid,
    payara_user    => $user,
    payara_group   => $group,
    payara_app_dir => $payara_app_dir,
    payara_log_dir => $payara_log_dir,
  }
  include payara::install
  Class['payara::prepare'] ->
  Class['payara::install']
}

