class docker::service(
)
inherits docker::params
{
    
  service { 'docker':
    ensure   => running,
    enable   => true,
    provider => 'systemd'
  }
  
}
