# Class: cfssl
# ===========================
#
# Full description of class cfssl here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'cfssl':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class cfssl(
  $config = {}, # Hash
  $genkeys = {}, # Hash
  $gencerts = {}, # Hash
  $multirootca_ini = '/etc/cfssl/multirootca.ini', # String
  $config_root = '/etc/cfssl' # String
)
{
  include cfssl::install

  file {
    "${config_root}/config.json":
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0440',
      content => template('cfssl/config.json.erb'),
      require => Class['cfssl::install']
  }

  create_resources('cfssl::genkey', $genkeys)
  create_resources('cfssl::gencert', $gencerts)


  concat { $multirootca_ini:
    ensure => present,
  }

  file {
    "${config_root}/bundles":
      ensure  => directory,
      owner   => 'cfssl',
      group   => 'cfssl',
      require => File[$config_root]
  }
}
