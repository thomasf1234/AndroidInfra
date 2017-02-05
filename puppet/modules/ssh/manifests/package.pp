class ssh::package {
  exec { "apt_update_for_ssh_package":
    command => "/usr/bin/apt-get update"
  }
  
  package {'openssh-server':
    ensure => installed,
    require => Exec['apt_update_for_ssh_package']
  }
}
