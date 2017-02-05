class ssh::package {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "apt_update_for_ssh_package":
    command => "apt-get update"
  }
  
  package {'openssh-server':
    ensure => installed,
    require => Exec['apt_update_for_ssh_package']
  }
}
