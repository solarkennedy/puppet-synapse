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
  $haproxy_ensure   = $synapse::params::haproxy_ensure, 
  $user             = $synapse::params::user,
  $group            = $synapse::params::group,
  $stats_socket     = $synapse::params::stats_socket,
  $haproxy_daemon   = true
) inherits synapse::params {

  class { 'synapse::install': } ->
  class { 'synapse::config':
    haproxy_daemon => $haproxy_daemon
  }
  if str2bool($service_manage) {
    Class['synapse::config'] ~>
    class { 'synapse::system_service': }
  }
}

