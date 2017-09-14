# Class: profile::ca
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
class profile::ca() {
  include ::cfssl
  include ::cfssl::multirootca
  include ::ca::bundle_host
}
