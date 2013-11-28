#synapse
[![Build Status](https://travis-ci.org/solarkennedy/puppet-synapse.png)](https://travis-ci.org/solarkennedy/puppet-synapse)

## Description

This puppet module configures [Synapse](https://github.com/airbnb/synapse), a service discovery system by Airbnb. 
Synapse configures a local HAproxy running on every node, configured dynamically from Zookeeper entries.

##Installation

    puppet module install KyleAnderson/synapse
    # Or librarian-puppet, r10k, whatever.

###What this module affects

* /etc/synapse/ for configs
* Installs synapse (either via gem or system package
* Installs and configures HAproxy

###HAproxy considerations

This puppet module is tightly bound to the [Puppetlabs HAProxy](https://github.com/puppetlabs/puppetlabs-haproxy) module.

This is because *synapse* is tighly bound to it. There is no expectation here in this module that there is non-synapse controlled HAProxy stuff going on. 

##Usage


##Limitations


##Development
Open an [issue](https://github.com/solarkennedy/puppet-synapse/issues) or 
[fork](https://github.com/solarkennedy/puppet-synapse/fork) and open a 
[Pull Request](https://github.com/solarkennedy/puppet-synapse/pulls)
