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

  package {'bind-utils':
    ensure => latest
  }

  package {'fail2ban':
    ensure => latest
  }

  package {'unzip':
    ensure => latest
  }

  package {'wget':
    ensure => latest
  }

  include ::base::repos

  include ::ca_cert

  include ::base::yum_cron
}
