# -*- mode: ruby -*-

source "https://rubygems.org"

group :development, :test do
  gem "rake"
  gem "puppetlabs_spec_helper", :require => false
  gem "rspec-puppet", :git => "https://github.com/rodjek/rspec-puppet.git"
  gem "puppet-lint"
  gem "rspec", "<3.0.0"


  gem 'beaker-rspec', '~> 4.0.0'
  gem 'librarian-puppet'

  gem 'test-unit', '~> 3.0.1'
  gem 'minitest', '~> 5.4.0'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
