class base::daemontools() {
  case $::operatingsystem {
    debian: {
      $daemontools_service_name = 'daemontools'
    }
    ubuntu: {
      $daemontools_service_name = 'svscan'
    }
  }

  package { 'daemontools-run':
    ensure => latest;
  }

  file { '/service':
    ensure => directory;
  }

  file { '/etc/service':
    target => '/service',
    ensure => link,
    force  => true,
    notify => Service[$daemontools_service_name]
  }

  group { 'nobody':
    ensure => present; }


  service { $daemontools_service_name:
    ensure => running,
    enable => true;
  }
 
}
