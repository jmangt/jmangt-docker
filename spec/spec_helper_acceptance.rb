require 'minitest' # << add this because beaker 1.16 breaks if you don't
require 'beaker-rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Project root
proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

# Install our private rsa key, puppet and git to our test boxes
hosts.each do |host|
  unless ENV['BEAKER_provision']
    # Update distro repositories
    # on host, shell('apt-get update -y')

    # on host, shell('yum update -y')
    # on host, shell('yum clean all -y')

    # Install puppet and librarian puppet
    unless check_for_package host, 'puppet'
      on host, shell('rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm')
      on host, shell('yes | yum -y install puppet')
      install_librarian(host)
    end

    # Add Custom facts if needed
    # on host, shell('mkdir -p /etc/facter/facts.d')
    # on host, shell('echo MYFACT=-foo >> /etc/facter/facts.d/custom_facts.txt')

    # Install the puppet module
    if host['hypervisor'] != 'ec2' or ENV['BEAKER_scp']
      puppet_module_install(source: proj_root, module_name: 'docker')
    else
      on host, "mkdir -p #{host['distmoduledir']}"
      remote_url = `git ls-remote --get-url`
      current_branch = `git rev-parse --abbrev-ref HEAD`
      on host, "git clone  #{remote_url.chomp} #{host['distmoduledir']}/docker"
      on host, "cd #{host['distmoduledir']}/docker && git checkout #{current_branch}"
    end

    # Install the modules's depedencies
    on host, puppet('module', 'install', 'puppetlabs-stdlib')

  else
    on host, "rm -fr #{host['distmoduledir']}/docker"
    puppet_module_install(source: proj_root, module_name: 'docker')
  end

  on host, "cd #{host['distmoduledir']}/docker && rm Gemfile* && librarian-puppet install --verbose --path #{host['distmoduledir']}"
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  c.default_facts = {
    fqdn: 'test.example.com'
  }
end
