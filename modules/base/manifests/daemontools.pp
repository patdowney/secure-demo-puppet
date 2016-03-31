# Class: base::daemontools
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
class base::daemontools() {
  include ::daemontools

  case $::operatingsystem {
    debian: {
      $daemontools_service_name = 'daemontools'
    }
    ubuntu: {
      $daemontools_service_name = 'svscan'
    }
    default: {
      $daemontools_service_name = 'svscan'
    }
  }

  service { 'daemontools_service':
    ensure  => running,
    name    => $daemontools_service_name,
    enable  => true,
    require => Class['daemontools'];
  }
}
