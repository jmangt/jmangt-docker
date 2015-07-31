require 'spec_helper_acceptance'

describe 'docker class' do
  # Is this something SO specific
  # maybe a package name

  # case fact('osfamily')
  # when 'Debian' || 'Ubuntu'
  #   package_name = 'git-core'
  # end

  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'docker': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('docker') do
      it { should be_running }
    end

    describe file('/usr/local/bin/docker-compose') do
      it { should be_executable }
    end

    describe command('/usr/bin/docker -v') do
      its(:stdout) { should match /1.7/ }
    end

    # check if the package was installed
    # describe package(package_name) do
    #   it { should be_installed }
    # end
  end
end
