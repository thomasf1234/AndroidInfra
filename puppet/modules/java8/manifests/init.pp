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
    environment => ["JAVA_HOME=/usr/lib/jvm/java-8-oracle"],
    command => '/bin/echo $FOO > /tmp/bar',
    require => Package['oracle-java8-installer']
  }
}
