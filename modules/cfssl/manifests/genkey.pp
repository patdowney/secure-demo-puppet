# Define: cfssl::genkey
# =====================
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
define cfssl::genkey(
  $initca, # Boolean
  $csr, # Hash
  $caname = $title, # String
)
{

  file {
    "/etc/cfssl/${caname}":
      ensure  => directory,
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0750',
      require => [File['/etc/cfssl'], User['cfssl']],
  }

  file {
    "/etc/cfssl/${caname}/${caname}-csr.json":
      content => template('cfssl/csr.json.erb'),
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0440',
      require => File["/etc/cfssl/${caname}"],
  }

  exec { "genkey-${caname}":
    command => "cfssl genkey -initca ${caname}-csr.json | cfssljson -bare ${caname}",
    path    => '/usr/local/bin',
    cwd     => "/etc/cfssl/${caname}",
    user    => 'cfssl',
    creates => "/etc/cfssl/${caname}/${caname}.pem",
    require => [ File["/etc/cfssl/${caname}"], File['/usr/local/bin/cfssl'] ]
  }

  file {
    "/etc/cfssl/${caname}/${caname}.pem":
      require => Exec["genkey-${caname}"];
    "/etc/cfssl/${caname}/${caname}-key.pem":
      require => Exec["genkey-${caname}"];
  }
}
