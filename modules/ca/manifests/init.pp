# Class: ca
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
class ca() {
  include ::cfssl
  include ::cfssl::multirootca
  include ::nginx
}
