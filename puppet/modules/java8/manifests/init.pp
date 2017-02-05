class java8 {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "apt_update_for_java8":
    command => "apt-get update"
  }

  file {'license-seeds':
    path => "/tmp/oracle-java-license.seeds",
    source => 'puppet:///modules/java8/oracle-java-license.seeds',
    ensure => present,
    require => Exec['apt_update_for_java8']
  }

  package {'oracle-java8-installer':
    ensure => installed,
    responsefile => "/tmp/oracle-java-license.seeds",
    require => File['license-seeds']
  }

  exec { 'update environment variables':
    command => 'echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment',
    unless => 'grep JAVA_HOME /etc/environment 2>/dev/null',
    require => Package['oracle-java8-installer']
  }
}
