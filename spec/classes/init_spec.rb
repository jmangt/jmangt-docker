require 'spec_helper'
describe 'docker' do

  context 'with defaults for all parameters' do
    it { should contain_class('docker') }
    it { should compile.with_all_deps }
  end
end
