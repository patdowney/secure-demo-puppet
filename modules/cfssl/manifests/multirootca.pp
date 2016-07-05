# Class: cfssl::multirootca
# ===========================
#
# Parameters
# ----------
#
# Variables
# --------
#
# Examples
# --------
#
# Authors
# -------
#
# Copyright
# ---------
#
class cfssl::multirootca(
  Array   $cas                  = [],
  String  $address              = ':8888',
  Integer $multirootca_loglevel = 1,
  Hash    $config               = {},
  String  $tls_cert             = undef,
  String  $tls_key              = undef
) {
  include ::cfssl

  file {
    "${cfssl::config_root}/multirootca-config.json":
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0440',
      content => template('cfssl/config.json.erb'),
      require => Class['cfssl::install'],
      notify  => Service['cfssl-multirootca']
  }

  if $tls_cert {
    $tls_cert_arg = "-tls-cert ${tls_cert}"
  } else {
    $tls_cert_arg = ''
  }

  if $tls_key {
    $tls_key_arg = "-tls-key ${tls_key}"
  } else {
    $tls_key_arg = ''
  }

  daemontools::service {'cfssl-multirootca':
    ensure  => running,
    command => "/usr/local/bin/multirootca -a ${address} ${tls_cert_arg} ${tls_key_arg} -loglevel ${multirootca_loglevel} -roots ${cfssl::multirootca_ini}",
    logpath => '/var/log/cfssl-multirootca',
    require => Concat[$cfssl::multirootca_ini],
    notify  => Service['daemontools_service']
  }

}