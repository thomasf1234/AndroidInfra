class git {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "apt_update_for_git":
    command => "apt-get update"
  }
  
  package {'git':
    ensure => installed,
    require => Exec['apt_update_for_git']
  }
}
