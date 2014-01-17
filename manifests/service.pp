# == Define: synapse::service
#
# Sets up a synapse configuration file to expose a particular service
#
# == Parameters
#
# [*default_servers*]
#  Fallback servers to use if synapse cannot discovery anything
#  Must be an array of hashes:
#
#   default_servers => [
#       {
#         "name" => "default-db",
#         "host" => "mydb.example.com",
#         "port" => 5432
#       }
#     ]
# 
# [*discovery*]
#  How synapse discovers hosts for the service.
#  Must be a hash.
#
#    discovery => {
#      "method" => "zookeeper",
#      "path"   => "/airbnb/service/service2",
#      "hosts"  => [
#        "zk0.airbnb.com:2181",
#        "zk1.airbnb.com:2181"
#      ]
#    },
#
# [*haproxy*]
#  How synapse will configure haproxy's backend
#  Must be a hash.
#
#    haproxy => {
#      "port"           => '3214',
#      "server_options" => "check inter 2s rise 3 fall 2",
#      "listen"         => [
#        "mode http",
#        "option httpchk /health"
#      ]
#    }
#
# [*ensure*]
#  Controls if the file is present or absent.
#
# [*target*]
#  Defaults to /etc/synapse/conf.d/${name}.json
#
define synapse::service (
  $default_servers,
  $discovery,
  $haproxy,
  $ensure = 'present',
  $target = "/etc/synapse/conf.d/${name}.json",
) {

  include stdlib
  validate_array($default_servers)
  validate_hash($discovery)
  validate_hash($haproxy)
  validate_absolute_path($target)

  file { $target:
    ensure  => $ensure,
    owner   => 'root',
    mode    => '0444',
    content => template('synapse/service.json.erb'),
  }

  if str2bool($synapse::service_manage) {
    File[$target] ~> Service['synapse']
  }

}

