define cfssl::remote::config(
  String $owner = 'cfssl',
  Hash   $config
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
