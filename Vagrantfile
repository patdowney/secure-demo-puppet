# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.box = "puppetlabs/debian-8.2-64-puppet"
   config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

   config.vm.provision "shell", inline: "apt-get update"

  servers = {
    'ca' => { 'role' => 'ca', 'ip' => '172.10.10.10' },
    'config01'   => { 'role' => 'config_server', 'ip' => '172.10.10.16' },
    'config02'   => { 'role' => 'config_server', 'ip' => '172.10.10.17' },
    'config03'   => { 'role' => 'config_server', 'ip' => '172.10.10.18' },
    'configui01' => { 'role' => 'config_ui',     'ip' => '172.10.10.20' },
  }

  servers.each_with_index do |server_properties, i|
    name = server_properties.first
    role = server_properties.last['role']
    private_ip = server_properties.last['ip']

    config.vm.define "#{name}" do |server|
      server.vm.hostname = "#{name}"
      server.vm.network "private_network", ip: private_ip

      server.vm.provision "shell", inline: "mkdir -p /etc/facter/facts.d ; echo 'role=#{role}' > /etc/facter/facts.d/role.txt"
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
        puppet.facter = {
          "primary_auth_key" => "0123456789ABCDEF0123456789ABCDEF",
          "consul_encrypt_key" => "71NuxGFXa727cmXKV/XD1Q=="
        }
      end
# END BLOCK
    end
  end
end
