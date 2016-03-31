# Class: profile::config_server
# =============================
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
class profile::config_server() {
  include ::base
  include ::cfssl::remote
  include ::config::consul::server
}
