require 'spec_helper'
describe 'synapse::service', :type => :define do
  let(:facts) {{ :osfamily => 'Debian' }}
  let(:pre_condition) do
    global_pre_condition +
    [
      "class { 'synapse': }",
    ]
  end

  describe 'With an example service' do
    let :title do
      'example_service'
    end
    let (:params) {{ 
      :default_servers => [
        {
          "name" => "default1",
          "host" => "localhost",
          "port" => 8422
        }
      ],
      :discovery => {
        "method" => "zookeeper",
        "path"   => "/airbnb/service/service2",
        "hosts"  =>  [
          "zk0.airbnb.com:2181",
          "zk1.airbnb.com:2181"
        ]
      },
      :haproxy => {
        "port"           => '3214',
        "server_options" => "check inter 2s rise 3 fall 2",
        "listen"         => [
          "mode http",
          "option httpchk /health",
        ]
      },
    }}
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with(
      :ensure => 'present',
      :mode   => '0444',
    ) }

    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/\"default_servers\":/) }

    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/\"discovery\": \{\n  \"method\": \"zookeeper\",\n  \"path\": \"\/airbnb\/service\/service2\",\n  \"hosts\": \[\n    \"zk0\.airbnb\.com:2181\",/) }

    it { should contain_file('/etc/synapse/conf.d/example_service.json').with_content(/\"haproxy\": \{\n  \"port\": \"3214\",\n  \"server_options\": \"check inter 2s rise 3 fall 2\",\n  \"listen\": \[\n    \"mode http\",\n    \"option httpchk \/health\"\n  \]\n\}\n\}/ ) }
  end # end example service

  describe 'When asking to ensure absent' do
    let :title do
      'example_service'
    end
    let (:params) {{
      :ensure          => 'absent',
      :default_servers => [],
      :discovery       => {},
      :haproxy         => {}
    }}
    it { should contain_file('/etc/synapse/conf.d/example_service.json').with(
      :ensure => 'absent'
    ) }
  end 

end # end describe
