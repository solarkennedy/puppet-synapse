# == Define: nerve::register
#
# Sets up a nerve configuration file to register a particular service
#
# == Parameters
#
# [*port*]
#   Port on the local side that the service is exposing. No default.
#
define synapse::service (
  $target        = "/etc/synapse/conf.d/${name}.json"
) {

  include stdlib
  validate_absolute_path($target)

  file { $target:
    ensure  => $ensure,
    owner   => 'root',
    mode    => '0444',
    content => template('synapse/service.json.erb'),
  }

}
