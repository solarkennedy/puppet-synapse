require 'spec_helper'

describe 'synapse' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "synapse class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('synapse::params') }

        it { should contain_class('synapse::install') }
        it { should contain_class('synapse::config') }
        it { should contain_class('synapse::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'synapse class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
