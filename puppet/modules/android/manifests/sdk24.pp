class android::sdk24 { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { 'install_android_sdk_24':
    command => 'yes | /usr/lib/android-sdk/tools/bin/sdkmanager "platforms;android-24"'
  }
}
