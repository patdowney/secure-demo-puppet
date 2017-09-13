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
  $repos = []
) {

  create_resources('yumrepos', $repos)
}
