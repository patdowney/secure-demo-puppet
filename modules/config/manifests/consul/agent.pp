# Class: config::consul::agent
# ============================
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
class config::consul::agent(
  String  $datacenter,
  String  $encrypt_key,
  String  $cert_file,
  String  $key_file,
  String  $ca_file,
  Array   $retry_join,
  String  $client_addr,
  String  $advertise_addr,
  String  $acl_token,
  String  $acl_datacenter,
  String  $version          = '0.6.4',
  String  $log_level        = 'INFO',
  Integer $https_port       = 8501,
  Boolean $enable_ui        = false,
  Boolean $verify_incoming  = false,
  Boolean $verify_server_hostname = false
) {

  if $enable_ui {
    $ui_dir = '/opt/consul/ui'
  } else {
    $ui_dir = undef
  }

  #class { '::consul::client':
  #  enable_ui => true,
  #}

  class { '::consul':
    version     => $version,
    config_hash => {
      'data_dir'               => '/opt/consul',
      'enable_syslog'          => true,
      'server'                 => false,
      'node_name'              => $::hostname,
      'ui_dir'                 => $ui_dir,
      'datacenter'             => $datacenter,
      'log_level'              => $log_level,
      'encrypt'                => $encrypt_key,
      'retry_join'             => $retry_join,
      'cert_file'              => $cert_file,
      'key_file'               => $key_file,
      'ca_file'                => $ca_file,
      'client_addr'            => $client_addr,
      'advertise_addr'         => $advertise_addr,
      'ports'                  => {
        'http'  => -1,
        'https' => $https_port
      },
      'verify_incoming'        => $verify_incoming,
      'verify_outgoing'        => true,
      'verify_server_hostname' => $verify_server_hostname,
      'acl_token'              => $acl_token,
      'acl_datacenter'         => $acl_datacenter,
    }
  }
}
