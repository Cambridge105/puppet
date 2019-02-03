#!/bin/bash
if (grep -q -i arm /proc/cpuinfo); then
	# No ARM release of recent Puppet agent, so need to compile it ourselves...
	echo "Beginning set up. This compiles from source so will likely take a long time..."
	# add puppet repo
	mkdir setup-temp
	cd setup-temp

	apt-get update || exit 1
	apt-get install ruby-full facter hiera unzip -y || exit 1
	gem install bundler

	wget https://github.com/puppetlabs/puppet/archive/5.5.10.tar.gz || exit 1
	tar xzf 5.5.10.tar.gz || exit 1
	cd puppet-5.5.10

	bundle install --path .bundle/gems || exit 1
	bundle update || exit 1
	ruby install.rb || exit 1
else
	# Use the official builds of the agent for x86 / x64
	wget https://apt.puppetlabs.com/puppet5-release-${RELEASE_NAME}.deb || exit 1
    dpkg -i puppet5-release-${RELEASE_NAME}.deb || exit 1
    apt-get update || exit 1
	apt-get install puppet-agent || exit 1
fi

# Note: we used to add /opt/puppetlabs/bin to the path here, but it would seem Puppet 5.5 at least puts it in /usr/bin/puppet anyway, so no need...

sudo /opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-inifile
sudo /opt/puppetlabs/bin/puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/:/etc/puppetlabs/code/environments/production/modules/
