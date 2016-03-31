class profile::config_ui() {
  include ::base
  include ::cfssl::remote
  include ::config::ui
  include ::config::consul::ui
}
