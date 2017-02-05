class git {
  exec { "apt_update_for_git":
    command => "/usr/bin/apt-get update"
  }
  
  package {'git':
    ensure => installed,
    require => Exec['apt_update_for_git']
  }
}
