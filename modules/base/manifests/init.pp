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
  Yumrepo <| |> -> Package <| provider != 'rpm' |>

  package {'unzip':
    ensure => latest
  }

  include ::base::repos

  include ::ca_cert
}
