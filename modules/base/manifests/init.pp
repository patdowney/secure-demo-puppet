# Class: base
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
class base() {
  package {'unzip':
    ensure => latest
  }

  include ::ca_cert
}
