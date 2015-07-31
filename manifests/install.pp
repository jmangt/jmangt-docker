class docker::install(
)
inherits docker::params
{
  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  }

  package{'epel-release':
    ensure   => latest,
    provider => 'yum'
  }

  package {'device-mapper-event-libs':
    ensure   => latest,
    provider => 'yum',
    require  => Package['epel-release']
  }

  exec{'curl -sSL https://get.docker.com/ | sh':
    unless  => 'which docker',
    require => [Package['epel-release'],
              Package['device-mapper-event-libs']]
  }

}
