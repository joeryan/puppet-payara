#
# Payara default params class
#
class payara::params {
  $payara_user     = 'payara'
  $payara_group    = 'payara'
  $payara_uid      = 200
  $payara_gid      = 200
  $payara_app_dir  = '/data/apps/payara'
  $payara_log_dir  = '/data/logs/payara'
  $payara_log_host = 'localhost'
  $payara_home     = '/opt/payara'
  $bind_address    = '127.0.0.1'
}
