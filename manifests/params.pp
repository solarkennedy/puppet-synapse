# == Class synapse::params
#
# This class is meant to be called from synapse
# It sets variables according to platform
#
class synapse::params {
  
  case $::osfamily {
    'Debian','RedHat','Amazon': {
      # Right now, requires 0.7.0
      $package_ensure   = '0.7.0'
      # Allow logic to change based on requested provider
      $package_name     = undef
      $package_provider = undef
      $service_manage   = true
      $service_ensure   = 'running'
      $service_enable   = true
      $config_file      = '/etc/synapse/synapse.conf.json'
      $config_dir       = '/etc/synapse/conf.d/'
      $purge_config     = true
      $instance_id      = $::fqdn
      $haproxy_ensure   = 'present'
      $user             = 'haproxy'
      $group            = 'haproxy'
      $stats_socket     = '/var/lib/haproxy/stats'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
