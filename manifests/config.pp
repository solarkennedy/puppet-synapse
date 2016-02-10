# == Class synapse::config
#
# This class is called from synapse
#
class synapse::config (
  $haproxy_daemon,
  $haproxy_reload_command,
  $haproxy_bind_address,
  $haproxy_config_path,
  $extra_config,
) {

  # TODO: something?
  # In the case were we are using the default location
  if $::synapse::config_file == $::synapse::params::config_file {
    # Make the parent directory
    file { '/etc/synapse/':
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      recurse => true,
      purge   => $::synapse::purge_config,
      force   => true,
    }
  }

  if $haproxy_daemon {
    $daemon_config = ['daemon']
  } else {
    $daemon_config = []
  }

  $global_config = concat(
    $daemon_config,
    [
      "user ${::synapse::user}",
      "group ${::synapse::group}",
      'maxconn 4096',
      "stats socket ${::synapse::stats_socket} mode 666 level admin",
    ],
    $::synapse::haproxy_global_log
  )

  $config = deep_merge({
    service_conf_dir   => $::synapse::config_dir,
    haproxy            => {
      bind_address     => $haproxy_bind_address,
      reload_command   => $haproxy_reload_command,
      config_file_path => $haproxy_config_path,
      socket_file_path => $::synapse::stats_socket,
      do_writes        => true,
      do_reloads       => true,
      do_socket        => true,
      global           => $global_config,
      defaults         => $::synapse::haproxy_defaults,
      extra_sections   => $::synapse::haproxy_extra_sections,
    }
  }, $extra_config)

  file { $::synapse::config_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('synapse/synapse.conf.json.erb'),
  }

  file { $::synapse::config_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    recurse => true,
    purge   => $::synapse::purge_config,
    force   => true,
  }
}
