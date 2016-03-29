define cfssl::genkey(
  String $caname = $title,
  Boolean $initca,
  Hash $csr,
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
}
