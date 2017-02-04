include java8

users::create {'qa':
  user => 'qa'
}

ssh::user {'qa_ssh':
  user => 'qa',
  require => Users::Create["qa"]
}


