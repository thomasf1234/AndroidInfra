define android::build_tools($version) { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { "install_build_tools-${version}":
    command => "yes | /usr/lib/android-sdk/tools/bin/sdkmanager \"build-tools;${version}\""
  }
}
