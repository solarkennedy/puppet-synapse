#synapse

[![Build Status](https://travis-ci.org/solarkennedy/puppet-synapse.png?branch=master)](https://travis-ci.org/solarkennedy/puppet-synapse)

## Description

This puppet module configures [Synapse](https://github.com/airbnb/synapse), a
service discovery system by Airbnb.  Synapse configures a local HAproxy running
on every node, configured dynamically from Zookeeper entries.

##Installation

```
puppet module install KyleAnderson/synapse
# Or librarian-puppet, r10k, whatever.
```

### What this module affects

* /etc/synapse/ for configs
* Installs synapse (either via gem or system package
* Installs and configures HAproxy

### HAproxy considerations

This module is incompatible with an existing instance of HAProxy running.
Synapse overwrites the HAProxy config file.

## Usage Examples

Start off by getting synapse installed and running:

```puppet
class { 'synapse':
  package_provider => 'gem'
}
```

Now you can prep synapse for listening for services. Syntax is a little tricky,
but follows the syntax in
[example configs](https://github.com/airbnb/synapse/blob/master/config/synapse_services/service2.json).
All parameters are validated, so puppet won't let you insert invalid syntax:

```puppet
synapse::service { 'service1':
  ensure => 'present',
  default_servers => [
    {
      "name" => "default1",
      "host" => "localhost",
      "port" => 8422
    }
  ],
  discovery => {
    "method" => "zookeeper",
    "path"   => "/airbnb/service/service2",
    "hosts"  =>  [
      "zk0.airbnb.com:2181",
      "zk1.airbnb.com:2181"
    ]
  },
  haproxy => {
    "port"           => '3214',
    "server_options" => "check inter 2s rise 3 fall 2",
    "listen"         => [
      "mode http",
      "option httpchk /health",
    ]
  },
}
```

## Limitations

I assume that you are using a modern version of ruby on the puppetmaster. It
outputs json, so either use ruby 1.9 with built in JSON or have the JSON gem
available.  Pull requests welcome for a better way to do this.

##Development
Open an [issue](https://github.com/solarkennedy/puppet-synapse/issues) or 
[fork](https://github.com/solarkennedy/puppet-synapse/fork) and open a 
[Pull Request](https://github.com/solarkennedy/puppet-synapse/pulls)
