class base() {
  package {'unzip':
    ensure => latest
  }

  include ::ca_cert
}
