class android {
  include android::tools

  class {'android::platform_tools':
    require => Class['android::tools']
  }
  
  class {'android::sdk24':
    require => Class['android::tools'] 
  }
}
