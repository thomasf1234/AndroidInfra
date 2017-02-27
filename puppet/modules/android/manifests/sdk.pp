define android::sdk($version) { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "install_android_sdk_version-${version}":
    command => "yes | /usr/lib/android-sdk/tools/bin/sdkmanager \"platforms;android-${version}\""
  }
}
