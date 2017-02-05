define ssh::user ($username) {
  file { ".ssh":
    path => "/home/${username}/.ssh",
    ensure => directory,
    owner  => "${username}",
    group  => "${username}",
    mode => '700'
  }
  
  file { "authorized_keys":
    path => "/home/${username}/.ssh/authorized_keys",
    ensure => file,
    source => 'puppet:///modules/ssh/id_rsa_virtual_box.pub',
    owner  => "${username}",
    group  => "${username}",
    require => File[".ssh"]
  }
}
