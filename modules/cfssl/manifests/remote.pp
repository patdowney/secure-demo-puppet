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
  $configs  = {}, # Hash
  $gencerts = {}, # Hash
)
{
  include ::cfssl

  create_resources('cfssl::remote::config', $configs)
  create_resources('cfssl::remote::gencert', $gencerts)
}
