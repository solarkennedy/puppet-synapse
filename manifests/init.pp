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
) inherits synapse::params {

  class { 'synapse::install': } ->
  class { 'synapse::config': } ~>
  class { 'synapse::service': } ->
  Class['synapse']

}
