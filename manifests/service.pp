# == Class synapse::service
#
# This class is meant to be called from synapse
# It ensure the service is running
#
class synapse::service {
  include synapse::params

  service { $synapse::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
