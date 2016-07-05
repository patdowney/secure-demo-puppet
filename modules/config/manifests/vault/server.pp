# Class ::config::vault::server
class config::vault::server(
  String $tls_cert_file,
  String $tls_key_file,
  String $consul_cert_file,
  String $consul_key_file,
  String $consul_ca_file,
  String $consul_token,
  String $listener_addr
) {
  class { '::vault':
    config_hash => {
      'backend'  => {
        'consul' => {
          'scheme'        => 'https',
          'address'       => '127.0.0.1:8501',
          'path'          => 'vault',
          'tls_cert_file' => $consul_cert_file,
          'tls_key_file'  => $consul_key_file,
          'tls_ca_file'   => $consul_ca_file,
          'token'         => $consul_token,
        }
      },
      'listener' => {
        'tcp' => {
          'address'       => $listener_addr,
          'tls_cert_file' => $tls_cert_file,
          'tls_key_file'  => $tls_key_file
        }
      }
    }
  }

  Exec['gencert-vaultconsul'] ~> Service['vault']
}
