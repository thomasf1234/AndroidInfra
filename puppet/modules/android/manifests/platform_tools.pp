class android::platform_tools { 
  Exec { 
    environment => ["ANDROID_SDK_HOME=/usr/lib/android-sdk"],
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] 
  }
  
  exec { 'install_platform_tools':
    command => 'yes | /usr/lib/android-sdk/tools/bin/sdkmanager "platform-tools"'
  }

  exec { 'add_platform_tools_path_to_PATH':
    command => 'echo "PATH=$PATH;$ANDROID_SDK_HOME/platform-tools" >> /etc/environment',
    unless => 'grep PATH=$PATH;$ANDROID_SDK_HOME/platform-tools /etc/environment 2>/dev/null',
    require => Exec['install_platform_tools']
  }
}
