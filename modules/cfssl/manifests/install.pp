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
class cfssl::install(
  String $release = 'R1.2'
)
{
  group {
    'cfssl':
      ensure => present,
  }

  user {
    'cfssl':
      gid     => 'cfssl',
      home    => '/var/lib/cfssl',
      shell   => '/bin/false',
      require => Group['cfssl']
  }

  file { $cfssl::config_root:
    ensure  => directory,
    owner   => 'root',
    group   => 'cfssl',
    mode    => '0775',
    require => Group['cfssl']
  }

  # install binaries
  # TODO: replace with a package
#  file {
#    'cfsslbins':
#      path    => '/usr/local/bin/',
#      ensure  => directory,
#      recurse => true,
#      owner   => 'root',
#      group   => 'cfssl',
#      mode    => '0755',
#      source  => "puppet:///modules/cfssl/${architecture}/",
#      require => Group['cfssl']
#  }


  cfssl::download {
    ['cfssl','multirootca','mkbundle', 'cfssljson', 'cfssl-scan',
  'cfssl-newkey', 'cfssl-certinfo', 'cfssl-bundle']:
      release => $release
  }

}
