class android {
  include android::tools

#	case $::operatingsystem {
#	  mac_osx: {
#	    class {'android::haxm':
#	      require => Class['android::tools'] 
#	      }
#	  }
#	  default: {
#	    fail("Module ${module_name} is not supported on ${::operatingsystem}")
#	  }
#	}
  
  class {'android::platform_tools':
    require => Class['android::tools']
  }
  
  class {'android::sdk24':
    require => Class['android::tools'] 
  }
  
  class {'android::build_tools':
    require => Class['android::tools'] 
  }
}
