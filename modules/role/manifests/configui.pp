# Class: role::configui
# =====================
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
class role::configui() {
  include ::profile::base
  include ::profile::config_ui
}
