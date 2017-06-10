#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-`lsb_release -cs`.deb || exit 1
sudo dpkg -i puppetlabs-release-pc1-`lsb_release -cs`.deb
sudo apt-get update
sudo apt-get install puppet-agent
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-inifile
sudo /opt/puppetlabs/bin/puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/
