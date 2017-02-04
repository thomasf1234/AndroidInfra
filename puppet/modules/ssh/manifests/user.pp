define ssh::user ($user) {
  file { ".ssh":
    path => "/home/${user}/.ssh",
    ensure => directory,
    owner  => "${user}",
    group  => "${user}",
    mode => '700'
  }
  
  file { "authorized_keys":
    path => "/home/${user}/.ssh/authorized_keys",
    ensure => file,
    owner  => "${user}",
    group  => "${user}",
    require => File[".ssh"]
  }
}
