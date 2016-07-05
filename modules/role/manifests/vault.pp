# Class: role::vault
# ==================
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
class role::vault() {
  include ::profile::base
  include ::profile::vault_server
}
