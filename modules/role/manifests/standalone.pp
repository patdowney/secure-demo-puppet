class role::standalone() {
  include ::profile::base
  include ::profile::diagnostics
  include ::profile::nginx
  include ::profile::java
}
