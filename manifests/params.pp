# == Class synapse::params
#
# This class is meant to be called from synapse
# It sets variables according to platform
#
class synapse::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'synapse'
      $service_name = 'synapse'
    }
    'RedHat', 'Amazon': {
      $package_name = 'synapse'
      $service_name = 'synapse'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
