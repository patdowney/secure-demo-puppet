class role::standalone() {
  include ::profile::base
  include ::profile::diagnostics
  include ::profile::nginx
  include ::profile::static_website_example
  include ::profile::java_service
}
