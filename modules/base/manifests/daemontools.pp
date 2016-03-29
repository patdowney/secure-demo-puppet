class base::daemontools() {
  include ::daemontools

  case $::operatingsystem {
    debian: {
      $daemontools_service_name = 'daemontools'
    }
    ubuntu: {
      $daemontools_service_name = 'svscan'
    }
  }

  service { 'daemontools_service':
    name    => $daemontools_service_name,
    ensure  => running,
    enable  => true,
    require => Class['daemontools'];
  }
 
}
