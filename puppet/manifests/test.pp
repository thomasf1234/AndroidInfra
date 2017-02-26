include git
include java8
include ssh::package
include ruby
#include android
include android::tools
include go::server
include go::agent

users::user {'qa_user':
  username => 'qa'
}

ssh::user {'allow_qa_user_ssh':
  username => 'qa',
  require => [ Users::User["qa_user"], Class['ssh::package'] ]
}


