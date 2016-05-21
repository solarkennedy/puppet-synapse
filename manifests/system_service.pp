# == Class synapse::service
#
# This class is meant to be called from synapse
# It ensure the service is running
#
class synapse::system_service {
  $synapse_working_dir = '/run/synapse'
  $user = $::synapse::user

  ::initscript { 'synapse':
    user           => $user,
    ulimit         => {
      'nofile' => '65535',
    },
    before_command => [
      ['mkdir', '-p', "${synapse_working_dir}/sockets", "${synapse_working_dir}/services"],
      ['chown', '-R', $user, "$synapse_working_dir"],
    ],
    command => ['/usr/bin/synapse', '--config', $::synapse::config_file],
  }

  file { $::synapse::log_file:
    ensure => file,
    owner  => $user,
    group  => $::synapse::group,
    mode   => '0640',
  }

}
