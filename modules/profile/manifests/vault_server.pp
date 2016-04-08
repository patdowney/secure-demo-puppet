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
class profile::vault_server() {
  include ::base
  include ::cfssl::remote
  include ::config::consul::agent
  include ::config::vault::server
}
