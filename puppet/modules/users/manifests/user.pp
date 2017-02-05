define users::user ($username) {
  user { "${username}":
    ensure  => present,
    groups  => ['sudo'],
    home    => "/home/${username}",
    shell   => '/bin/bash'
  }
  
  file { "home":
    path => "/home/${username}",
    ensure => directory,
    owner  => "${username}",
    group  => "${username}",
    mode => '700',
    require => User["${username}"]
  }
}
