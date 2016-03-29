require 'spec_helper'
describe 'cfssl' do

  context 'with defaults for all parameters' do
    it { should contain_class('cfssl') }
  end
end
