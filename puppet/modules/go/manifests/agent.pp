class go::agent {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  utils::install_package {'install_go_agent_package':
    package => 'go_agent',
    source => 'https://download.gocd.io/binaries/17.1.0-4511/deb/go-agent_17.1.0-4511_all.deb',
    checksum => '10da0c9bcb6622033020c390969ff53000029e79de4e4f944e68150ab6e43228',
    checksum_type => 'sha256'
  }

  service { 'go-agent':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Exec['install_go_agent_package']
  }
}
