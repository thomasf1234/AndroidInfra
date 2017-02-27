class android::hardware_acceleration { 
  Exec { 
    environment => ["ANDROID_SDK_HOME=/usr/lib/android-sdk"],
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] 
  }
  
  package { 'mesa-utils':
    ensure => installed
  }
  
  package { 'lib64stdc++6:i386':
    ensure => installed
  }
  
  exec {'backup_android_libstdc++':
    command => 'mv $ANDROID_SDK_HOME/tools/lib64/libstdc++/libstdc++.so.6 $ANDROID_SDK_HOME/tools/lib64/libstdc++/libstdc++.so.6.bak',
    require => Package['lib64stdc++6:i386']
  }

  exec { 'symlink-libstdc++':
    command => 'ln -s /usr/lib64/libstdc++.so.6 $ANDROID_SDK_HOME/tools/lib64/libstdc++/libstdc++',
    require => Exec['backup_android_libstdc++']
  }
}
