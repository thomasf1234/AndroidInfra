define users::create ($user) {
  user { "${user}":
    ensure  => present,
    groups  => ['sudo'],
    home    => "/home/${user}",
    shell   => '/bin/bash'
  }
  
  file { "home":
    path => "/home/${user}",
    ensure => directory,
    owner  => "${user}",
    group  => "${user}",
    mode => '700',
    require => User["${user}"]
  }
}
