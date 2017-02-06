define utils::install_package ($package, $source, $checksum, $checksum_type) {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "${package}-download_package":
    command => "wget --output-document=/tmp/${package}.deb ${source}",
    unless => "test -a /tmp/${package}.deb"
  }
  
  file { "${package}-checksum":
    path => "/tmp/${package}_verify.sha256",
    content => "${checksum} /tmp/${package}.deb",
    ensure => present
  }
  
  exec { "${package}-verify_checksum":
    command => "sha256sum -c /tmp/${package}_verify.sha256",
    require => [ Exec["${package}-download_package"], File["${package}-checksum"] ]
  }  
  
  exec { "install_${package}_package":
    command => "dpkg -i /tmp/${package}.deb",
    require => Exec["${package}-verify_checksum"]
  }
}
