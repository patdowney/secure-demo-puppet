# Class: role::config_ui
# ======================
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
class role::config_ui() {
  include ::profile::base
  include ::profile::config_ui
}
