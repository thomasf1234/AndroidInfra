class android::haxm($memory) { 
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  
  exec { 'download_HAXM':
    command => 'yes | /usr/lib/android-sdk/tools/bin/sdkmanager "extras;intel;Hardware_Accelerated_Execution_Manager"'
  }
  #http://stackoverflow.com/questions/22216708/haxm-not-working-on-linux - need kvm
  exec { 'silent_install_HAXM':
    command => "/usr/lib/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager silent_install.sh -m ${memory}",
    unless => "/usr/lib/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager silent_install.sh -v",
    require => Exec['download_HAXM']
  }
}
