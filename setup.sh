#!/bin/bash
# Make sure we have a sensible hostname
if [ -z "$NEWHOSTNAME" ]; then
    read -p "Enter a hostname for this machine: " NEWHOSTNAME
fi
echo "Using new hostname from NEWHOSTNAME: $NEWHOSTNAME"
hostname $NEWHOSTNAME
echo $NEWHOSTNAME > /etc/hostname

RELEASE_NAME=`lsb_release -c -s`
wget https://apt.puppetlabs.com/puppet6-release-${RELEASE_NAME}.deb || exit 1
dpkg -i puppet6-release-${RELEASE_NAME}.deb || exit 1
apt-get update || exit 1
apt-get install puppet-agent || exit 1

# Note: we used to add /opt/puppetlabs/bin to the path here, but it would seem Puppet 5.5 at least puts it in /usr/bin/puppet anyway, so no need...

sudo /opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-inifile
sudo /opt/puppetlabs/bin/puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/:/etc/puppetlabs/code/environments/production/modules/
