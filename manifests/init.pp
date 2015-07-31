class docker ()
inherits docker::params
{

  class{'docker::install':
  }
  contain 'docker::install'

  class{'docker::config':
  }
  contain 'docker::config'

  class{'docker::service':
  }
  contain 'docker::service'

  class{'docker::compose':
  }
  contain 'docker::compose'

  Class['docker::install'] -> Class['docker::config'] -> Class['docker::service'] -> Class['docker::compose']

}

