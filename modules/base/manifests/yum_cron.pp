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
class base::yum_cron(
  $update_cmd    = 'security',
  $apply_updates = 'yes',
)
{
  package {'yum-cron':
    ensure => latest
  }

  file { '/etc/yum/yum-cron.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => "update_cmd = ${update_cmd}\napply_updates = ${apply_updates}"
  }

  service { 'yum-cron':
    ensure  => running,
    enabled => true,
    require => Package['yum-cron'],
  }
}
