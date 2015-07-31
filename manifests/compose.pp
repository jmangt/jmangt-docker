class docker::compose(
)
inherits docker::params
{

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:'
  }

  unless defined(Package['curl']) {
    package{'curl':
      ensure => installed
    }
  }
    
  exec{'download-compose':
    command => 'curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose',
    creates => '/usr/local/bin/docker-compose',
    require => Package['curl']
  }

  file{'/usr/bin/docker-compose':
    ensure  => link,
    target  => '/usr/local/bin/docker-compose',
    require => Exec['download-compose']
  }

}
