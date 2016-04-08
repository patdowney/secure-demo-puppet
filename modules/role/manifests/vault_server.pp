# Class: role::vault_server
# ===========================
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
class role::vault_server() {
  include ::profile::base
  include ::profile::vault_server
}
