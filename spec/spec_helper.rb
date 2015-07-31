require 'puppetlabs_spec_helper/module_spec_helper'

Rspec.configure do |config|
  config.before(:each) do
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(:root? => true)
  end
end
