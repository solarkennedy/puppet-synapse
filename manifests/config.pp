# == Class synapse::config
#
# This class is called from synapse
#
class synapse::config (
  $haproxy_daemon,
  $haproxy_reload_command
) {

  # TODO: something?
  # In the case were we are using the default location
  if $::synapse::config_file == $::synapse::params::config_file {
    # Make the parent directory
    file { '/etc/synapse/':
      ensure => 'directory',
    }
  }

  file { $::synapse::config_file:
    ensure  => 'present',
    owner   => 'root',
    mode    => 0444,
    content => template('synapse/synapse.conf.json.erb'),
  }

  file { $::synapse::config_dir:
    ensure       => 'directory',
    recurse      => true,
    recurselimit => '1',
    purge        => $synapse::purge_config,
  }


}
