# Define: cfssl::download
# =======================
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
define cfssl::download(
  String $release,
  String $binary = $title,
  String $platform = 'linux',
  String $base_url = 'https://pkg.cfssl.org',
  String $prefix = '/usr/local/bin'
) {

  $release_target = "${prefix}/${binary}-${release}"

  exec {
    "wget_${release}_${binary}":
      command => "/usr/bin/wget --output-document=${release_target} ${base_url}/${release}/${binary}_${platform}-${::architecture}",
      creates => $release_target
  }

  file { $release_target:
    ensure => present,
    mode   => '0755'
  }

  file { "${prefix}/${binary}":
    ensure  => link,
    target  => $release_target,
    force   => true,
    require => File[$release_target]
  }
}
