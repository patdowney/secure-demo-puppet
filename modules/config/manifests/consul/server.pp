# Class: config::consul::server
# =============================
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
class config::consul::server(
  String  $datacenter,
  String  $encrypt_key,
  String  $cert_file,
  String  $key_file,
  String  $ca_file,
  String  $advertise_addr         = $::ipaddress_eth0,
  String  $listen_addr            = $::ipaddress_eth0,
  String  $version                = '0.6.4',
  Integer $bootstrap_expect       = 1,
  String  $log_level              = 'INFO',
  Array   $start_join             = undef,
  Boolean $verify_incoming        = false,
  Boolean $verify_outgoing        = false,
  Boolean $verify_server_hostname = false,
  Integer $http_port              = 8500,
  Integer $https_port             = -1,
  $acl_datacenter                 = undef,
  $acl_default_policy             = undef,
  $acl_master_token               = undef,
  $acl_token                      = undef,
  $acls                           = {}
) {

  if $start_join {
    if member($start_join, $listen_addr) {
      $consul_start_join = undef
    } else {
      $consul_start_join = $start_join
    }
  } else {
    $consul_start_join = $start_join
  }

  class { '::consul':
    version     => $version,
    config_hash => {
      'bootstrap_expect'       => $bootstrap_expect,
      'data_dir'               => '/opt/consul',
      'datacenter'             => $datacenter,
      'log_level'              => $log_level,
      'advertise_addr'         => $advertise_addr,
      'addresses'              => {
        'rpc' => $listen_addr
      },
      'enable_syslog'          => true,
      'node_name'              => $::hostname,
      'server'                 => true,
      'encrypt'                => $encrypt_key,
      'start_join'             => $consul_start_join,
      'cert_file'              => $cert_file,
      'key_file'               => $key_file,
      'ca_file'                => $ca_file,
      'ports'                  => {
        'http'  => $http_port,
        'https' => $https_port
      },
      'verify_incoming'        => $verify_incoming,
      'verify_outgoing'        => $verify_outgoing,
      'verify_server_hostname' => $verify_server_hostname,
      'acl_datacenter'         => $acl_datacenter,
      'acl_default_policy'     => $acl_default_policy,
      'acl_master_token'       => $acl_master_token,
      'acl_token'              => $acl_token,
      'disable_remote_exec'    => true
    }
  }

  file { '/etc/consul/acl.d':
    ensure  => directory,
    owner   => 'consul',
    require => File['/etc/consul']
  }

  create_resources('config::consul::server::acl', $acls)
}
