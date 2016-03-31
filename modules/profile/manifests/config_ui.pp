# Class: profile::config_ui
# =========================
#
# Parameters
# ----------
#
# Variables
# --------
#
# Examples
# --------
#
# Authors
# -------
#
# Copyright
# ---------
#
class profile::config_ui() {
  include ::base
  include ::cfssl::remote
  include ::config::ui
  include ::config::consul::agent
}
