define ruby::gem {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "install_${name}":
    command => "gem install --no-user-install ${name}"
  }
}
