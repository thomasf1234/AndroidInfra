class java8 {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  file {'java-seeds':
    path => "/tmp/oracle-java-license.seeds",
    source => 'puppet:///modules/java8/oracle-java-license.seeds',
    ensure => 'present',
    require => Exec['apt-update']
  }

  package {'oracle-java8-installer':
    ensure => installed,
    responsefile => "/tmp/oracle-java-license.seeds",
    require => File['java-seeds']
  }

  exec { 'foo':
    environment => ["FOO=bar"],
    command => '/bin/echo $FOO > /tmp/bar'
    require =>
  }
}
