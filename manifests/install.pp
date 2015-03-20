# == Class synapse::intall
#
class synapse::install {

  if ! $synapse::package_name {
    # In the case where a package name is not specified
    # Try to guess what the package name should be based on the provider
    case $synapse::package_provider {
      'gem','Gem': { $package_name = 'synapse' }
      default:     { $package_name = 'rubygem-synapse' }
    }
  } else {
    # Use the package name they asked for
    $package_name = $synapse::package_name
  }

  if $synapse::haproxy_ensure != 'unmanaged' {
    package { 'haproxy':
      ensure => $synapse::haproxy_ensure
    } -> Package['synapse']
  }
  package { 'synapse':
    ensure   => $synapse::package_ensure,
    name     => $package_name,
    provider => $synapse::package_provider,
  }

}
