require 'rspec/core/shared_context'
require 'puppetlabs_spec_helper/module_spec_helper'

module GlobalHelper
  extend RSpec::Core::SharedContext

  def global_pre_condition
    [(File.read('spec/fixtures/manifests/site.pp') rescue ''),
     'Package { provider => "apt" }']
  end

  if ENV['FUTURE_PARSER'] == 'yes' or not Puppet.version =~ /^3/
    let(:pre_condition) { global_pre_condition }
  end
end

RSpec.configure do |c|
  c.include GlobalHelper
end
