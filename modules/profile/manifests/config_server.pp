class profile::config_server() {
  include ::base
  include ::cfssl::remote
  include ::config::consul::server
}
