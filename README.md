Cambridge 105 Puppet Config
===========================

Assumptions:
- Hostname already set (in /etc/hostname, and rebooted)
- Pi set to boot into graphical UI as Pi user (set in raspi-config or at first run)
- This repo cloned somewhere local (until I get around to setting up a puppet master)
- pi user's password changed to something sensible
- Repos required are public. If we want to clone private repos, we'll have to set up a puppet master and hiera with eyaml support.

Clone this repo, and run `bash setup.sh` from this folder. It should download the latest puppet 3.x agent, a few required modules, and run it.

To apply updates, run (from this directory):

  git pull && sudo puppet apply manifests/site.pp --modulepath=modules/:/etc/puppet/modules/
