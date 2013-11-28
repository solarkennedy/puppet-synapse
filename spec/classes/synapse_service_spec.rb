require 'spec_helper'
describe 'synapse::service', :type => :define do

  describe 'With an example service' do
    let :title do
      'example_service'
    end
    let (:params) {{ 
      :port           => '9000',
      :host           => '4.2.2.2',
      :zk_hosts       => ["zk1:2181"],
      :zk_path        => "/synapse/services/my_webapp_bla",
      :check_interval => '99',
      :checks         => [
                           {
                             'type' => 'http',
                             'uri'  => '/health',
                             'timeout' => '0.2',
                             'rise'    => '3',
                             'fall'    => '2'
                           }
                         ]
    }}
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with(
      :ensure => 'present',
      :mode   => '0444',
    ) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"port": 9000/) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"host": "4\.2\.2\.2",/) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"zk_hosts": \["zk1:2181"\],/) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"zk_path": "\/synapse\/services\/my_webapp_bla",/) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"check_interval": 99,/) }
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/"checks": \[\n  {\n    "type": "http",\n    "uri": "\/health",\n    "timeout": "0.2",\n    "rise": "3",\n    "fall": "2"\n  }\n\]\n}/) }
  end # end example service

  describe 'When not specifying a port' do
    let (:params) {{ }}
    it { expect { should }.to raise_error(NameError) }
  end 

end # end describe
