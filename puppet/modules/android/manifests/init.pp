class android {
  include android::tools

	case $::operatingsystem {
	  mac_osx: {
	    class {'android::haxm':
	      require => Class['android::tools'] 
	      }
	  }
	  /^(Debian|Ubuntu)$/: {
	    class {'android::hardware_acceleration':
	     
	    }
	  }
	  default: {
	    fail("Module ${module_name} is not supported on ${::operatingsystem}")
	  }
	}
  
  class {'android::platform_tools':
    require => Class['android::tools']
  }
  
  android::sdk {'android::sdk':
    version => '24',
    require => Class['android::tools'] 
  }
  
  android::build_tools {'android::build_tools':
    version => '25.0.2',
    require => Class['android::tools']  
  }
}
