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
  $cas                  = [], # Array
  $address              = ':8888', # String
  $multirootca_loglevel = 1, # Integer
  $config               = {}, # Hash
  $tls_cert             = undef, # String
  $tls_key              = undef # String
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

  service { 'multirootca':
    ensure  => running,
    enabled => true,
    require => [ File["${cfssl::config_root}/multirootca-config.json"], Package['cfssl'] ]
  }

}
