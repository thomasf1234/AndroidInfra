class android::build_tools { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { 'install_build_tools':
    command => 'yes | /usr/lib/android-sdk/tools/bin/sdkmanager "build-tools;25.0.2"'
  }
}
