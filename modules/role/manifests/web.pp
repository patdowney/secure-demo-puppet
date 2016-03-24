class role::web() {
  include ::profile::base
  include ::profile::nginx
  include ::profile::static_website_example
}
