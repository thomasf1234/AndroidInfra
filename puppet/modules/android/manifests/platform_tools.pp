class android::platform_tools { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { 'install_platform_tools':
    command => 'yes | /usr/lib/android-sdk/tools/bin/sdkmanager "platform-tools"'
  }
}
