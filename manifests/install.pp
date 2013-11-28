# == Class synapse::intall
#
class synapse::install {
  include synapse::params

  package { $synapse::params::package_name:
    ensure => present,
  }
}
