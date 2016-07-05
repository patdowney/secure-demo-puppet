# Class: cfssl::remote::config
# ============================
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
define cfssl::remote::config(
  $config, # Hash
  $owner = 'cfssl', # String
) {
  file {
    "${::cfssl::config_root}/${title}-config.json":
      owner   => $owner,
      group   => 'cfssl',
      mode    => '0440',
      content => template('cfssl/config.json.erb'),
      require => Class['cfssl::install']
  }
}
