class ssh::package {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  
  package {'openssh-server':
    ensure => installed,
    require => Exec['apt-update']
  }
}
