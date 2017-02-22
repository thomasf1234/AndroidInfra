class ruby {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "apt_update_for_ruby":
    command => "apt-get update"
  }
  
  package {'ruby-full':
    ensure => installed,
    require => Exec['apt_update_for_ruby']
  }
  
  ruby::gem {'bundler':
    require => Package['ruby-full']
  }
}
