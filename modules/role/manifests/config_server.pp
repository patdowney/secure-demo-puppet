# Class: role::config_server
# ==========================
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
class role::config_server() {
  include ::profile::base
  include ::profile::config_server
}
