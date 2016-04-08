# Define: config::consul::server::acl
# https://www.consul.io/docs/internals/acl.html
#
define config::consul::server::acl(
  $rules = undef,
  $id = undef,
  $type = 'client',
  $ensure = 'present',
) {

  $acl_file = "/etc/consul/acl.d/${title}"

  file { $acl_file:
    owner   => 'consul',
    mode    => '0600',
    content => template('config/consul_acl.json.erb'),
    require => [File['/etc/consul/acl.d'], User['consul']]
  }

  exec { "put-${title}-acl":
    # sleep 1s is to give consul time to bind to the https_port
    command => "/bin/sleep 1; curl --cacert ${::config::consul::server::ca_file} --cert ${::config::consul::server::cert_file} --key ${::config::consul::server::key_file} --header \"X-Consul-Token: ${::consul_acl_master_token}\" --request PUT --data @${acl_file} https://127.0.0.1:${::config::consul::server::https_port}/v1/acl/create",
    user    => 'consul',
    path    => '/usr/bin',
    require => File[$acl_file]
  }
}
