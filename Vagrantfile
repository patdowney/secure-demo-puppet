# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.box = "puppetlabs/debian-8.2-64-puppet"
   config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

   config.vm.provision "shell", inline: "apt-get update"


  [ 'ca' ].each_with_index do |s,i|
    config.vm.define "#{s}-server" do |server|
      server.vm.hostname = "#{s}-server"
      server.vm.network "private_network", ip: "172.10.10.#{10 + i}"

      server.vm.provision "shell", inline: "mkdir -p /etc/facter/facts.d ; echo 'role=#{s}' > /etc/facter/facts.d/role.txt"
      server.vm.provision "shell", inline: "echo 'env=vagrant' > /etc/facter/facts.d/env.txt"

# comment out the following to test debian package bit
# START BLOCK
  config.vm.synced_folder "../secure-demo-hiera/", "/etc/hiera"

      server.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "manifests" 
        puppet.manifest_file = "site.pp"
        puppet.module_path = ["vendor/modules", "modules"]
        puppet.environment = "production"
        puppet.environment_path = "../.."
        puppet.hiera_config_path = "../demo-hiera/hiera.yaml"
#        puppet.options = [ "--verbose", "--debug" ]
      end
# END BLOCK
    end
  end
end
