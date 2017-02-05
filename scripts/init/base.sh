#!/bin/sh
#exit on error
set -e

#install git
/usr/bin/apt-get update
/usr/bin/apt-get --yes install git

#install puppet
/usr/bin/wget --output-document=/tmp/puppetlabs-release-pc1-trusty.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
/usr/bin/dpkg -i /tmp/puppetlabs-release-pc1-trusty.deb
/usr/bin/apt-get update
/usr/bin/apt-get --yes install puppet-agent

#sudo /opt/puppetlabs/bin/puppet apply --verbose --modulepath=puppet/modules puppet/manifests/test.pp
