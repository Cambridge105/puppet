#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
sudo dpkg -i puppetlabs-release-wheezy.deb
sudo apt-get update
sudo apt-get install puppet
sudo puppet module install puppetlabs-vcsrepo
sudo puppet module install puppetlabs-inifile
sudo puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/
