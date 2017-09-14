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
class base::repos(
  $repos = {}
) {

  package {'epel-release': 
    ensure => latest
  }

  create_resources('yumrepo', $repos)
}
