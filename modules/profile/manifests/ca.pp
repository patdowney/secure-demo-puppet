class profile::ca() {
  include ::base::daemontools
  include ::cfssl
  include ::cfssl::multirootca
  include ::ca::bundle_host
}
