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
      $service_ensure   = 'running'
      $service_enable   = true
      $config_file      = '/etc/nerve/nerve.conf.json'
      $config_dir       = '/etc/nerve/conf.d/'
      $purge_config     = true
      $instance_id      = $::fqdn
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
