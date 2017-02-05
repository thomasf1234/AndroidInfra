include git
include java8
include ssh::package

users::user {'qa_user':
  username => 'qa'
}

ssh::user {'qa_user_ssh':
  username => 'qa',
  require => [ Users::User["qa_user"], Class['ssh::package'] ]
}


