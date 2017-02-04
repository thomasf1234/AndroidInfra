class java8 {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  file {'license-seeds':
    path => "/tmp/oracle-java-license.seeds",
    source => 'puppet:///modules/java8/oracle-java-license.seeds',
    ensure => 'present',
    require => Exec['apt-update']
  }

  package {'oracle-java8-installer':
    ensure => installed,
    responsefile => "/tmp/oracle-java-license.seeds",
    require => File['license-seeds']
  }

  exec { 'update environment variables':
    command => '/bin/echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment',
    require => Package['oracle-java8-installer']
  }
}
