class git {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  package {'git':
    ensure => installed,
    require => Exec['apt-update']
  }
}
