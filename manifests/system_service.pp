# == Class synapse::service
#
# This class is meant to be called from synapse
# It ensure the service is running
#
class synapse::system_service {

  # TODO: This assumes upstart. Be more compatible someday

  $config_file = $synapse::config_file
  file { '/etc/init/synapse.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 0444,
    content => template('synapse/synapse.conf.upstart.erb'),
  }

  if $osfamily == 'RedHat' and $operatingsystemmajrelease == 6 {
    service { 'synapse':
      ensure     => $synapse::service_ensure,
      enable     => false,
      hasstatus  => true,
      start      => '/sbin/initctl start synapse',
      stop       => '/sbin/initctl stop synapse',
      status     => '/sbin/initctl status synapse | grep "/running" 1>/dev/null 2>&1',
      subscribe  => File['/etc/init/synapse.conf'],
    }
  } else {
    service { 'synapse':
      ensure     => $synapse::service_ensure,
      enable     => str2bool($synapse::service_enable),
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['/etc/init/synapse.conf'],
    }
  }

}
