# Class: role::consul
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
class role::consul() {
  include ::profile::base
  include ::profile::config_server
}
