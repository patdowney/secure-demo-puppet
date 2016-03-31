# Class: cfssl::remote
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
class cfssl::remote(
  Hash $configs  = {},
  Hash $gencerts = {},
)
{
  include ::cfssl

  create_resources('cfssl::remote::config', $configs)
  create_resources('cfssl::remote::gencert', $gencerts)
}
