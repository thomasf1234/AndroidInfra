class android::tools {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  file { "android_sdk_dir":
    path => "/usr/lib/android-sdk",
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode => '755'
  }
  
  exec { 'download_sdk_tools':
    command => 'curl https://dl.google.com/android/repository/tools_r25.2.3-linux.zip > /tmp/tools_r25.2.3-linux.zip',
    unless => "test -a /tmp/tools_r25.2.3-linux.zip"
  }
  
  exec { 'unzip_sdk_tools':
    command => 'unzip -o -d /usr/lib/android-sdk /tmp/tools_r25.2.3-linux.zip',
    require => [ File['android_sdk_dir'], Exec['download_sdk_tools'] ]
  }
  
  exec { 'add_ANDROID_SDK_HOME_to_environment_variables':
    command => 'echo "ANDROID_SDK_HOME=/usr/lib/android-sdk" >> /etc/environment',
    unless => 'grep ANDROID_SDK_HOME /etc/environment 2>/dev/null',
    require => Exec['unzip_sdk_tools']
  }
}
