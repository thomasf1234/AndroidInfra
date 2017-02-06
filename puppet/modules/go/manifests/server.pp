class go::server {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  utils::install_package {'install_go_server_package':
    package => 'go_server',
    source => 'https://download.gocd.io/binaries/17.1.0-4511/deb/go-server_17.1.0-4511_all.deb',
    checksum => '7a876da0e26501818ebab8986b17167b94ff2470e5eea57edaf52c111b33b165',
    checksum_type => 'sha256'
#    unless => "dpkg --get-selections | grep -v deinstall | grep go-server"
  }

  service { 'go-server':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Exec['install_go_server_package']
  }
}
