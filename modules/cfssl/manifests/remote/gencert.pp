# Class: cfssl::remote::gencert
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
define cfssl::remote::gencert(
  $config, # String
  $label, # String
  $profile, # String
  $csr, # Hash
  $caname = $title, # String
  $owner = 'cfssl', # String
)
{

  $certificate_root     = "${cfssl::config_root}/${caname}"
  $certificate_csr_path = "${certificate_root}/${caname}-csr.json"
  $certificate_path     = "${certificate_root}/${caname}.pem"
  $certificate_key_path = "${certificate_root}/${caname}-key.pem"

  $config_path = "${cfssl::config_root}/${config}-config.json"

  $private_key_proto = 'file'

  file {
    $certificate_root:
      ensure  => directory,
      owner   => $owner,
      group   => 'cfssl',
      mode    => '0755',
      require => [File[$cfssl::config_root], User[$owner]]
  }

  file {
    $certificate_csr_path:
      content => template('cfssl/csr.json.erb'),
      owner   => $owner,
      group   => 'cfssl',
      mode    => '0644',
      require => File[$certificate_root],
      notify  => Exec["gencert-${caname}"]
  }

  exec { "gencert-${caname}":
    command => "cfssl gencert -config=\"${config_path}\" -profile=\"${profile}\" -label=\"${label}\" ${certificate_csr_path} | cfssljson -bare ${caname}",
    path    => '/usr/local/bin',
    cwd     => $certificate_root,
    user    => $owner,
    creates => $certificate_path,
    require => [ File[$certificate_root], File['/usr/local/bin/cfssl'], File[$certificate_csr_path], File[$config_path], Exec[ca_cert_update] ]
  }

}
