class role::ca() {
  include ::profile::base
  include ::profile::diagnostics
  include ::profile::ca
  #include ::profile::cfssl
  #include ::profile::multirootca
}
