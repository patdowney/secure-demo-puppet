class static_website_example(
  String $vhost = "www.example.com"
) {

  file {
    "/srv/www":
      ensure => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755'
  }

  file {
    "/srv/www/${vhost}":
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File["/srv/www"]
  }

  file {
    "/srv/www/${vhost}/index.html":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('static_website_example/www/index.html.erb'),
      require => File["/srv/www/${vhost}"]
  }

  nginx::resource::vhost { $vhost:
    www_root => "/srv/www/${vhost}",
    require => File["/srv/www/${vhost}"]
  }
}
