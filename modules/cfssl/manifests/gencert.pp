# Define: cfssl::gencert
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
define cfssl::gencert(
  String $profile,
  String $ca,
  Hash $csr,
  String $caname = $title,
  Boolean $initca = false,
  Boolean $configure_multirootca = false,
  Boolean $generate_bundle = false
)
{

  $certificate_root     = "${cfssl::config_root}/${caname}"
  $certificate_csr_path = "${certificate_root}/${caname}-csr.json"
  $certificate_path     = "${certificate_root}/${caname}.pem"
  $certificate_key_path = "${certificate_root}/${caname}-key.pem"

  $ca_root             = "${cfssl::config_root}/${ca}"
  $ca_certificate_path = "${ca_root}/${ca}.pem"
  $ca_key_path         = "${ca_root}/${ca}-key.pem"

  $config_path = "${cfssl::config_root}/config.json"
  $multirootca_config_path = "${cfssl::config_root}/multirootca-config.json"

  $private_key_proto = 'file'

  file {
    $certificate_root:
      ensure  => directory,
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0755',
      require => [File[$cfssl::config_root], User['cfssl']]
  }

  file {
    $certificate_csr_path:
      content => template('cfssl/csr.json.erb'),
      owner   => 'cfssl',
      group   => 'cfssl',
      mode    => '0644',
      require => File[$certificate_root]
  }

  exec { "gencert-${caname}":
    command => "cfssl gencert -config=\"${config_path}\" -profile=\"${profile}\" -ca=\"${ca_certificate_path}\" -ca-key=\"${ca_key_path}\" ${certificate_csr_path} | cfssljson -bare ${caname}",
    path    => '/usr/local/bin',
    cwd     => $certificate_root,
    user    => 'cfssl',
    creates => $certificate_path,
    require => [ File[$certificate_root], File['/usr/local/bin/cfssl'] ]
  }

  if $configure_multirootca {
    concat::fragment {
      "${caname}_multirootca_fragment":
        target  => $cfssl::multirootca_ini,
        content => template('cfssl/multirootca_fragment.ini.erb')
    }
  }

  if $generate_bundle {
    exec { "mkbundle-${caname}":
      command => "mkbundle -f ${cfssl::config_root}/bundles/${caname}-bundle.crt ${ca_certificate_path} ${certificate_path}",
      path    => '/usr/local/bin',
      cwd     => $certificate_root,
      user    => 'cfssl',
      creates => "${cfssl::config_root}/bundles/${caname}-bundle.crt",
      require => [ File['/usr/local/bin/mkbundle'] ]
    }
  }
}
