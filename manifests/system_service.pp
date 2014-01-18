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
  } ~>
  service { 'synapse':
    ensure     => $synapse::service_ensure,
    enable     => str2bool($synapse::service_enable),
    hasstatus  => true,
    hasrestart => true,
  }

}
