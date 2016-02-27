# == Class: synapse
#
# Full description of class synapse here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class synapse (
  $package_ensure   = $synapse::params::package_ensure,
  $package_provider = $synapse::params::package_provider,
  $package_name     = $synapse::params::package_name,
  $service_manage   = $synapse::params::service_manage,
  $service_ensure   = $synapse::params::service_ensure,
  $service_enable   = $synapse::params::service_enable,
  $config_file      = $synapse::params::config_file,
  $config_dir       = $synapse::params::config_dir,
  $purge_config     = $synapse::params::purge_config,
  $log_file         = $synapse::params::log_file,
  $haproxy_ensure   = $synapse::params::haproxy_ensure,
  $user             = $synapse::params::user,
  $group                   = $synapse::params::group,
  $stats_socket            = $synapse::params::stats_socket,
  $haproxy_daemon          = true,
  $haproxy_reload_command  = $synapse::params::haproxy_reload_command,
  $haproxy_bind_address    = '127.0.0.1',
  $haproxy_config_path     = $synapse::params::haproxy_config_path,
  $working_dir             = '/var/run/synapse',
  $haproxy_defaults        = [
    'log      global',
    'option   dontlognull',
    'maxconn  2000',
    'retries  3',
    'timeout  connect 5s',
    'timeout  client  1m',
    'timeout  server  1m',
    'option   redispatch',
    'balance  roundrobin'
  ],
  $haproxy_global_log      = [
    'log     127.0.0.1 local0',
    'log     127.0.0.1 local1 notice'
  ],
  $haproxy_extra_sections  = {
    'listen stats :3213' => [
      'mode http',
      'stats enable',
      'stats uri /',
      'stats refresh 5s',
    ]
  },
  $extra_config = {},
  $extra_init_lines = [],
) inherits synapse::params {

  class { 'synapse::install': } ->
  class { 'synapse::config':
    haproxy_daemon         => $haproxy_daemon,
    haproxy_reload_command => $haproxy_reload_command,
    haproxy_bind_address   => $haproxy_bind_address,
    haproxy_config_path    => $haproxy_config_path,
    extra_config           => $extra_config,
  }

  if str2bool($service_manage) {
    class { 'synapse::system_service':
      subscribe => [
        Class['synapse::install'],
        Class['synapse::config'],
      ],
    }
  }

}
