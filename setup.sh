#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "Usage: sudo bash setup.sh" 1>&2
   exit 1
fi

# Make sure we have a sensible hostname
if [ -z "$NEWHOSTNAME" ]; then
    read -p "Enter a hostname for this machine: " NEWHOSTNAME
fi
echo "Using new hostname from NEWHOSTNAME: $NEWHOSTNAME"
hostname $NEWHOSTNAME
echo $NEWHOSTNAME > /etc/hostname

# Puppet don't ship a nice package for ARM, but we can do it by installing the Ruby gem instead...
apt update
apt install ruby-full -y
gem install puppet --version '~> 6' --no-rdoc --no-ri

# These modules are normally baked into the agent install, but since we aren't using the
# official packages on ARM, install them manually...
# https://github.com/puppetlabs/puppet-specifications/blob/master/moving_modules.md
puppet module install puppetlabs-augeas_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-cron_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-host_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-k5login_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-mailalias_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-maillist_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-mount_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-nagios_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-selinux_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-sshkeys_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-yumrepo_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-zfs_core --target-dir /opt/puppetlabs/puppet/vendor_modules/
puppet module install puppetlabs-zone_core --target-dir /opt/puppetlabs/puppet/vendor_modules/

# Extra modules we require...
puppet module install puppetlabs-vcsrepo
puppet module install puppetlabs-inifile

# And finally, the first puppet run!
puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/:/etc/puppetlabs/code/environments/production/modules/
