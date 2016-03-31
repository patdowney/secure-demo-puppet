# Class: ca::bundle_host
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
class ca::bundle_host(
  Integer $port    = 80,
  $tls_cert = undef,
  $tls_key  = undef
) {
  include ::cfssl
  include ::nginx

  nginx::resource::vhost { 'bundles-vhost':
    www_root => "${cfssl::config_root}/bundles",
    require  => File[$::cfssl::config_root]
  }

}
